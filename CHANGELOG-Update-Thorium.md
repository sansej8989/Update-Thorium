# Update-Thorium.ps1 Changelog / Зміни в Update-Thorium.ps1

## Date / Дата: 21.05.2026

---

## 🆕 LATEST: Additional Improvements / ОСТАННЄ: Додаткові покращення

### English
**1. Administrator Rights Check**
- Automatic detection of administrator privileges at script startup
- Option to restart script with elevated rights
- User can choose to continue without admin rights (with warning)
- Prevents installation errors due to insufficient permissions

**2. Download Progress Bar**
- Real-time progress visualization during file download
- Shows: progress bar, downloaded/total size, download speed, estimated time
- Uses `System.Net.WebClient` with `DownloadProgressChanged` event
- More informative than simple spinner animation

**Implementation:**
- `Test-Administrator` function checks privileges and offers restart
- `Invoke-DownloadWithProgress` function replaces `Invoke-WebRequest`
- Both functions support multilingual interface

### Українська
**1. Перевірка прав адміністратора**
- Автоматичне визначення прав адміністратора при запуску скрипту
- Можливість перезапустити скрипт з підвищеними правами
- Користувач може продовжити без прав адміна (з попередженням)
- Запобігає помилкам встановлення через недостатні права

**2. Прогрес-бар завантаження**
- Візуалізація прогресу в реальному часі під час завантаження файлу
- Показує: прогрес-бар, завантажено/загалом, швидкість, час до завершення
- Використовує `System.Net.WebClient` з подією `DownloadProgressChanged`
- Більш інформативно ніж проста анімація спінера

**Реалізація:**
- Функція `Test-Administrator` перевіряє права та пропонує перезапуск
- Функція `Invoke-DownloadWithProgress` замінює `Invoke-WebRequest`
- Обидві функції підтримують мультимовний інтерфейс

---

## 🌐 Multilingual Support / Мультимовна підтримка

### English
**Automatic Language Detection**
- Script now automatically detects system language using `$PSUICulture`
- Ukrainian interface for Ukrainian systems (`uk-UA`, `uk`)
- English interface for all other languages (default)
- All user-facing messages are localized
- Logs remain in English for compatibility

**Implementation Details**
- Centralized string management using hash tables
- Language detection at script startup
- Format string support for dynamic content
- Easy to extend with additional languages

### Українська
**Автоматичне визначення мови**
- Скрипт автоматично визначає мову системи через `$PSUICulture`
- Український інтерфейс для українських систем (`uk-UA`, `uk`)
- Англійський інтерфейс для всіх інших мов (за замовчуванням)
- Всі повідомлення для користувача локалізовані
- Логи залишаються англійською для сумісності

**Деталі реалізації**
- Централізоване управління рядками через хеш-таблиці
- Визначення мови при запуску скрипту
- Підтримка форматованих рядків для динамічного контенту
- Легко розширити додатковими мовами

---

## ✅ Fixed Critical Issues / Виправлені критичні помилки

### English
1. **Version Comparison (CRITICAL)**
   - **Before:** String comparison `$cleanLocalVersion -ge $latestVersion`
   - **After:** Numeric comparison via `[System.Version]::Parse()` with fallback
   - **Problem:** Version "120.0.0" was considered less than "99.0.0"
   - **Solution:** `Compare-Versions` function with proper version parsing

### Українська
1. **Порівняння версій (КРИТИЧНО)**
   - **Було:** Рядкове порівняння `$cleanLocalVersion -ge $latestVersion`
   - **Стало:** Числове порівняння через `[System.Version]::Parse()` з fallback
   - **Проблема:** Версія "120.0.0" вважалася меншою за "99.0.0"
   - **Рішення:** Функція `Compare-Versions` з правильним парсингом версій

---

## 🛡️ Security and Reliability Improvements / Покращення безпеки та надійності

### English
2. **Error Handling**
   - Added try-catch blocks for all critical operations
   - Detailed error messages with context
   - Graceful degradation on failures

