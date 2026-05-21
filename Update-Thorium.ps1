Clear-Host

# --- Language Configuration ---
$systemLanguage = $PSUICulture
$isUkrainian = $systemLanguage -eq 'uk-UA' -or $systemLanguage -eq 'uk'

# English strings (default)
$strings = @{
    Title = "--- THORIUM UPDATER ---"
    Line = "-" * 50
    AnalyzingSystem = "[*] Analyzing your system..."
    YourProcessor = "[+] Your processor: {0}"
    RecommendedBuild = "[+] Recommended Thorium build: {0}"
    ThoriumNotFound = "[X] Local Thorium installation not found!"
    CurrentVersion = "[+] Your current version: {0}"
    ErrorReadingVersion = "[X] Error reading local version: {0}"
    CheckingLatestVersion = "Checking latest version on GitHub..."
    LatestVersionGitHub = "[+] Latest version on GitHub: {0}"
    InstallerSize = "[+] Installer size: {0} MB"
    AlreadyUpToDate = "[OK] You have the latest version! No update needed.`n"
    UpdateAvailable = "[!] Found new update for your CPU architecture!"
    TargetFile = "Target file: {0}"
    DownloadAndInstall = "[?] Download and install this update? (y/n)"
    InsufficientDiskSpace = "[X] Insufficient disk space!"
    ThoriumRunning = "`n[!] Thorium is currently running."
    CloseThoriumQuestion = "[?] Close Thorium automatically to prevent installation errors? (y/n)"
    ClosingThorium = "[*] Closing Thorium..."
    RemovingOldInstaller = "[*] Removing old installer..."
    DownloadingUpdate = "`n[*] Downloading update..."
    DownloadCompleted = "[+] Download completed!"
    VerifyingIntegrity = "[*] Verifying download integrity..."
    FileHash = "[+] File hash (SHA256): {0}..."
    LaunchingInstaller = "[*] Launching installer... Follow instructions in the window."
    UpdateCompleted = "`n[+] Done! Thorium successfully updated."
    CleaningInstaller = "[*] Cleaning up installer file..."
    DownloadError = "`n[X] Download or installation error: {0}"
    UpdateSkipped = "`n[-] Update skipped."
    NoWindowsInstallers = "`r[!] Windows installers not found in this release."
    OnlyLinuxPackages = "[i] This release contains only Linux packages (.deb, .rpm, .zip, .AppImage)"
    WindowsBuildsAvailable = "[i] Windows builds may be available in another release."
    AvailableInstallers = "`r[!] Available Windows installers:"
    NoMatchingInstaller = "No matching installer found for CPU: {0}"
    GitHubAPIError = "`r[X] GitHub API connection error: {0}"
    PressEnterToExit = " Press ENTER to exit..."
    FileNotFound = "Downloaded file not found"
    FileEmpty = "Downloaded file is empty"
}

