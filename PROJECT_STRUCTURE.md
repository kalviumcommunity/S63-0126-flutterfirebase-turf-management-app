# Flutter Project Structure Guide - Turf Booking App

## Introduction

This document provides a comprehensive overview of the folder structure for the **Turf Booking App** (codename: `klyro`), a Flutter-based mobile application for managing community turf reservations and preventing double-bookings.

A well-organized folder structure is essential for:
- **Scalability**: Easy to add new features without disrupting existing code
- **Maintainability**: Clear separation of concerns makes debugging and updates straightforward
- **Collaboration**: Team members can quickly understand the codebase and locate relevant files
- **Performance**: Modular organization supports lazy loading and efficient code splitting

---

## Folder Hierarchy

```
klyro/
├── lib/                              # Core application logic
│   ├── main.dart                     # App entry point & Firebase initialization
│   ├── firebase_options.dart         # Firebase configuration for multiple platforms
│   ├── screens/                      # Full-page UI components
│   │   ├── login_screen.dart         # User authentication interface
│   │   ├── signup_screen.dart        # User registration interface
│   │   ├── dashboard_screen.dart     # Main app dashboard
│   │   ├── venue_listing_screen.dart # Turf/venue search & filtering
│   │   ├── venue_details_screen.dart # Detailed venue information & booking
│   │   ├── profile_screen.dart       # User profile management
│   │   ├── main_navigation_screen.dart # Bottom navigation & routing
│   │   ├── welcome_screen.dart       # Initial onboarding/welcome interface
│   │   └── responsive_home.dart      # Responsive layout handler
│   ├── services/                     # Business logic & external API calls
│   │   └── auth_service.dart         # Firebase authentication service
│   ├── theme/                        # Design system & styling
│   │   └── app_theme.dart            # Theme colors, text styles, and Material config
│   ├── widgets/                      # [Reserved] Reusable UI components
│   └── models/                       # [Reserved] Data structures
│
├── android/                          # Android platform-specific code
│   ├── app/
│   │   ├── build.gradle.kts          # App-level dependencies & build config
│   │   └── src/
│   │       └── ...                   # Android source files (manifest, resources)
│   ├── build.gradle.kts              # Project-level build configuration
│   └── gradle/                       # Gradle wrapper & configuration
│
├── ios/                              # iOS platform-specific code
│   ├── Runner/
│   │   ├── Info.plist                # iOS app metadata (permissions, icons)
│   │   ├── AppDelegate.swift         # iOS app lifecycle handler
│   │   ├── Runner-Bridging-Header.h  # Objective-C to Swift bridging
│   │   └── Assets.xcassets/          # iOS app icons & images
│   ├── Runner.xcodeproj/             # Xcode project configuration
│   └── Flutter/                      # Flutter iOS framework configuration
│
├── web/                              # Web platform files
│   ├── index.html                    # Web entry point
│   ├── manifest.json                 # PWA manifest for web installation
│   └── icons/                        # Web app icons
│
├── windows/                          # Windows desktop build files
├── linux/                            # Linux desktop build files
├── macos/                            # macOS desktop build files
│
├── test/                             # Automated tests
│   └── widget_test.dart              # Widget & UI testing example
│
├── nginx/                            # 🐳 Nginx configuration for Docker
│   └── nginx.conf                    # SPA routing, gzip, caching
├── Dockerfile                        # 🐳 Multi-stage Docker build
├── docker-compose.yml                # 🐳 Docker Compose orchestration
├── .dockerignore                     # 🐳 Docker build context filter
│
├── pubspec.yaml                      # Dependency management & configuration
├── pubspec.lock                      # Locked dependency versions (auto-generated)
├── analysis_options.yaml             # Dart linter rules & analysis settings
├── .gitignore                        # Files/folders to exclude from Git
├── README.md                         # Project overview & setup instructions
├── .metadata                         # Flutter project metadata
└── image.png                         # Project screenshot/icon


```

---

## Key Folders & Files Explained

