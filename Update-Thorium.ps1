Clear-Host

# --- Language Configuration ---

# Default English strings
$englishStrings = @{
    Title = "--- THORIUM UPDATER ---"
    Line = "-" * 50
    NewerVersionNoWindows = "A newer version {0} is available, but has no Windows binaries. Using {1} instead."
    NewerVersionOtherPlatforms = "A newer version {0} is available for other platforms, but not Windows."
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
    AdminRequired = "This script requires administrator rights to install updates."
    RestartWithAdmin = "Restart script with administrator rights? (y/n)"
    ContinueWithoutAdmin = "Script will continue without administrator rights. Some operations may fail."
}

# Ukrainian strings
$ukrainianStrings = @{
    Title = "--- ОНОВЛЮВАЧ THORIUM ---"
    Line = "-" * 50
    NewerVersionNoWindows = "Новіша версія {0} доступна, але не має інсталяторів для Windows. Використовується {1} замість неї."
    NewerVersionOtherPlatforms = "Новіша версія {0} доступна для інших платформ, але не для Windows."
    AnalyzingSystem = "[*] Аналіз вашої системи..."
    YourProcessor = "[+] Ваш процесор: {0}"
    RecommendedBuild = "[+] Рекомендована збірка Thorium: {0}"
    ThoriumNotFound = "[X] Локальну інсталяцію Thorium не знайдено!"
    CurrentVersion = "[+] Ваша поточна версія: {0}"
    ErrorReadingVersion = "[X] Помилка читання локальної версії: {0}"
    CheckingLatestVersion = "Перевірка останньої версії на GitHub..."
    LatestVersionGitHub = "[+] Остання версія на GitHub: {0}"
    InstallerSize = "[+] Розмір інсталятора: {0} МБ"
    AlreadyUpToDate = "[OK] У вас остання версія! Оновлення не потрібне.`n"
    UpdateAvailable = "[!] Знайдено нове оновлення для вашої архітектури CPU!"
    TargetFile = "Цільовий файл: {0}"
    DownloadAndInstall = "[?] Завантажити та встановити це оновлення? (т/н)"
    InsufficientDiskSpace = "[X] Недостатньо місця на диску!"
    ThoriumRunning = "`n[!] Thorium наразі запущено."
    CloseThoriumQuestion = "[?] Автоматично закрити Thorium, щоб запобігти помилкам інсталяції? (т/н)"
    ClosingThorium = "[*] Закриття Thorium..."
    RemovingOldInstaller = "[*] Видалення старого інсталятора..."
    DownloadingUpdate = "`n[*] Завантаження оновлення..."
    DownloadCompleted = "[+] Завантаження завершено!"
    VerifyingIntegrity = "[*] Перевірка цілісності завантаження..."
    FileHash = "[+] Хеш файлу (SHA256): {0}..."
    LaunchingInstaller = "[*] Запуск інсталятора... Дотримуйтесь інструкцій у вікні."
    UpdateCompleted = "`n[+] Готово! Thorium успішно оновлено."
    CleaningInstaller = "[*] Очищення файлу інсталятора..."
    DownloadError = "`n[X] Помилка завантаження або інсталяції: {0}"
    UpdateSkipped = "`n[-] Оновлення пропущено."
    NoWindowsInstallers = "`r[!] Інсталятори Windows не знайдено в цьому релізі."
    OnlyLinuxPackages = "[i] Цей реліз містить лише пакети Linux (.deb, .rpm, .zip, .AppImage)"
    WindowsBuildsAvailable = "[i] Збірки Windows можуть бути доступні в іншому релізі."
    AvailableInstallers = "`r[!] Доступні інсталятори Windows:"
    NoMatchingInstaller = "Не знайдено відповідного інсталятора для CPU: {0}"
    GitHubAPIError = "`r[X] Помилка підключення до GitHub API: {0}"
    PressEnterToExit = " Натисніть ENTER для виходу..."
    FileNotFound = "Завантажений файл не знайдено"
    FileEmpty = "Завантажений файл порожній"
    AdminRequired = "Цей скрипт вимагає прав адміністратора для встановлення оновлень."
    RestartWithAdmin = "Перезапустити скрипт з правами адміністратора? (т/н)"
    ContinueWithoutAdmin = "Скрипт продовжить роботу без прав адміністратора. Деякі операції можуть завершитися невдачею."
}