# Ukrainian override
if ($isUkrainian) {
    $strings['Title'] = "--- ОНОВЛЮВАЧ THORIUM ---"
    $strings['AnalyzingSystem'] = "[*] Аналіз вашої системи..."
    $strings['YourProcessor'] = "[+] Ваш процесор: {0}"
    $strings['RecommendedBuild'] = "[+] Рекомендована збірка Thorium: {0}"
    $strings['ThoriumNotFound'] = "[X] Локальну інсталяцію Thorium не знайдено!"
    $strings['CurrentVersion'] = "[+] Ваша поточна версія: {0}"
    $strings['ErrorReadingVersion'] = "[X] Помилка читання локальної версії: {0}"
    $strings['CheckingLatestVersion'] = "Перевірка останньої версії на GitHub..."
    $strings['LatestVersionGitHub'] = "[+] Остання версія на GitHub: {0}"
    $strings['InstallerSize'] = "[+] Розмір інсталятора: {0} МБ"
    $strings['AlreadyUpToDate'] = "[OK] У вас встановлена остання версія! Оновлення не потрібне.`n"
    $strings['UpdateAvailable'] = "[!] Знайдено нове оновлення для вашої архітектури процесора!"
    $strings['TargetFile'] = "Цільовий файл: {0}"
    $strings['DownloadAndInstall'] = "[?] Завантажити та встановити це оновлення? (y/n)"
    $strings['InsufficientDiskSpace'] = "[X] Недостатньо місця на диску!"
    $strings['ThoriumRunning'] = "`n[!] Thorium зараз запущений."
    $strings['CloseThoriumQuestion'] = "[?] Закрити Thorium автоматично для запобігання помилок встановлення? (y/n)"
    $strings['ClosingThorium'] = "[*] Закриття Thorium..."
    $strings['RemovingOldInstaller'] = "[*] Видалення старого інсталятора..."
    $strings['DownloadingUpdate'] = "`n[*] Завантаження оновлення..."
    $strings['DownloadCompleted'] = "[+] Завантаження завершено!"
    $strings['VerifyingIntegrity'] = "[*] Перевірка цілісності завантаження..."
    $strings['FileHash'] = "[+] Хеш файлу (SHA256): {0}..."
    $strings['LaunchingInstaller'] = "[*] Запуск інсталятора... Слідуйте інструкціям у вікні."
    $strings['UpdateCompleted'] = "`n[+] Готово! Thorium успішно оновлено."
    $strings['CleaningInstaller'] = "[*] Очищення файлу інсталятора..."
    $strings['DownloadError'] = "`n[X] Помилка завантаження або встановлення: {0}"
    $strings['UpdateSkipped'] = "`n[-] Оновлення пропущено."
    $strings['NoWindowsInstallers'] = "`r[!] Windows інсталятори не знайдено в цьому релізі."
    $strings['OnlyLinuxPackages'] = "[i] Цей реліз містить тільки Linux пакети (.deb, .rpm, .zip, .AppImage)"
    $strings['WindowsBuildsAvailable'] = "[i] Windows збірки можуть бути доступні в іншому релізі."
    $strings['AvailableInstallers'] = "`r[!] Доступні Windows інсталятори:"
    $strings['NoMatchingInstaller'] = "Не знайдено підходящого інсталятора для вашої архітектури процесора ({0})"
    $strings['GitHubAPIError'] = "`r[X] Помилка підключення до GitHub API: {0}"
    $strings['PressEnterToExit'] = " Натисніть ENTER для виходу..."
    $strings['FileNotFound'] = "Завантажений файл не знайдено"
    $strings['FileEmpty'] = "Завантажений файл порожній"
}

# --- UI Configuration ---
$Title = $strings['Title']
$Line = $strings['Line']

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

function Test-Administrator {
    $isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
    
    if (-not $isAdmin) {
        $adminMsg = if ($isUkrainian) { "Цей скрипт вимагає прав адміністратора для встановлення оновлень." } else { "This script requires administrator rights to install updates." }
        $restartMsg = if ($isUkrainian) { "Перезапустити скрипт з правами адміністратора? (y/n)" } else { "Restart script with administrator rights? (y/n)" }
        
        Write-Host "`n[!] $adminMsg" -ForegroundColor Yellow
        Write-Log "Script running without administrator rights" -Level Warning
        
        $choice = Read-Host $restartMsg
        if ($choice -eq 'y' -or $choice -eq 'Y') {
            Write-Log "Restarting script with administrator rights" -Level Info
            Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
            Exit
        } else {
            $skipMsg = if ($isUkrainian) { "Скрипт буде продовжувати без прав адміністратора. Деякі операції можуть не спрацювати." } else { "Script will continue without administrator rights. Some operations may fail." }
            Write-Host "[i] $skipMsg" -ForegroundColor Gray
            Write-Log "User chose to continue without administrator rights" -Level Warning
        }
    }
}