### 1. **lib/** — Core Application Logic
The heart of your Flutter application containing all Dart code.

| Subfolder | Purpose | Status |
|-----------|---------|--------|
| `main.dart` | **Entry point** — initializes Firebase, configures global theme, sets up routing based on auth state | ✅ Active |
| `screens/` | **Full-page views** — each file is a complete screen user navigates to | ✅ Active |
| `services/` | **Business logic** — handles Firebase auth, API calls, and data operations | ✅ Active |
| `theme/` | **Design system** — centralized colors, typography, and Material theme | ✅ Active |
| `widgets/` | **Reusable components** — custom buttons, input fields, cards (reserved for future use) | 📋 Reserved |
| `models/` | **Data structures** — Dart classes for Turf, Booking, User, etc. (reserved for future use) | 📋 Reserved |

### 2. **android/** — Android Platform Configuration
Contains all Android-specific build files, dependencies, and native code.

- **`app/build.gradle.kts`** — Defines app name, version, target SDK, and dependencies
- **`app/src/`** — AndroidManifest.xml and Android resources
- **`google-services.json`** — Firebase configuration for Android
- **`gradle/wrapper/`** — Gradle build system files (do not modify)

### 3. **ios/** — iOS Platform Configuration
Contains iOS-specific configuration for Xcode builds.

- **`Runner/Info.plist`** — Declares permissions, app metadata, and supported orientations
- **`Runner/AppDelegate.swift`** — iOS app lifecycle management
- **`Runner.xcodeproj/`** — Xcode project configuration (managed by Flutter)
- **`Flutter/`** — Framework configuration files (auto-managed)

### 4. **test/** — Automated Testing
Contains unit tests, widget tests, and integration tests.

- **`widget_test.dart`** — Example widget test that validates UI components
- Use this folder to ensure code quality and prevent regressions

### 5. **Assets** (Currently Not Implemented)
Although not present in the current structure, you'll want to create:

```
assets/
├── images/
│   ├── logo.png
│   ├── venue_placeholder.png
│   └── ...
├── fonts/
│   ├── Roboto-Regular.ttf
│   └── ...
└── data/
    └── sample_venues.json
```

Then declare in `pubspec.yaml`:
```yaml
flutter:
  assets:
    - assets/images/
    - assets/fonts/
    - assets/data/
```

### 6. **pubspec.yaml** — Project Configuration
The most critical file in a Flutter project.

```yaml
dependencies:
  flutter: sdk: flutter
  firebase_core: ^3.6.0      # Firebase initialization
  firebase_auth: ^5.3.1      # Authentication
  cloud_firestore: ^5.4.4    # Database
  google_sign_in: ^6.2.1     # Google OAuth
```

**Current Dependencies:**
- Firebase Core, Auth, Firestore (backend services)
- Google Sign-In (OAuth provider)
- Cupertino Icons (iOS-style icons)

### 7. **Supporting Configuration Files**

| File | Purpose |
|------|---------|
| `.gitignore` | Lists build artifacts, IDE files, and secrets (e.g., `android/`, `.dart_tool/`, `build/`) |
| `analysis_options.yaml` | Dart linter rules for code quality |
| `.metadata` | Flutter-generated metadata (do not modify) |
| `README.md` | Project overview, setup, and reflection |

### 8. **Docker Configuration** — Containerized Web Deployment
Docker files enable building and serving the Flutter web app in a portable container.

| File | Purpose |
|------|---------|
| `Dockerfile` | Multi-stage build: Stage 1 uses Flutter SDK to compile the web app, Stage 2 uses Nginx Alpine to serve it |
| `docker-compose.yml` | One-command orchestration — `docker compose up --build` builds and runs on port 8080 |
| `nginx/nginx.conf` | Custom Nginx config with SPA `try_files` fallback, gzip compression, and static asset caching |
| `.dockerignore` | Excludes platform dirs (`android/`, `ios/`, etc.), build artifacts, and IDE files to keep the build context small |

---

## Project Structure Diagram

