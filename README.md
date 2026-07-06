# 🔄 Update-Thorium

**Automatic updater for [Thorium Browser](https://thorium.rocks/) on Windows.**

> 🇺🇦 [Українська версія нижче](#-update-thorium-1)

---

## ✨ Features

- 🔍 **Auto-detect CPU architecture** — selects optimal build (AVX2, SSE4.1, or default)
- 📊 **Robust version comparison** — handles complex tags (e.g., 'M150') via advanced parsing
- 🌐 **Dual-repository search** — checks both Official and Collaborator (Beta) repos for the absolute latest Windows binaries
- 📥 **Reliable downloads** — real-time progress bar with built-in timeouts to prevent hangs
- 🛡️ **Administrator rights check** — auto-restart with elevated privileges
- 🌍 **Automatic Multilingual support** — auto-detects system language (Ukrainian/English)
- 📝 **Logging** — all operations logged to `%TEMP%\Thorium-Updater.log`
- ✅ **File integrity** — SHA256 hash verification after download
- 💾 **Disk space check** — warns before download if insufficient space
- 🧹 **Auto-cleanup** — removes installer after successful update

## 📋 Requirements

- **OS:** Windows 10 / 11
- **PowerShell:** 5.1+
- **Thorium Browser** installed (checks `%LOCALAPPDATA%\Thorium` and `%ProgramFiles%\Thorium`)

## 🚀 Quick Start

### Option 1: Run directly
```powershell
powershell -ExecutionPolicy Bypass -File Update-Thorium.ps1
```

### Option 2: Right-click
1. Right-click `Update-Thorium.ps1`
2. Select **"Run with PowerShell"**

### Option 3: From PowerShell
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\Update-Thorium.ps1
```

## 📖 How It Works

1. **Detects** your CPU type and selects the best Thorium build
2. **Finds** your installed Thorium version
3. **Checks** multiple GitHub repositories for the latest Windows release
4. **Compares** versions — if update available, offers to download
5. **Downloads** with real-time progress bar and stability timeouts
6. **Verifies** file integrity (SHA256)
7. **Launches** installer and cleans up after

## 📁 Project Structure

```
Update-Thorium/
├── README.md                    # This file
├── Update-Thorium.ps1           # Main updater script
├── Update-Thorium.ps1.backup    # Original script backup
└── CHANGELOG-Update-Thorium.md  # Detailed change log
```

## 🔧 Configuration

The script auto-detects everything. No configuration needed.

**CPU detection logic:**
| CPU Type | Build Selected |
|----------|---------------|
| Intel Core i3/i5/i7/i9, AMD Ryzen, AMD Athlon Silver/Gold | AVX2 (Modern) |
| Intel Celeron/Pentium, AMD Athlon (Older) | SSE4.1 / AVX |
| Other | Default (mini_installer) |

## 📝 Logs

Log file location: `%TEMP%\Thorium-Updater.log`

Log levels: `Info`, `Warning`, `Error`, `Success`

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---

# 🔄 Update-Thorium

**Автоматичний оновлювач для [Thorium Browser](https://thorium.rocks/) на Windows.**

## ✨ Можливості

- 🔍 **Автовизначення архітектури CPU** — обирає оптимальну збірку (AVX2, SSE4.1 або стандартну)
- 📊 **Надійне порівняння версій** — обробка складних тегів (напр. 'M150') через розширений парсинг
- 🌐 **Пошук по двох репозиторіях** — перевіряє як офіційний, так і бета-репозиторій для пошуку найновіших збірок Windows
- 📥 **Стабільне завантаження** — прогрес-бар у реальному часі з тайм-аутами для запобігання зависань
- 🛡️ **Перевірка прав адміністратора** — автоматичний перезапуск з підвищеними правами
- 🌍 **Автоматична багатомовність** — автоматичне визначення мови системи (українська/англійська)
- 📝 **Логування** — всі операції логуються в `%TEMP%\Thorium-Updater.log`
- ✅ **Цілісність файлів** — перевірка SHA256 хешу після завантаження
- 💾 **Перевірка вільного місця** — попередження перед завантаженням
- 🧹 **Автоочищення** — видалення інсталятора після успішного оновлення

## 📋 Вимоги

- **ОС:** Windows 10 / 11
- **PowerShell:** 5.1+
- **Thorium Browser** встановлений (перевіряє `%LOCALAPPDATA%\Thorium` та `%ProgramFiles%\Thorium`)

## 🚀 Швидкий старт

### Варіант 1: Запуск напряму
```powershell
powershell -ExecutionPolicy Bypass -File Update-Thorium.ps1
```

### Варіант 2: Правий клік
1. Правий клік на `Update-Thorium.ps1`
2. Оберіть **"Виконати за допомогою PowerShell"**

### Варіант 3: З PowerShell
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\Update-Thorium.ps1
```

## 📖 Як це працює

1. **Визначає** тип процесора та обирає найкращу збірку Thorium
2. **Знаходить** встановлену версію Thorium
3. **Перевіряє** кілька репозиторіїв GitHub на наявність останнього релізу для Windows
4. **Порівнює** версії — якщо є оновлення, пропонує завантажити
5. **Завантажує** з прогрес-баром та тайм-аутами стабільності
6. **Перевіряє** цілісність файлу (SHA256)
7. **Запускає** інсталятор та прибирає після завершення

## 📄 Ліцензія

Цей проект ліцензований під MIT License — див. файл [LICENSE](LICENSE).