function Invoke-DownloadWithProgress {
    param (
        [string]$Url,
        [string]$OutputPath
    )
    
    try {
        $webClient = New-Object System.Net.WebClient
        $downloadStartTime = Get-Date
        
        $progressAction = {
            $sender = $args[0]
            $e = $args[1]
            $percent = [math]::Round(($e.BytesReceived / $e.TotalBytesToReceive) * 100)
            $elapsed = (Get-Date) - $downloadStartTime
            
            if ($e.TotalBytesToReceive -gt 0) {
                $speed = $e.BytesReceived / $elapsed.TotalSeconds / 1MB
                $remaining = ($e.TotalBytesToReceive - $e.BytesReceived) / ($speed * 1MB)
                $remainingTime = [timespan]::FromSeconds($remaining)
                
                $progressBar = "[" + ("=" * ($percent / 5)).PadRight(20) + "] $percent%"
                $sizeInfo = "$([math]::Round($e.BytesReceived / 1MB, 1))MB / $([math]::Round($e.TotalBytesToReceive / 1MB, 1))MB"
                $speedInfo = "$([math]::Round($speed, 2))MB/s"
                $timeInfo = "ETA: $($remainingTime.Minutes)m $($remainingTime.Seconds)s"
                
                Write-Host -NoNewline "`r[*] $progressBar | $sizeInfo | $speedInfo | $timeInfo" -ForegroundColor Cyan
            }
        }
        
        $webClient.add_DownloadProgressChanged($progressAction)
        $webClient.DownloadFile($Url, $OutputPath)
        Write-Host "`r[+] Download completed!                                                                    " -ForegroundColor Green
        Write-Log "Download completed: $OutputPath" -Level Success
        
    } catch {
        Write-Log "Download error: $_" -Level Error
        throw $_
    } finally {
        $webClient.Dispose()
    }
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

# Check administrator rights
Test-Administrator

# 1. System Analysis
$cpuTarget = Get-CpuTarget

Write-Host ($strings['AnalyzingSystem']) -ForegroundColor Gray
Write-Host ($strings['YourProcessor'] -f $cpuTarget.CpuName) -ForegroundColor DarkGray
Write-Host ($strings['RecommendedBuild'] -f $cpuTarget.Name) -ForegroundColor Yellow
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
    Write-Host ($strings['ThoriumNotFound']) -ForegroundColor Red
    Write-Log "Thorium installation not found" -Level Error
    Write-Host $Line -ForegroundColor Cyan
    Read-Host ($strings['PressEnterToExit'])
    Exit
}

try {
    $localVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($thoriumPath).FileVersion
    Write-Host ($strings['CurrentVersion'] -f $localVersion) -ForegroundColor Green
    Write-Log "Current version: $localVersion" -Level Info
} catch {
    Write-Host ($strings['ErrorReadingVersion'] -f $_) -ForegroundColor Red
    Write-Log "Error reading local version: $_" -Level Error
    Read-Host ($strings['PressEnterToExit'])
    Exit
}

Write-Host $Line -ForegroundColor Gray

