# Update-Thorium.ps1 Changelog / Зміни в Update-Thorium.ps1

## Date / Дата: 19.09.2026

---

## 🆕 LATEST: Additional Improvements / ОСТАННЄ: Додаткові покращення

### English
**1. API Retry Logic**
- 3 attempts with exponential backoff (2s, 4s) for GitHub API requests
- Handles HTTP 403 (rate limit) and network errors gracefully
- Detailed logging of each attempt with delay information
- User sees attempt number and retry countdown

**2. Digital Signature Verification**
- Checks Authenticode signature of downloaded installer before execution
- Valid signature: green confirmation, proceeds automatically
- Missing/invalid signature: yellow warning, asks for user confirmation
- All signature events logged for audit trail

### Українська
**1. Retry-логіка для API**
- 3 спроби з експоненціальною затримкою (2с, 4с) для запитів до GitHub API
- Коректна обробка HTTP 403 (rate limit) та мережевих помилок
- Детальне логування кожної спроби з інформацією про затримку
- Користувач бачить номер спроби та зворотний відлік

**2. Перевірка цифрового підпису**
- Перевірка Authenticode підпису завантаженого інсталятора перед запуском
- Дійсний підпис: підтвердження зеленим, автоматичний продовження
- Відсутній/недійсний підпис: жовте попередження, запит підтвердження
- Усі події підпису логуються для аудиту

---

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
   - **After:** Regex-based numeric component comparison via `Compare-Versions`
   - **Problem:** Version "120.0.0" was considered less than "99.0.0"; letter prefixes (e.g., "M150") caused parse failures
   - **Solution:** `Compare-Versions` extracts all numeric components via regex and compares them sequentially (handles `M150`, `v123.0.1`, etc.)

### Українська
1. **Порівняння версій (КРИТИЧНО)**
   - **Було:** Рядкове порівняння `$cleanLocalVersion -ge $latestVersion`
   - **Стало:** Регулярне порівняння числових компонентів через `Compare-Versions`
   - **Проблема:** Версія "120.0.0" вважалася меншою за "99.0.0"; буквені префікси (напр. "M150") викликали помилки парсингу
   - **Рішення:** `Compare-Versions` витягує всі числові компоненти через regex і порівнює їх послідовно (підтримує `M150`, `v123.0.1` тощо)

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
- `Invoke-RestMethodWithRetry(Uri, MaxRetries)` - API requests with retry
- `Test-FileSignature(FilePath)` - Authenticode signature verification

**Improved Functions:**
- `Get-CpuTarget()` - added error handling and logging
- `Show-Header()` - renamed from Draw-Header
- `Invoke-DownloadWithProgress` - added curl.exe fallback

**Code Size:**
- Before: 156 lines
- After: 495 lines
- Added: ~339 lines (functions, error handling, logging, localization, multilingual support, retry logic, signature verification)

### Українська
**Додані функції:**
- `Write-Log(Message, Level)` - логування з рівнями
- `Compare-Versions(Version1, Version2)` - порівняння версій
- `Test-DiskSpace(Path, RequiredBytes)` - перевірка місця
- `Get-FileHashSafe(FilePath, Algorithm)` - обчислення хешу

**Покращені функції:**
- `Get-CpuTarget()` - додано обробку помилок та логування
- `Show-Header()` - перейменовано з Draw-Header

**Розмір змін:**
- Було: 156 рядків
- Стало: 495 рядків
- Додано: ~339 рядків (функції, обробка помилок, логування, локалізація, мультимовність, retry-логіка, перевірка підпису)

---

## 🎯 Future Improvements / Можливі майбутні покращення

### English
- System restore point creation
- Manual version selection (SSE4.1 instead of AVX2)
- Silent mode

### Українська
- Створення точки відновлення системи
- Вибір версії вручну (SSE4.1 замість AVX2)
- Тихий режим (silent mode)

---

## 📦 Files / Файли

- `Update-Thorium.ps1` - updated script (495 lines) / оновлений скрипт (495 рядків)
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

## 🚀 CI/CD & Testing / CI/CD та тестування

### English
**Pester Test Suite**
- Comprehensive test suite located in `tests/Update-Thorium.Tests.ps1`
- 39 tests across 5 core functions
- Uses Pester v5+ framework
- Covers: version comparison, CPU detection, disk space, API retry, signature verification

**GitHub Actions CI Pipeline**
- Automatic trigger on `push` and `pull_request` to `main`/`master`
- Step 1: PowerShell syntax validation via AST parser
- Step 2: Pester module installation
- Step 3: Full test suite execution with detailed output
- Pipeline fails if any test fails

### Українська
**Набір тестів Pester**
- Комплексний набір тестів у `tests/Update-Thorium.Tests.ps1`
- 39 тестів для 5 основних функцій
- Використовує фреймворк Pester v5+
- Покриває: порівняння версій, визначення CPU, дисковий простір, retry API, перевірку підпису

**CI/CD пайплайн GitHub Actions**
- Автоматичний запуск при `push` та `pull_request` в `main`/`master`
- Крок 1: Перевірка синтаксису PowerShell через AST парсер
- Крок 2: Встановлення модуля Pester
- Крок 3: Запуск повного набору тестів з детальним виводом
- Пайплайн завершується помилкою, якщо хоча б один тест не пройшов

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