# Determine UI language
$currentCulture = [System.Globalization.CultureInfo]::CurrentUICulture.Name
if ($currentCulture -like "uk*" -or $currentCulture -like "ru*") { # Use Ukrainian for Ukrainian and Russian systems
    $strings = $ukrainianStrings
} else {
    $strings = $englishStrings
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
        $adminMsg = $strings['AdminRequired']
        $restartMsg = $strings['RestartWithAdmin']
        Write-Host "`n[!] $adminMsg" -ForegroundColor Yellow
        Write-Log "Script running without administrator rights" -Level Warning
        $choice = Read-Host $restartMsg
        if ($choice -match 'y|т') {
            Write-Log "Restarting script with administrator rights" -Level Info
            Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
            Exit
        } else {
            $skipMsg = $strings['ContinueWithoutAdmin']
            Write-Host '[i] ' -NoNewline -ForegroundColor Gray
            Write-Host $skipMsg -ForegroundColor Gray
            Write-Log "User chose to continue without administrator rights" -Level Warning
        }
    }
}

function Invoke-DownloadWithProgress {
    param ([string]$Url, [string]$OutputPath)
    $downloadSuccess = $false
    $errorMessage = ""
    try {
        Invoke-WebRequest -Uri $Url -OutFile $OutputPath -UseBasicParsing -TimeoutSec 300 -ErrorAction Stop
        $downloadSuccess = $true
        Write-Log "Download completed with Invoke-WebRequest" -Level Success
    } catch {
        $errorMessage = $_.Exception.Message
        Write-Log "Invoke-WebRequest failed: $errorMessage" -Level Warning
        Write-Host "`n[!] Invoke-WebRequest failed. Trying with curl.exe..." -ForegroundColor DarkYellow
    }
    if (-not $downloadSuccess) {
        try {
            curl.exe -L --connect-timeout 30 --max-time 600 -o $OutputPath $Url --progress-bar 2>&1
            if (-not (Test-Path $OutputPath) -or (Get-Item $OutputPath).Length -eq 0) {
                 throw "Curl download failed or returned empty file."
            }
            $downloadSuccess = $true
            Write-Log "Download completed with curl.exe" -Level Success
        } catch {
            $errorMessage = $_.Exception.Message
            Write-Log "Curl.exe failed: $errorMessage" -Level Error
            Write-Host "`n[X] Curl.exe failed: $errorMessage" -ForegroundColor Red
        }
    }
    if (-not $downloadSuccess) {
        throw "Download failed: $errorMessage"
    } else {
        Write-Host "`r[+] Download completed!                                                                    " -ForegroundColor Green
    }
}

function Get-CpuTarget {
    try {
        $cpuInfo = Get-CimInstance -ClassName Win32_Processor -ErrorAction Stop | Select-Object -First 1
        $cpuName = $cpuInfo.Name
        Write-Log "Detected CPU: $cpuName" -Level Info
        if ($cpuName -match "Ryzen" -or $cpuName -match "i3-|i5-|i7-|i9-" -or ($cpuName -match "Athlon" -and ($cpuName -match "Silver" -or $cpuName -match "Gold"))) {
            return @{ Name = "AVX2 (Modern)"; Tag = "AVX2"; CpuName = $cpuName }
        } elseif ($cpuName -match "Athlon" -or $cpuName -match "Celeron" -or $cpuName -match "Pentium") {
            return @{ Name = "SSE4.1 / AVX (Value/Older CPU)"; Tag = "SSE4"; CpuName = $cpuName }
        } else {
            return @{ Name = "Windows Default"; Tag = "mini_installer"; CpuName = $cpuName }
        }
    } catch {
        Write-Log "Error detecting CPU: $_" -Level Error
        return @{ Name = "Windows Default"; Tag = "mini_installer"; CpuName = "Unknown" }
    }
}

function Compare-Versions {
    param ([string]$Version1, [string]$Version2)
    try {
        $v1 = [System.Version]::Parse($Version1)
        $v2 = [System.Version]::Parse($Version2)
        return $v1.CompareTo($v2)
    } catch {
        return [string]::Compare($Version1, $Version2)
    }
}