# 3. Check GitHub API
Show-Spinner ($strings['CheckingLatestVersion'])

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
            Write-Host ($strings['NoWindowsInstallers']) -ForegroundColor Yellow
            Write-Host ($strings['OnlyLinuxPackages']) -ForegroundColor Gray
            Write-Host ($strings['WindowsBuildsAvailable']) -ForegroundColor Gray
            Write-Log "No Windows installers in release $latestVersionRaw" -Level Warning
            throw "No Windows installers available in the latest release"
        } else {
            Write-Host ($strings['AvailableInstallers']) -ForegroundColor Yellow
            $windowsInstallers | ForEach-Object { 
                Write-Host "    - $($_.name)" -ForegroundColor Gray 
            }
            Write-Log "No matching installer for CPU: $($cpuTarget.Tag)" -Level Warning
            throw ($strings['NoMatchingInstaller'] -f $cpuTarget.Tag)
        }
    }

    $downloadUrl = $matchingAsset.browser_download_url
    $fileName = $matchingAsset.name
    $fileSize = [math]::Round($matchingAsset.size / 1MB, 2)

    Write-Host "`r$($strings['LatestVersionGitHub'] -f $latestVersionRaw)" -ForegroundColor Yellow
    Write-Host ($strings['InstallerSize'] -f $fileSize) -ForegroundColor DarkGray
    Write-Host $Line -ForegroundColor Gray

    # 4. Compare Versions (Fixed)
    $versionComparison = Compare-Versions -Version1 $cleanLocalVersion -Version2 $latestVersion
    
    if ($versionComparison -ge 0) {
        Write-Host ($strings['AlreadyUpToDate']) -ForegroundColor Green
        Write-Log "Already up to date" -Level Success
        [Console]::Beep(550, 250)
    } 
    else {
        Write-Host ($strings['UpdateAvailable']) -ForegroundColor Cyan
        Write-Host ($strings['TargetFile'] -f $fileName) -ForegroundColor DarkGray
        Write-Log "Update available: $latestVersionRaw" -Level Info
        
        [Console]::Beep(600, 150)
        [Console]::Beep(800, 200)

        Write-Host ""
        $choice = Read-Host ($strings['DownloadAndInstall'])
        
        if ($choice -eq 'y' -or $choice -eq 'Y') {
            
            # Check disk space (require 2x file size for safety)
            $requiredSpace = $matchingAsset.size * 2
            $downloadPath = Join-Path $env:USERPROFILE "Downloads"
            
            if (-not (Test-DiskSpace -Path $downloadPath -RequiredBytes $requiredSpace)) {
                Write-Host ($strings['InsufficientDiskSpace']) -ForegroundColor Red
                Write-Log "Insufficient disk space" -Level Error
                Read-Host ($strings['PressEnterToExit'])
                Exit
            }

            # Check Running Browser
            $thoriumProcesses = Get-Process -Name "thorium" -ErrorAction SilentlyContinue
            if ($thoriumProcesses) {
                Write-Host ($strings['ThoriumRunning']) -ForegroundColor Yellow
                $closeChoice = Read-Host ($strings['CloseThoriumQuestion'])
                if ($closeChoice -eq 'y' -or $closeChoice -eq 'Y') {
                    Write-Host ($strings['ClosingThorium']) -ForegroundColor Gray
                    Write-Log "Closing Thorium processes" -Level Info
                    Stop-Process -Name "thorium" -Force
                    Start-Sleep -Seconds 2
                }
            }

            $targetPath = Join-Path $downloadPath $fileName
            
            # Remove old installer if exists
            if (Test-Path $targetPath) {
                Write-Host ($strings['RemovingOldInstaller']) -ForegroundColor Gray
                Remove-Item -Path $targetPath -Force -ErrorAction SilentlyContinue
            }

            Write-Host ($strings['DownloadingUpdate']) -ForegroundColor Cyan
            Write-Log "Starting download: $downloadUrl" -Level Info
            
            try {
                # Download with progress bar
                Invoke-DownloadWithProgress -Url $downloadUrl -OutputPath $targetPath
                
                # Verify file exists and has content
                if (-not (Test-Path $targetPath)) {
                    throw ($strings['FileNotFound'])
                }
                
                $downloadedSize = (Get-Item $targetPath).Length
                if ($downloadedSize -eq 0) {
                    throw ($strings['FileEmpty'])
                }
                
                Write-Host ($strings['VerifyingIntegrity']) -ForegroundColor Gray
                $fileHash = Get-FileHashSafe -FilePath $targetPath
                if ($fileHash) {
                    Write-Host ($strings['FileHash'] -f $fileHash.Substring(0, 16)) -ForegroundColor DarkGray
                    Write-Log "File hash: $fileHash" -Level Info
                }
                
                Write-Host ($strings['LaunchingInstaller']) -ForegroundColor Yellow
                Write-Log "Launching installer" -Level Info
                
                Start-Process -FilePath $targetPath -Wait
                
                Write-Host ($strings['UpdateCompleted']) -ForegroundColor Green
                Write-Log "Installation completed successfully" -Level Success
                
                # Victory sound
                [Console]::Beep(523, 150); [Console]::Beep(659, 150); [Console]::Beep(784, 300)
                
                # Optional: Clean up installer
                Write-Host ($strings['CleaningInstaller']) -ForegroundColor Gray
                Start-Sleep -Seconds 1
                Remove-Item -Path $targetPath -Force -ErrorAction SilentlyContinue
                
            } catch {
                Write-Host ($strings['DownloadError'] -f $_) -ForegroundColor Red
                Write-Log "Download/installation error: $_" -Level Error
                [Console]::Beep(200, 500)
                
                # Clean up failed download
                if (Test-Path $targetPath) {
                    Remove-Item -Path $targetPath -Force -ErrorAction SilentlyContinue
                }
            }
        } else {
            Write-Host ($strings['UpdateSkipped']) -ForegroundColor Gray
            Write-Log "Update skipped by user" -Level Info
        }
    }

} catch {
    Write-Host ($strings['GitHubAPIError'] -f $_) -ForegroundColor Red
    Write-Log "GitHub API error: $_" -Level Error
    [Console]::Beep(200, 500)
}

Write-Host $Line -ForegroundColor Cyan
Write-Host ($strings['PressEnterToExit']) -ForegroundColor DarkGray
Write-Log "=== Thorium Updater Finished ===" -Level Info
Read-Host