```
┌─────────────────────────────────────────────────────┐
│         TurfBookingApp (main entry point)            │
│  Firebase Init + Theme + Auth-based Navigation      │
└──────────────────┬──────────────────────────────────┘
                   │
        ┌──────────┼──────────────┐
        │          │              │
    Screens    Services        Theme
    │              │              │
    ├─ Login    ├─ Auth      ├─ AppTheme
    ├─ Signup   └─ [Reserved] └─ Colors/Typography
    ├─ Dashboard
    ├─ Venues
    ├─ Profile
    └─ Navigation

Backend: Firebase (Auth, Firestore, Cloud Functions)
Platforms: Android, iOS, Web, Windows, Linux, macOS
```

---

## Code Organization Conventions

### Naming Conventions
- **Files/Directories**: `snake_case`  
  Example: `login_screen.dart`, `auth_service.dart`
- **Classes/Widgets**: `PascalCase`  
  Example: `LoginScreen`, `AuthService`
- **Variables/Methods**: `camelCase`  
  Example: `_isLoading`, `_submitForm()`
- **Constants**: `camelCase` with leading underscore if private  
  Example: `const double _defaultPadding = 16.0`

### Import Organization
```dart
// 1. Dart imports
import 'dart:async';

// 2. Flutter imports
import 'package:flutter/material.dart';

// 3. Package imports
import 'package:firebase_auth/firebase_auth.dart';

// 4. Relative imports
import 'screens/login_screen.dart';
```

### Widget Structure Pattern
```dart
class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  // Variables
  // Lifecycle methods (initState, dispose)
  // Helper methods
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(...);
  }
}
```

---

## Why This Structure Matters

### ✅ Scalability
As features grow, modular organization makes it easy to:
- Add new screens without modifying existing code
- Create service layers for new APIs
- Implement features independently in parallel teams

### ✅ Maintainability
Clear separation ensures:
- **Single Responsibility**: Each file has one clear purpose
- **DRY Principle**: Shared logic lives in services, not duplicated across screens
- **Easy Debugging**: Knowing where to look for specific functionality

### ✅ Team Collaboration
With defined structures:
- Developers can work on different features simultaneously
- Code reviews are faster (consistent patterns)
- Onboarding new team members is straightforward
- Clear ownership: "UI changes go in `/screens`, logic goes in `/services`"

### ✅ Performance Optimization
Modular structure supports:
- Lazy loading of screens via named routes
- Code splitting for different app modules
- Efficient state management (isolate state to relevant screens)

---

## Common Tasks & Where to Find/Add Code

| Task | Location |
|------|----------|
| Add a new screen | `lib/screens/new_screen.dart` |
| Add Firebase logic | `lib/services/` (extend `auth_service.dart` or create new service) |
| Add reusable button | `lib/widgets/custom_button.dart` (create folder if needed) |
| Add data model | `lib/models/user_model.dart` (create folder if needed) |
| Change theme colors | `lib/theme/app_theme.dart` |
| Change app name | `pubspec.yaml` → `name:`, plus `android/app/build.gradle.kts` |
| Add dependencies | `pubspec.yaml` → update, then run `flutter pub get` |
| Add app icon | Update `android/app/src/main/res/mipmap/` and `ios/Runner/Assets.xcassets/` |

---

## Next Steps: Recommended Folder Expansion

As the app grows, consider adding:

```
lib/
├── models/              # Data structures (User, Turf, Booking)
├── widgets/             # Reusable UI components
├── providers/           # State management (Provider, Riverpod, GetX)
├── repositories/        # Data layer abstraction
├── utils/               # Helper functions, constants, validators
├── constants/           # App-wide constants & config
└── localization/        # Multi-language support
```

---

## References
- [Flutter Project Structure Best Practices](https://docs.flutter.dev/development/best-practices)
- [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- [Firebase for Flutter](https://firebase.flutter.dev/)

---

**Last Updated:** March 9, 2026  
**Project:** Community Turf Booking App (klyro)