function Test-DiskSpace {
    param ([string]$Path, [int64]$RequiredBytes)
    try {
        $drive = [System.IO.Path]::GetPathRoot($Path)
        $driveInfo = Get-PSDrive -Name $drive.TrimEnd(':\') -ErrorAction Stop
        return $driveInfo.Free -gt $RequiredBytes
    } catch { return $true }
}

function Get-FileHashSafe {
    param ([string]$FilePath, [string]$Algorithm = "SHA256")
    try {
        return (Get-FileHash -Path $FilePath -Algorithm $Algorithm -ErrorAction Stop).Hash
    } catch { return $null }
}

# --- Main ---
Show-Header
Write-Log "=== Thorium Updater Started ===" -Level Info
Test-Administrator

$cpuTarget = Get-CpuTarget
Write-Host ($strings['AnalyzingSystem']) -ForegroundColor Gray
Write-Host ($strings['YourProcessor'] -f $cpuTarget.CpuName) -ForegroundColor DarkGray
Write-Host ($strings['RecommendedBuild'] -f $cpuTarget.Name) -ForegroundColor Yellow
Write-Host $Line -ForegroundColor Gray

$localPaths = @("$env:LOCALAPPDATA\Thorium\Application\thorium.exe", "$env:ProgramFiles\Thorium\Application\thorium.exe")
$thoriumPath = $null
foreach ($path in $localPaths) { if (Test-Path $path) { $thoriumPath = $path; break } }

if (-not $thoriumPath) {
    Write-Host ($strings['ThoriumNotFound']) -ForegroundColor Red
    Write-Host $Line -ForegroundColor Cyan
    Read-Host ($strings['PressEnterToExit'])
    Exit
}

try {
    $localVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($thoriumPath).FileVersion
    Write-Host ($strings['CurrentVersion'] -f $localVersion) -ForegroundColor Green
} catch {
    Write-Host ($strings['ErrorReadingVersion'] -f $_) -ForegroundColor Red
    Read-Host ($strings['PressEnterToExit'])
    Exit
}

Write-Host $Line -ForegroundColor Gray
Show-Spinner ($strings['CheckingLatestVersion'])

try {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $repos = @(
        @{ Owner = "Alex313031"; Repo = "Thorium-Win"; Label = "Official" },
        @{ Owner = "gz83"; Repo = "thorium"; Label = "Collaborator (Beta)" }
    )
    $latestVersionRaw = $null
    $latestValidRelease = $null
    $matchingAsset = $null
    $foundNewerEmptyRelease = $false
    $selectedRepoLabel = ""
    $cleanLocalVersion = ($localVersion -replace '[^0-9.]', '').Trim('.')

    foreach ($repo in $repos) {
        $repoUrl = "https://api.github.com/repos/$($repo.Owner)/$($repo.Repo)/releases"
        $allReleases = Invoke-RestMethod -Uri $repoUrl -UseBasicParsing -ErrorAction SilentlyContinue
        if (-not $allReleases) { continue }
        foreach ($releaseEntry in $allReleases) {
            $tag = $releaseEntry.tag_name
            $cleanTag = ($tag -replace '[^0-9.]', '').Trim('.')
            
            # Track the absolute latest release version seen regardless of binaries
            if (-not $latestVersionRaw) {
                $latestVersionRaw = $tag
            } else {
                $cleanLatest = ($latestVersionRaw -replace '[^0-9.]', '').Trim('.')
                if ((Compare-Versions -Version1 $cleanLatest -Version2 $cleanTag) -lt 0) {
                    $latestVersionRaw = $tag
                }
            }
            
            $assetPattern = "thorium_$($cpuTarget.Tag)_mini_installer.exe"
            $asset = $releaseEntry.assets | Where-Object { $_.name -eq $assetPattern } | Select-Object -First 1
            if (-not $asset -and $cpuTarget.Tag -eq "AVX2") {
                $asset = $releaseEntry.assets | Where-Object { $_.name -eq "thorium_AVX_mini_installer.exe" } | Select-Object -First 1
            }
            if (-not $asset -and $cpuTarget.Tag -eq "mini_installer") {
                $asset = $releaseEntry.assets | Where-Object { $_.name -eq "thorium_mini_installer.exe" } | Select-Object -First 1
            }
            
            if ($asset) {
                # Found a release with Windows binaries. Is it newer than what we have?
                if (-not $latestValidRelease) {
                    $latestValidRelease = $releaseEntry
                    $matchingAsset = $asset
                    $selectedRepoLabel = $repo.Label
                } else {
                    $currentValidClean = ($latestValidRelease.tag_name -replace '[^0-9.]', '').Trim('.')
                    if ((Compare-Versions -Version1 $currentValidClean -Version2 $cleanTag) -lt 0) {
                        $latestValidRelease = $releaseEntry
                        $matchingAsset = $asset
                        $selectedRepoLabel = $repo.Label
                    }
                }
            } else {
                # No Windows binaries here. Is this release newer than local?
                if ((Compare-Versions -Version1 $cleanLocalVersion -Version2 $cleanTag) -lt 0) {
                    if (($releaseEntry.assets | Where-Object { $_.name -like "*.exe" }).Count -eq 0) {
                        $foundNewerEmptyRelease = $true
                    }
                }
            }
        }
    }

    if (-not $latestValidRelease) {
        Write-Host ($strings['NoWindowsInstallers']) -ForegroundColor Red
        Write-Host ($strings['WindowsBuildsAvailable']) -ForegroundColor Gray
        throw "No Windows installers found."
    }

    $latestVersion = ($latestValidRelease.tag_name -replace '[^0-9.]', '').Trim('.')
    Write-Host "`r$($strings['LatestVersionGitHub'] -f $latestVersionRaw)" -ForegroundColor Yellow
    if ($selectedRepoLabel -ne "Official") {
        Write-Host '[i] Source: ' -NoNewline -ForegroundColor DarkYellow
        Write-Host "$selectedRepoLabel" -ForegroundColor DarkYellow
    }
    Write-Host ($strings['InstallerSize'] -f [math]::Round($matchingAsset.size / 1MB, 2)) -ForegroundColor DarkGray
    Write-Host $Line -ForegroundColor Gray

    $cmp = Compare-Versions -Version1 $cleanLocalVersion -Version2 $latestVersion
    if ($cmp -lt 0) {
        Write-Host ($strings['UpdateAvailable']) -ForegroundColor Cyan
        Write-Host ($strings['TargetFile'] -f $matchingAsset.name) -ForegroundColor DarkGray
        
        # Only show this message if the absolute latest version is actually newer than the one we are installing
        $cleanLatestRaw = ($latestVersionRaw -replace '[^0-9.]', '').Trim('.')
        if ($foundNewerEmptyRelease -and (Compare-Versions -Version1 $latestVersion -Version2 $cleanLatestRaw -lt 0)) {
            Write-Host '[i] ' -NoNewline -ForegroundColor DarkYellow
            Write-Host ($strings['NewerVersionNoWindows'] -f $latestVersionRaw, $latestVersion) -ForegroundColor DarkYellow
            Write-Host $Line -ForegroundColor Gray
        }
        [Console]::Beep(600, 150); [Console]::Beep(800, 200)
        Write-Host ""
        $choice = Read-Host ($strings['DownloadAndInstall'])
        if ($choice -match 'y|т') {
            $downloadPath = Join-Path $env:USERPROFILE "Downloads"
            $targetPath = Join-Path $downloadPath $matchingAsset.name
            if (-not (Test-DiskSpace -Path $downloadPath -RequiredBytes ($matchingAsset.size * 2))) {
                Write-Host ($strings['InsufficientDiskSpace']) -ForegroundColor Red
                Read-Host ($strings['PressEnterToExit']); Exit
            }
            $procs = Get-Process -Name "thorium" -ErrorAction SilentlyContinue
            if ($procs) {
                Write-Host ($strings['ThoriumRunning']) -ForegroundColor Yellow
                if ((Read-Host ($strings['CloseThoriumQuestion'])) -match 'y|т') {
                    Write-Host ($strings['ClosingThorium']) -ForegroundColor Gray
                    Stop-Process -Name "thorium" -Force; Start-Sleep -Seconds 2
                }
            }
            if (Test-Path $targetPath) { Remove-Item $targetPath -Force }
            Write-Host ($strings['DownloadingUpdate']) -ForegroundColor Cyan
            try {
                Invoke-DownloadWithProgress -Url $matchingAsset.browser_download_url -OutputPath $targetPath
                Write-Host ($strings['VerifyingIntegrity']) -ForegroundColor Gray
                $hash = Get-FileHashSafe -FilePath $targetPath
                if ($hash) { Write-Host ($strings['FileHash'] -f $hash.Substring(0, 16)) -ForegroundColor DarkGray }
                Write-Host ($strings['LaunchingInstaller']) -ForegroundColor Yellow
                Start-Process -FilePath $targetPath -Wait
                Write-Host ($strings['UpdateCompleted']) -ForegroundColor Green
                [Console]::Beep(523, 150); [Console]::Beep(659, 150); [Console]::Beep(784, 300)
                Remove-Item $targetPath -Force -ErrorAction SilentlyContinue
            } catch {
                Write-Host ($strings['DownloadError'] -f $_) -ForegroundColor Red
                if (Test-Path $targetPath) { Remove-Item $targetPath -Force }
            }
        } else {
            Write-Host ($strings['UpdateSkipped']) -ForegroundColor Gray
        }
    } else {
        Write-Host ($strings['AlreadyUpToDate']) -ForegroundColor Green
        
        # Only show this if the absolute latest version is actually newer than the installed version
        $cleanLatestRaw = ($latestVersionRaw -replace '[^0-9.]', '').Trim('.')
        if ($foundNewerEmptyRelease -and (Compare-Versions -Version1 $cleanLocalVersion -Version2 $cleanLatestRaw -lt 0)) {
            Write-Host '[i] ' -NoNewline -ForegroundColor DarkYellow
            Write-Host ($strings['NewerVersionOtherPlatforms'] -f $latestVersionRaw) -ForegroundColor DarkYellow
        }
    }
} catch {
    Write-Host ($strings['GitHubAPIError'] -f $_) -ForegroundColor Red
}

Write-Host $Line -ForegroundColor Cyan
Write-Host ($strings['PressEnterToExit']) -ForegroundColor DarkGray
Write-Log "=== Thorium Updater Finished ===" -Level Info
Read-Host