3. **File Integrity Verification**
   - SHA256 hash calculation for downloaded files
   - File existence and size verification after download
   - Cleanup of corrupted downloads

4. **Disk Space Check**
   - `Test-DiskSpace` function checks available space (2x file size)
   - Warning before download if insufficient space

5. **Handling Missing Windows Releases**
   - Informative message when release contains only Linux packages
   - Display available Windows installers if present
   - Detailed error messages explaining the issue

### Українська
2. **Обробка помилок**
   - Додано try-catch блоки для всіх критичних операцій
   - Детальні повідомлення про помилки з контекстом
   - Graceful degradation при збоях

3. **Перевірка цілісності файлів**
   - Обчислення SHA256 хешу завантаженого файлу
   - Перевірка існування та розміру файлу після завантаження
   - Видалення пошкоджених завантажень

4. **Перевірка вільного місця**
   - Функція `Test-DiskSpace` перевіряє наявність місця (2x розмір файлу)
   - Попередження перед завантаженням при недостатньому місці

5. **Обробка відсутності Windows релізів**
   - Інформативне повідомлення коли реліз містить тільки Linux пакети
   - Показ доступних Windows інсталяторів якщо вони є
   - Детальні повідомлення про причину помилки

---

## 📝 Logging / Логування

### English
6. **Logging System**
   - `Write-Log` function with levels: Info, Warning, Error, Success
   - Log file: `%TEMP%\Thorium-Updater.log`
   - Timestamp for each entry
   - Logging of all important operations

### Українська
6. **Система логування**
   - Функція `Write-Log` з рівнями: Info, Warning, Error, Success
   - Лог-файл: `%TEMP%\Thorium-Updater.log`
   - Timestamp для кожного запису
   - Логування всіх важливих операцій

---

## 🔧 Code Refactoring / Рефакторинг коду

### English
7. **Structure and Readability**
   - Extracted "magic numbers" into variables (`$spinnerChars`, `$iterations`)
   - Eliminated code duplication (CPU info retrieved once)
   - Added comments to complex sections
   - Improved variable naming
   - Renamed `Draw-Header` to `Show-Header` for consistency

8. **New Functions**
   - `Compare-Versions` - correct version comparison
   - `Test-DiskSpace` - disk space verification
   - `Get-FileHashSafe` - safe hash calculation
   - `Write-Log` - centralized logging

### Українська
7. **Структура та читабельність**
   - Винесено "магічні числа" в змінні (`$spinnerChars`, `$iterations`)
   - Усунуто дублювання коду (CPU info отримується один раз)
   - Додано коментарі до складних ділянок
   - Покращено іменування змінних
   - Перейменовано `Draw-Header` на `Show-Header` для консистентності

8. **Нові функції**
   - `Compare-Versions` - коректне порівняння версій
   - `Test-DiskSpace` - перевірка вільного місця
   - `Get-FileHashSafe` - безпечне обчислення хешу
   - `Write-Log` - централізоване логування

---

## 🎨 UX Improvements / UX покращення

### English
9. **Informativeness**
   - Display file size before download
   - Show partial file hash
   - Messages about cleaning old files
   - More detailed operation statuses
   - Explanation when Windows releases are absent

10. **Cleanup**
    - Automatic removal of old installer before download
    - Cleanup after successful installation
    - Removal of corrupted downloads

### Українська
9. **Інформативність**
   - Показ розміру файлу перед завантаженням
   - Відображення частини хешу файлу
   - Повідомлення про очищення старих файлів
   - Детальніші статуси операцій
   - Пояснення коли Windows релізи відсутні

10. **Очищення**
    - Автоматичне видалення старого інсталятора перед завантаженням
    - Очищення після успішного встановлення
    - Видалення пошкоджених завантажень

---

## 🔍 Validation / Валідація

### English
12. **Additional Checks**
    - Verification of matching installer availability
    - Check for Windows releases in general
    - URL validation before download
    - Downloaded file size verification
    - ErrorAction Stop for critical operations

