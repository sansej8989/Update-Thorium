Clear-Host

# --- UI Configuration ---
$Title = "--- ОНОВЛЮВАЧ THORIUM ---"
$Line  = "-" * 50

function Show-Header {
    Write-Host "`n$Line" -ForegroundColor Cyan
    Write-Host "  $Title" -ForegroundColor Cyan
    Write-Host "$Line`n" -ForegroundColor Cyan
}

function Show-Spinner {
    param ([string]$Message)
    $spinnerChars = @('|', '/', '-', '\')
    $iterations = 12
    Write-Host -NoNewline "[*] $Message " -ForegroundColor Yellow
    for ($i = 0; $i -lt $iterations; $i++) {
        foreach ($char in $spinnerChars) {
            Write-Host -NoNewline "`b$char" -ForegroundColor Yellow
            Start-Sleep -Milliseconds 50
        }
    }
    Write-Host "`b " 
}

function Write-Log {
    param (
        [string]$Message,
        [ValidateSet('Info', 'Warning', 'Error', 'Success')]
        [string]$Level = 'Info'
    )
    
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logFile = Join-Path $env:TEMP "Thorium-Updater.log"
    $logEntry = "[$timestamp] [$Level] $Message"
    
    Add-Content -Path $logFile -Value $logEntry -ErrorAction SilentlyContinue
}

# --- CPU Architecture & Target Detection ---
function Get-CpuTarget {
    try {
        $cpuInfo = Get-CimInstance -ClassName Win32_Processor -ErrorAction Stop | Select-Object -First 1
        $cpuName = $cpuInfo.Name
        
        Write-Log "Detected CPU: $cpuName" -Level Info
        
        if ($cpuName -match "Ryzen" -or $cpuName -match "i3-|i5-|i7-|i9-") {
            return @{ Name = "AVX2 (Modern)"; Tag = "AVX2"; CpuName = $cpuName }
        } elseif ($cpuName -match "Athlon" -or $cpuName -match "Celeron" -or $cpuName -match "Pentium") {
            return @{ Name = "SSE4.1 / AVX (Value/Older CPU)"; Tag = "SSE4.1"; CpuName = $cpuName }
        } else {
            return @{ Name = "Windows Default"; Tag = "mini_installer"; CpuName = $cpuName }
        }
    } catch {
        Write-Log "Error detecting CPU: $_" -Level Error
        return @{ Name = "Windows Default"; Tag = "mini_installer"; CpuName = "Unknown" }
    }
}

function Compare-Versions {
    param (
        [string]$Version1,
        [string]$Version2
    )
    
    try {
        $v1 = [System.Version]::Parse($Version1)
        $v2 = [System.Version]::Parse($Version2)
        return $v1.CompareTo($v2)
    } catch {
        Write-Log "Version comparison error: $_ (V1: $Version1, V2: $Version2)" -Level Warning
        # Fallback to string comparison if version parsing fails
        return [string]::Compare($Version1, $Version2)
    }
}

function Test-DiskSpace {
    param (
        [string]$Path,
        [int64]$RequiredBytes
    )
    
    try {
        $drive = [System.IO.Path]::GetPathRoot($Path)
        $driveInfo = Get-PSDrive -Name $drive.TrimEnd(':\') -ErrorAction Stop
        $freeSpace = $driveInfo.Free
        
        return $freeSpace -gt $RequiredBytes
    } catch {
        Write-Log "Error checking disk space: $_" -Level Warning
        return $true  # Assume sufficient space if check fails
    }
}

function Get-FileHashSafe {
    param (
        [string]$FilePath,
        [string]$Algorithm = "SHA256"
    )
    
    try {
        $hash = Get-FileHash -Path $FilePath -Algorithm $Algorithm -ErrorAction Stop
        return $hash.Hash
    } catch {
        Write-Log "Error calculating file hash: $_" -Level Error
        return $null
    }
}

# --- Main Logic ---
Show-Header
Write-Log "=== Thorium Updater Started ===" -Level Info

# 1. System Analysis
$cpuTarget = Get-CpuTarget

Write-Host "[*] Аналіз вашої системи..." -ForegroundColor Gray
Write-Host "[+] Ваш процесор: $($cpuTarget.CpuName)" -ForegroundColor DarkGray
Write-Host "[+] Рекомендована збірка Thorium: $($cpuTarget.Name)" -ForegroundColor Yellow
Write-Host $Line -ForegroundColor Gray

# 2. Find Thorium
$localPaths = @(
    "$env:LOCALAPPDATA\Thorium\Application\thorium.exe",
    "$env:ProgramFiles\Thorium\Application\thorium.exe"
)

$thoriumPath = $null
foreach ($path in $localPaths) {
    if (Test-Path $path) { 
        $thoriumPath = $path
        Write-Log "Found Thorium at: $path" -Level Info
        break 
    }
}

if (-not $thoriumPath) {
    Write-Host "[X] Локальну інсталяцію Thorium не знайдено!" -ForegroundColor Red
    Write-Log "Thorium installation not found" -Level Error
    Write-Host $Line -ForegroundColor Cyan
    Read-Host "Натисніть ENTER для виходу..."
    Exit
}

try {
    $localVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($thoriumPath).FileVersion
    Write-Host "[+] Ваша поточна версія: $localVersion" -ForegroundColor Green
    Write-Log "Current version: $localVersion" -Level Info
} catch {
    Write-Host "[X] Помилка читання локальної версії: $_" -ForegroundColor Red
    Write-Log "Error reading local version: $_" -Level Error
    Read-Host "Натисніть ENTER для виходу..."
    Exit
}

Write-Host $Line -ForegroundColor Gray

# 3. Check GitHub API
Show-Spinner "Перевірка останньої версії на GitHub..."

try {
    $repoUrl = "https://api.github.com/repos/Alex313031/thorium/releases/latest"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    
    $release = Invoke-RestMethod -Uri $repoUrl -UseBasicParsing -ErrorAction Stop
    
    $latestVersionRaw = $release.tag_name
    $latestVersion = ($latestVersionRaw -replace '[^0-9.]', '').Trim('.')
    $cleanLocalVersion = ($localVersion -replace '[^0-9.]', '').Trim('.')

    Write-Log "Latest version from GitHub: $latestVersionRaw" -Level Info

    # Find matching asset
    $searchPattern = "*$($cpuTarget.Tag)*.exe"
    $matchingAsset = $release.assets | Where-Object { 
        $_.name -like $searchPattern -and $_.name -notlike "*mini*" 
    } | Select-Object -First 1
    
    if (-not $matchingAsset) {
        $matchingAsset = $release.assets | Where-Object { 
            $_.name -like "*mini_installer.exe" 
        } | Select-Object -First 1
    }

    # Check if any Windows installers exist at all
    $windowsInstallers = $release.assets | Where-Object { $_.name -like "*.exe" }
    
    if (-not $matchingAsset) {
        if (-not $windowsInstallers -or $windowsInstallers.Count -eq 0) {
            Write-Host "`r[!] Windows інсталятори не знайдено в цьому релізі." -ForegroundColor Yellow
            Write-Host "[i] Цей реліз містить тільки Linux пакети (.deb, .rpm, .zip, .AppImage)" -ForegroundColor Gray
            Write-Host "[i] Windows збірки можуть бути доступні в іншому релізі." -ForegroundColor Gray
            Write-Log "No Windows installers in release $latestVersionRaw" -Level Warning
            throw "No Windows installers available in the latest release"
        } else {
            Write-Host "`r[!] Доступні Windows інсталятори:" -ForegroundColor Yellow
            $windowsInstallers | ForEach-Object { 
                Write-Host "    - $($_.name)" -ForegroundColor Gray 
            }
            Write-Log "No matching installer for CPU: $($cpuTarget.Tag)" -Level Warning
            throw "Не знайдено підходящого інсталятора для вашої архітектури процесора ($($cpuTarget.Tag))"
        }
    }

    $downloadUrl = $matchingAsset.browser_download_url
    $fileName = $matchingAsset.name
    $fileSize = [math]::Round($matchingAsset.size / 1MB, 2)

    Write-Host "`r[+] Остання версія на GitHub: $latestVersionRaw" -ForegroundColor Yellow
    Write-Host "[+] Розмір інсталятора: $fileSize МБ" -ForegroundColor DarkGray
    Write-Host $Line -ForegroundColor Gray

    # 4. Compare Versions (Fixed)
    $versionComparison = Compare-Versions -Version1 $cleanLocalVersion -Version2 $latestVersion
    
    if ($versionComparison -ge 0) {
        Write-Host "[OK] У вас встановлена остання версія! Оновлення не потрібне.`n" -ForegroundColor Green
        Write-Log "Already up to date" -Level Success
        [Console]::Beep(550, 250)
    } 
    else {
        Write-Host "[!] Знайдено нове оновлення для вашої архітектури процесора!" -ForegroundColor Cyan
        Write-Host "Цільовий файл: $fileName" -ForegroundColor DarkGray
        Write-Log "Update available: $latestVersionRaw" -Level Info
        
        [Console]::Beep(600, 150)
        [Console]::Beep(800, 200)

        Write-Host ""
        $choice = Read-Host "[?] Завантажити та встановити це оновлення? (y/n)"
        
        if ($choice -eq 'y' -or $choice -eq 'Y') {
            
            # Check disk space (require 2x file size for safety)
            $requiredSpace = $matchingAsset.size * 2
            $downloadPath = Join-Path $env:USERPROFILE "Downloads"
            
            if (-not (Test-DiskSpace -Path $downloadPath -RequiredBytes $requiredSpace)) {
                Write-Host "[X] Недостатньо місця на диску!" -ForegroundColor Red
                Write-Log "Insufficient disk space" -Level Error
                Read-Host "Натисніть ENTER для виходу..."
                Exit
            }

            # Check Running Browser
            $thoriumProcesses = Get-Process -Name "thorium" -ErrorAction SilentlyContinue
            if ($thoriumProcesses) {
                Write-Host "`n[!] Thorium зараз запущений." -ForegroundColor Yellow
                $closeChoice = Read-Host "[?] Закрити Thorium автоматично для запобігання помилок встановлення? (y/n)"
                if ($closeChoice -eq 'y' -or $closeChoice -eq 'Y') {
                    Write-Host "[*] Закриття Thorium..." -ForegroundColor Gray
                    Write-Log "Closing Thorium processes" -Level Info
                    Stop-Process -Name "thorium" -Force
                    Start-Sleep -Seconds 2
                }
            }

            $targetPath = Join-Path $downloadPath $fileName
            
            # Remove old installer if exists
            if (Test-Path $targetPath) {
                Write-Host "[*] Видалення старого інсталятора..." -ForegroundColor Gray
                Remove-Item -Path $targetPath -Force -ErrorAction SilentlyContinue
            }

            Write-Host "`n[*] Завантаження оновлення..." -ForegroundColor Cyan
            Write-Log "Starting download: $downloadUrl" -Level Info
            
            try {
                # Download with progress
                $ProgressPreference = 'SilentlyContinue'
                Invoke-WebRequest -Uri $downloadUrl -OutFile $targetPath -UserAgent "Mozilla/5.0" -ErrorAction Stop
                $ProgressPreference = 'Continue'
                
                Write-Host "[+] Завантаження завершено!" -ForegroundColor Green
                Write-Log "Download completed: $targetPath" -Level Success
                
                # Verify file exists and has content
                if (-not (Test-Path $targetPath)) {
                    throw "Завантажений файл не знайдено"
                }
                
                $downloadedSize = (Get-Item $targetPath).Length
                if ($downloadedSize -eq 0) {
                    throw "Завантажений файл порожній"
                }
                
                Write-Host "[*] Перевірка цілісності завантаження..." -ForegroundColor Gray
                $fileHash = Get-FileHashSafe -FilePath $targetPath
                if ($fileHash) {
                    Write-Host "[+] Хеш файлу (SHA256): $($fileHash.Substring(0, 16))..." -ForegroundColor DarkGray
                    Write-Log "File hash: $fileHash" -Level Info
                }
                
                Write-Host "[*] Запуск інсталятора... Слідуйте інструкціям у вікні." -ForegroundColor Yellow
                Write-Log "Launching installer" -Level Info
                
                Start-Process -FilePath $targetPath -Wait
                
                Write-Host "`n[+] Готово! Thorium успішно оновлено." -ForegroundColor Green
                Write-Log "Installation completed successfully" -Level Success
                
                # Victory sound
                [Console]::Beep(523, 150); [Console]::Beep(659, 150); [Console]::Beep(784, 300)
                
                # Optional: Clean up installer
                Write-Host "[*] Очищення файлу інсталятора..." -ForegroundColor Gray
                Start-Sleep -Seconds 1
                Remove-Item -Path $targetPath -Force -ErrorAction SilentlyContinue
                
            } catch {
                Write-Host "`n[X] Помилка завантаження або встановлення: $_" -ForegroundColor Red
                Write-Log "Download/installation error: $_" -Level Error
                [Console]::Beep(200, 500)
                
                # Clean up failed download
                if (Test-Path $targetPath) {
                    Remove-Item -Path $targetPath -Force -ErrorAction SilentlyContinue
                }
            }
        } else {
            Write-Host "`n[-] Оновлення пропущено." -ForegroundColor Gray
            Write-Log "Update skipped by user" -Level Info
        }
    }

} catch {
    Write-Host "`r[X] Помилка підключення до GitHub API: $_" -ForegroundColor Red
    Write-Log "GitHub API error: $_" -Level Error
    [Console]::Beep(200, 500)
}

Write-Host $Line -ForegroundColor Cyan
Write-Host " Натисніть ENTER для виходу..." -ForegroundColor DarkGray
Write-Log "=== Thorium Updater Finished ===" -Level Info
Read-Host
