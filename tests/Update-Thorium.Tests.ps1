<#
.SYNOPSIS
    Pester tests for Update-Thorium.ps1
.DESCRIPTION
    Comprehensive test suite covering core functions:
    - Compare-Versions (version comparison logic)
    - Get-CpuTarget (CPU architecture detection)
    - Test-DiskSpace (disk space verification)
    - Invoke-RestMethodWithRetry (API retry logic)
    - Test-FileSignature (digital signature verification)
#>

Describe "Update-Thorium" {
    BeforeAll {
        $scriptPath = Join-Path -Path $PSScriptRoot -ChildPath '..\Update-Thorium.ps1'
        $scriptContent = Get-Content $scriptPath -Raw
        $mainIndex = $scriptContent.IndexOf('# --- Main ---')
        if ($mainIndex -gt 0) {
            $scriptContent = $scriptContent.Substring(0, $mainIndex)
        }
        $scriptBlock = [ScriptBlock]::Create($scriptContent)
        Invoke-Expression $scriptContent
        $strings = $englishStrings
    }

    # =============================================
    # Compare-Versions
    # =============================================
    Describe "Compare-Versions" {
        It "should return -1 when first version is older (standard)" {
            Compare-Versions "123.0.0.1" "123.0.0.2" | Should -Be -1
        }

        It "should return 1 when first version is newer (standard)" {
            Compare-Versions "123.0.0.2" "123.0.0.1" | Should -Be 1
        }

        It "should return 0 for identical standard versions" {
            Compare-Versions "150.0.0" "150.0.0" | Should -Be 0
        }

        It "should handle letter prefix M150 vs M151" {
            Compare-Versions "M150" "M151" | Should -Be -1
        }

        It "should handle letter prefix M150 vs M150 (equal)" {
            Compare-Versions "M150" "M150" | Should -Be 0
        }

        It "should handle v prefix v1.0.0 vs v1.0.1" {
            Compare-Versions "v1.0.0" "v1.0.1" | Should -Be -1
        }

        It "should handle v prefix v1.0.0 vs v1.0.0 (equal)" {
            Compare-Versions "v1.0.0" "v1.0.0" | Should -Be 0
        }

        It "should treat M150 equal to 150.0.0" {
            Compare-Versions "M150" "150.0.0" | Should -Be 0
        }

        It "should treat 150 equal to 150.0.0" {
            Compare-Versions "150" "150.0.0" | Should -Be 0
        }

        It "should correctly compare 99.0.0 < 120.0.0 (original bug fix)" {
            Compare-Versions "99.0.0" "120.0.0" | Should -Be -1
        }

        It "should correctly compare 120.0.0 > 99.0.0" {
            Compare-Versions "120.0.0" "99.0.0" | Should -Be 1
        }

        It "should handle complex version tags" {
            Compare-Versions "150.0.7204.303" "150.0.7204.304" | Should -Be -1
        }

        It "should handle 4-component versions" {
            Compare-Versions "1.2.3.4" "1.2.3.5" | Should -Be -1
        }

        It "should return 0 for identical complex versions" {
            Compare-Versions "1.2.3.4" "1.2.3.4" | Should -Be 0
        }

        It "should handle single number versions" {
            Compare-Versions "5" "10" | Should -Be -1
        }

        It "should handle empty string fallback" {
            $result = Compare-Versions "" "1.0.0"
            $result | Should -Not -Be 0
        }
    }

    # =============================================
    # Get-CpuTarget
    # =============================================
    Describe "Get-CpuTarget" {
        It "should detect AVX2 for Intel Core i7" {
            Mock Get-CimInstance { return [PSCustomObject]@{ Name = 'Intel(R) Core(TM) i7-12700K' } }
            $result = Get-CpuTarget
            $result.Tag | Should -Be 'AVX2'
        }

        It "should detect AVX2 for Intel Core i9" {
            Mock Get-CimInstance { return [PSCustomObject]@{ Name = 'Intel(R) Core(TM) i9-13900K' } }
            $result = Get-CpuTarget
            $result.Tag | Should -Be 'AVX2'
        }

        It "should detect AVX2 for AMD Ryzen" {
            Mock Get-CimInstance { return [PSCustomObject]@{ Name = 'AMD Ryzen 7 5800X' } }
            $result = Get-CpuTarget
            $result.Tag | Should -Be 'AVX2'
        }

        It "should detect SSE4 for Intel Celeron" {
            Mock Get-CimInstance { return [PSCustomObject]@{ Name = 'Intel Celeron N4000' } }
            $result = Get-CpuTarget
            $result.Tag | Should -Be 'SSE4'
        }

        It "should detect SSE4 for Intel Pentium" {
            Mock Get-CimInstance { return [PSCustomObject]@{ Name = 'Intel Pentium Gold G6400' } }
            $result = Get-CpuTarget
            $result.Tag | Should -Be 'SSE4'
        }

        It "should detect SSE4 for AMD Athlon (older)" {
            Mock Get-CimInstance { return [PSCustomObject]@{ Name = 'AMD Athlon 3000G' } }
            $result = Get-CpuTarget
            $result.Tag | Should -Be 'SSE4'
        }

        It "should return default for unknown CPU" {
            Mock Get-CimInstance { return [PSCustomObject]@{ Name = 'Some Unknown CPU' } }
            $result = Get-CpuTarget
            $result.Tag | Should -Be 'mini_installer'
        }

        It "should return default on Get-CimInstance error" {
            Mock Get-CimInstance { throw 'Access denied' }
            $result = Get-CpuTarget
            $result.Tag | Should -Be 'mini_installer'
            $result.CpuName | Should -Be 'Unknown'
        }
    }

    # =============================================
    # Test-DiskSpace
    # =============================================
    Describe "Test-DiskSpace" {
        It "should return true when enough space" {
            Mock Get-PSDrive { return [PSCustomObject]@{ Free = 10GB } }
            Test-DiskSpace -Path "C:\test" -RequiredBytes 1GB | Should -Be $true
        }

        It "should return false when insufficient space" {
            Mock Get-PSDrive { return [PSCustomObject]@{ Free = 100MB } }
            Test-DiskSpace -Path "C:\test" -RequiredBytes 1GB | Should -Be $false
        }

        It "should return true when space exactly equals required (uses -gt)" {
            Mock Get-PSDrive { return [PSCustomObject]@{ Free = 1GB } }
            Test-DiskSpace -Path "C:\test" -RequiredBytes 1GB | Should -Be $false
        }

        It "should return true on Get-PSDrive error (fail-safe)" {
            Mock Get-PSDrive { throw 'Drive not found' }
            Test-DiskSpace -Path "C:\test" -RequiredBytes 1GB | Should -Be $true
        }
    }

    # =============================================
    # Invoke-RestMethodWithRetry
    # =============================================
    Describe "Invoke-RestMethodWithRetry" {
        It "should return result on successful first attempt" {
            Mock Invoke-RestMethod { return @{ releases = @() } }
            $result = Invoke-RestMethodWithRetry -Uri "https://api.github.com/test"
            $result | Should -Not -BeNullOrEmpty
        }

        It "should return result on successful second attempt" {
            $callCount = 0
            Mock Invoke-RestMethod {
                $script:callCount++
                if ($script:callCount -lt 2) { throw 'Network error' }
                return @{ releases = @() }
            }
            $result = Invoke-RestMethodWithRetry -Uri "https://api.github.com/test"
            $result | Should -Not -BeNullOrEmpty
        }

        It "should throw after all retries exhausted" {
            Mock Invoke-RestMethod { throw 'API error' }
            { Invoke-RestMethodWithRetry -Uri "https://api.github.com/test" -MaxRetries 3 } | Should -Throw
        }

        It "should make exactly 3 attempts with MaxRetries=3" {
            $script:callCount = 0
            Mock Invoke-RestMethod { $script:callCount++; throw 'Error' }
            { Invoke-RestMethodWithRetry -Uri "https://api.github.com/test" -MaxRetries 3 } | Should -Throw
            $script:callCount | Should -Be 3
        }

        It "should respect custom MaxRetries" {
            $script:callCount = 0
            Mock Invoke-RestMethod { $script:callCount++; throw 'Error' }
            { Invoke-RestMethodWithRetry -Uri "https://api.github.com/test" -MaxRetries 5 } | Should -Throw
            $script:callCount | Should -Be 5
        }

        It "should call Start-Sleep with exponential backoff (2s, 4s)" {
            $script:callCount = 0
            $script:sleepDurations = @()
            Mock Invoke-RestMethod { $script:callCount++; throw 'Error' }
            Mock Start-Sleep { $script:sleepDurations += $Seconds }
            { Invoke-RestMethodWithRetry -Uri "https://api.github.com/test" -MaxRetries 3 } | Should -Throw
            $script:sleepDurations | Should -Be @(2, 4)
        }

        It "should not call Start-Sleep after last attempt" {
            $script:callCount = 0
            $script:sleepDurations = @()
            Mock Invoke-RestMethod { $script:callCount++; throw 'Error' }
            Mock Start-Sleep { $script:sleepDurations += $Seconds }
            { Invoke-RestMethodWithRetry -Uri "https://api.github.com/test" -MaxRetries 2 } | Should -Throw
            $script:sleepDurations | Should -Be @(2)
        }
    }

    # =============================================
    # Test-FileSignature
    # =============================================
    Describe "Test-FileSignature" {
        It "should return true for valid signature" {
            Mock Get-AuthenticodeSignature { return [PSCustomObject]@{ Status = 'Valid' } }
            $result = Test-FileSignature -FilePath "C:\test.exe"
            $result | Should -Be $true
        }

        It "should return false for NotSigned status" {
            Mock Get-AuthenticodeSignature { return [PSCustomObject]@{ Status = 'NotSigned' } }
            $result = Test-FileSignature -FilePath "C:\test.exe"
            $result | Should -Be $false
        }

        It "should return false for UnknownError status" {
            Mock Get-AuthenticodeSignature { return [PSCustomObject]@{ Status = 'UnknownError' } }
            $result = Test-FileSignature -FilePath "C:\test.exe"
            $result | Should -Be $false
        }

        It "should return false when Get-AuthenticodeSignature throws" {
            Mock Get-AuthenticodeSignature { throw 'Access denied' }
            $result = Test-FileSignature -FilePath "C:\test.exe"
            $result | Should -Be $false
        }
    }
}