### Українська
12. **Додаткові перевірки**
    - Перевірка наявності підходящого інсталятора
    - Перевірка наявності Windows релізів взагалі
    - Валідація URL перед завантаженням
    - Перевірка розміру завантаженого файлу
    - ErrorAction Stop для критичних операцій

---

## 📊 Technical Details / Технічні деталі

### English
**Added Functions:**
- `Write-Log(Message, Level)` - logging with levels
- `Compare-Versions(Version1, Version2)` - version comparison
- `Test-DiskSpace(Path, RequiredBytes)` - space check
- `Get-FileHashSafe(FilePath, Algorithm)` - hash calculation

**Improved Functions:**
- `Get-CpuTarget()` - added error handling and logging
- `Show-Spinner()` - extracted constants
- `Show-Header()` - renamed from Draw-Header

**Code Size:**
- Before: 156 lines
- After: 438 lines
- Added: ~282 lines (functions, error handling, logging, localization, multilingual support)

### Українська
**Додані функції:**
- `Write-Log(Message, Level)` - логування з рівнями
- `Compare-Versions(Version1, Version2)` - порівняння версій
- `Test-DiskSpace(Path, RequiredBytes)` - перевірка місця
- `Get-FileHashSafe(FilePath, Algorithm)` - обчислення хешу

**Покращені функції:**
- `Get-CpuTarget()` - додано обробку помилок та логування
- `Show-Spinner()` - винесено константи
- `Show-Header()` - перейменовано з Draw-Header

**Розмір змін:**
- Було: 156 рядків
- Стало: 438 рядків
- Додано: ~282 рядки (функції, обробка помилок, логування, локалізація, мультимовність)

---

## 🎯 Future Improvements / Можливі майбутні покращення

### English
- Digital signature verification of installer
- System restore point creation
- Manual version selection (SSE4.1 instead of AVX2)
- Silent mode
- Download progress bar
- Administrator rights check

### Українська
- Перевірка цифрового підпису інсталятора
- Створення точки відновлення системи
- Вибір версії вручну (SSE4.1 замість AVX2)
- Тихий режим (silent mode)
- Прогрес-бар завантаження
- Перевірка прав адміністратора

---

## 📦 Files / Файли

- `Update-Thorium.ps1` - updated script (438 lines) / оновлений скрипт (438 рядків)
- `Update-Thorium.ps1.backup` - backup of original / резервна копія оригіналу
- `CHANGELOG-Update-Thorium.md` - detailed change documentation / детальна документація змін

---

## ✨ Result / Результат

### English
The script now:
- ✅ Correctly compares versions
- ✅ Reliably handles errors
- ✅ Verifies download integrity
- ✅ Logs all operations
- ✅ More informative for users
- ✅ Safer to use
- ✅ Easier to maintain and extend
- ✅ **Supports Ukrainian and English languages**
- ✅ **Automatically detects system language**
- ✅ Correctly handles missing Windows releases

### Українська
Скрипт тепер:
- ✅ Коректно порівнює версії
- ✅ Надійно обробляє помилки
- ✅ Перевіряє цілісність завантажень
- ✅ Логує всі операції
- ✅ Інформативніший для користувача
- ✅ Безпечніший у використанні
- ✅ Легше підтримувати та розширювати
- ✅ **Підтримує українську та англійську мови**
- ✅ **Автоматично визначає мову системи**
- ✅ Коректно обробляє відсутність Windows релізів

---

## 🐛 Known Issues / Виявлені проблеми

### English
**Issue with Latest Thorium Release:**
- Release M138.0.7204.303 does not contain Windows installers
- Contains only Linux packages (.deb, .rpm, .zip, .AppImage)
- Script now correctly informs users about this
- Recommended to check previous releases for Windows builds

### Українська
**Проблема з останнім релізом Thorium:**
- Реліз M138.0.7204.303 не містить Windows інсталяторів
- Містить тільки Linux пакети (.deb, .rpm, .zip, .AppImage)
- Скрипт тепер коректно інформує про це користувача
- Рекомендується перевірити попередні релізи для Windows збірок