# PerfectNum 🔢

A Flutter mobile application to check and find perfect numbers, built with clean architecture, BLoC state management, and local persistence.

Note: This project is a technical test. Here is the document link:
https://drive.google.com/file/d/1O_-X0hF1wOxWnGtmgBgmIcAr6Ody7Ex-/view?usp=sharing


## 📱 Features

- **Check a number** — instantly verify whether any number is perfect, with full divisor breakdown
- **Find in range** — discover all perfect numbers between two given values
- **Search history** — every search is persisted locally via SQLite and accessible in the History tab
- **Internationalization** — full support for English and Portuguese (BR)
- **Dark theme** — polished dark UI with teal accent and smooth animations

## 🏗️ Architecture

Clean Architecture with two decoupled layers:
```
Domain  ←────────────────────────────────────
  │  entities / repositories (abstract) / usecases
  │
Data    (implements domain contracts)
  │  models / datasources / repository impl / SQLite
  │
Presentation  (consumes domain)
     cubit / states / screens / widgets
```

No layer leaks upward. The domain has zero Flutter dependencies.

## 🛠️ Tech Stack

| Concern | Solution |
|---|---|
| Framework | Flutter (Dart) |
| State management | `flutter_bloc` — Cubit |
| Dependency injection | `get_it` |
| Local database | `sqflite` |
| Internationalization | `flutter_localizations` + ARB files |
| Testing | `flutter_test` + `bloc_test` + `mocktail` |

## 📂 Project Structure
```
lib/
├── core/
│   ├── db/               # SQLite DatabaseHelper (singleton)
│   ├── di/               # get_it dependency graph
│   ├── l10n/             # ARB files (EN + PT) + l10n keys
│   └── theme/            # AppTheme + AppColors extension
└── features/
    └── perfect_number/
        ├── data/
        │   ├── datasources/       # SearchLocalDatasource
        │   ├── models/            # SearchRecordModel (toMap/fromMap)
        │   └── repositories/      # PerfectNumberRepositoryImpl
        └── domain/
            ├── entities/          # SearchRecord, PerfectNumberResult
            ├── repositories/      # PerfectNumberRepository (abstract)
            └── usecases/          # Check, Find, Save, GetHistory
        └── presentation/
            ├── cubit/             # PerfectNumberCubit + States
            ├── screens/           # Home, Check, Range, History
            └── widgets/           # Reusable UI components
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>=3.41.2`
- Dart SDK `>=3.11.0`

### Run the app
```bash
git clone https://github.com/ViniciosM/perfect_numbers.git
cd perfect_numbers
flutter pub get
flutter gen-l10n
flutter run
```

### Run tests
```bash
flutter test
```

## 🧪 Test Coverage

| Layer | Suite | Tests |
|---|---|---|
| Domain | Use case unit tests | 12 |
| Presentation | Cubit unit tests | 13 |
| Presentation | Widget tests | 15 |
| **Total** | | **40** |

## 🌍 Localization

Supported languages: **English** (`en`) and **Portuguese BR** (`pt`).

To add a new language:
1. Create `lib/core/l10n/app_xx.arb` (where `xx` is the locale code)
2. Run `flutter gen-l10n`
3. Add `Locale('xx')` to `supportedLocales` in `main.dart`

## 💡 Perfect Numbers

A perfect number is a positive integer that equals the sum of its proper divisors (excluding itself).

| Number | Divisors | Sum |
|---|---|---|
| 6 | 1 + 2 + 3 | = 6 ✅ |
| 28 | 1 + 2 + 4 + 7 + 14 | = 28 ✅ |
| 496 | 1 + 2 + 4 + 8 + 16 + 31 + 62 + 124 + 248 | = 496 ✅ |
| 8128 | 1 + 2 + 4 + 8 + 16 + 32 + 64 + 127 + ... | = 8128 ✅ |


## 📱 Mobile Screenshots
| Check | Range | History |
| :---: | :---: | :---: |
| <img alt="check"  src="https://github.com/user-attachments/assets/2619df13-f9be-458a-8bb8-ddc45cf60d27" height="600"> | <img alt="find" src="https://github.com/user-attachments/assets/d656e7fc-46d3-4ca9-aa8b-9f5a6d49b9c1" height="600"> | <img  alt="history" src="https://github.com/user-attachments/assets/1c4f9277-1b25-4937-8bfc-1743c916cae9" height="600"> |
