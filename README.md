# Community Turf Booking App - Sprint 2 (klyro)

## 📱 Project Overview
This project is a **mobile application designed to resolve scheduling conflicts and prevent double-booking** for community sports groups reserving local turfs. The app leverages **Flutter for cross-platform development** and **Firebase for real-time authentication and data management**.

### What is klyro?
**klyro** (the internal codename) is a community-driven turf booking platform that helps users:
- ✅ Browse and filter available sports turfs (cricket, football, tennis, badminton, etc.)
- ✅ Check real-time availability and prevent double-booking
- ✅ Book turfs with integrated payment and confirmation
- ✅ Manage their profile and booking history
- ✅ Get responsive experience across mobile, tablet, and web platforms

### Technology Stack
- **Frontend**: Flutter 3.11.0+, Dart
- **Backend**: Firebase (Authentication, Firestore Database, Cloud Functions)
- **Authentication**: Firebase Auth + Google Sign-In
- **Platforms**: Android, iOS, Web, Windows, Linux, macOS

---

## 📁 Folder Structure

### Quick Overview
For a **comprehensive understanding** of the folder structure, refer to **[PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md)** which includes:
- Detailed folder hierarchy with visual diagrams
- Purpose of each directory and file
- Naming conventions and code organization patterns
- Best practices for scalability and team collaboration

### Key Directories
```
klyro/
├── lib/                    # 🎯 Core app logic
│   ├── main.dart          # App entry point & Firebase init
│   ├── screens/           # Full-page UI components
│   ├── services/          # Business logic (Auth, API calls)
│   ├── theme/             # Design system & styling
│   ├── widgets/           # [Reserved] Reusable components
│   └── models/            # [Reserved] Data structures
├── android/               # Android platform config
├── ios/                   # iOS platform config
├── web/                   # Web platform files
├── test/                  # Automated tests
├── nginx/                 # 🐳 Nginx config for Docker
│   └── nginx.conf         # SPA routing & caching
├── Dockerfile             # 🐳 Multi-stage Docker build
├── docker-compose.yml     # 🐳 Docker Compose orchestration
├── .dockerignore          # 🐳 Docker build context filter
├── pubspec.yaml           # Dependencies & configuration
└── README.md              # This file
```

### Naming Conventions
* **Files/Directories**: `snake_case` (e.g., `login_screen.dart`)
* **Classes/Widgets**: `PascalCase` (e.g., `LoginScreen`)
* **Variables/Methods**: `camelCase` (e.g., `_isLoading`, `_submitForm()`)

## 🚀 Setup Instructions

### Prerequisites
- ✅ [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.11.0 or higher)
- ✅ [Dart SDK](https://dart.dev/get-dart) (included with Flutter)
- ✅ Git version control
- ✅ Android Studio or Xcode (for platform-specific development)
- ✅ Firebase project (for authentication and database)

### Initial Setup
1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd klyro
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Verify Flutter setup**:
   ```bash
   flutter doctor
   ```
   Ensure all required platforms show a checkmark ✓.

4. **Run the app**:
   ```bash
   # On an emulator or connected device
   flutter run
   
   # Or specify a device
   flutter run -d chrome        # Web
   flutter run -d emulator-5554 # Android emulator
   ```

### 🐳 Running with Docker

You can also build and serve the web version of klyro using Docker — no Flutter SDK required on the host machine.

**Prerequisites:**
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed and running

#### Option 1: Docker Compose (Recommended)
```bash
cd klyro
docker compose up --build
```
This builds the Flutter web app inside a container and serves it at **http://localhost:8080**.

#### Option 2: Manual Docker Build
```bash
cd klyro

# Build the image
docker build -t klyro-web .

# Run the container
docker run -d -p 8080:80 --name klyro-app klyro-web
```
Visit **http://localhost:8080** to access the app.

#### How It Works
The Dockerfile uses a **multi-stage build**:
1. **Build stage** — Uses the official Flutter SDK image to compile the web app (`flutter build web --release`)
2. **Serve stage** — Copies the compiled output into a lightweight **Nginx Alpine** container that serves it on port 80

This keeps the final image small (~25 MB) since it only contains the compiled static files and Nginx.

#### Useful Docker Commands
```bash
# Stop the running container
docker compose down

# Rebuild after code changes
docker compose up --build

# View container logs
docker compose logs -f
```

### Firebase Configuration
The app uses Firebase for authentication and data management.

- **Android**: Configuration is in `android/app/google-services.json`
- **iOS**: Configuration is in `ios/Runner/Info.plist`
- **Web**: Configuration is in `lib/firebase_options.dart` (auto-generated)

**To set up Firebase for your own project:**
1. Create a Firebase project at [firebase.google.com](https://firebase.google.com)
2. Enable Authentication (Email/Password, Google Sign-In)
3. Create a Firestore database
4. Download configuration files for each platform
5. Configure Google Sign-In OAuth consent screen

### Environment Configuration
Key configuration files:
- `lib/firebase_options.dart` — Firebase initialization for current platform
- `android/app/build.gradle.kts` — Android app configuration
- `ios/Runner/Info.plist` — iOS app metadata and permissions

## 🎯 Current Implementation Status

### Completed Features (Sprint 2)
- ✅ Firebase authentication setup (Email, Password, Google Sign-In)
- ✅ User login and signup screens
- ✅ Dashboard with navigation
- ✅ Venue listing and venue details screens
- ✅ User profile screen
- ✅ Responsive UI design (mobile, tablet, desktop)
- ✅ App theme and styling system

### In-Progress / Reserved
- 📋 Data models (`User`, `Turf`, `Booking`)
- 📋 Reusable widget components library
- 📋 Payment integration
- 📋 Real-time booking notifications
- 📋 Admin dashboard for venue management

---

## 💡 Reflection: Why Project Structure Matters

### 1. **Understanding Folder Organization**
A well-organized folder structure is **crucial for professional app development** because it:

- **Reduces Learning Curve**: New team members can quickly understand the codebase by mapping features to folder locations
- **Enables Parallel Development**: Multiple developers can work on different features (screens, services) simultaneously without conflicts
- **Simplifies Debugging**: When a bug occurs, developers know exactly where to look based on the feature type (UI → `screens/`, logic → `services/`)
- **Facilitates Code Reviews**: Reviewers can focus on specific concerns (is this a UI issue? A business logic issue?) based on file location

### 2. **Impact on Team Collaboration**
Consider these scenarios:

**Scenario A: Poor Organization** 
```
lib/
├── home.dart
├── auth.dart
├── filter.dart
├── database.dart
├── theme.dart
└── utils.dart
```
**Problems**: 
- Hard to find related code (Where is the login screen? Which file handles Firebase auth?)
- Developers step on each other's toes (Everyone modifying the same large files)
- Testing becomes difficult (Mixed UI and business logic)

**Scenario B: Modular Organization** ✅
```
lib/
├── screens/         # One file per screen
├── services/        # External integrations
├── theme/          # Design system
└── models/         # Data structures
```
**Benefits**:
- Clear ownership (Developer A owns `screens/venue_listing_screen.dart`, Developer B owns `services/firebase_service.dart`)
- Easy to add features without breaking existing code
- Testing is isolated (Unit test services separately from UI)
- Code reuse (Share theme and models across screens)

### 3. **Scalability in Growing Projects**
As the app grows from 1 developer → 5 developers → 20 developers:

| Team Size | Challenge | Well-Structured Solution |
|-----------|-----------|--------------------------|
| **1-2** | Prototyping speed | Modular structure prevents unnecessary refactoring |
| **3-5** | Parallel work without conflicts | Clear folder boundaries minimize merge conflicts |
| **10+** | Feature teams working independently | Each team owns their `screens/`, `services/`, `models/` |

With **klyro** growing to include:
- **Venue Module**: Browse, filter, and book turfs
- **Payment Module**: Secure payment processing
- **Admin Module**: Venue management dashboard
- **Notifications Module**: Real-time booking updates

...a modular structure **prevents these modules from tangling** together.

### 4. **Long-Term Maintenance**
In 1 year, when features are added and refactored:

- **Without structure**: "Where is the old booking logic?" (Hours spent searching)
- **With structure**: "Look in `services/` for the business logic, `screens/` for UI" (Minutes to find)

**Bottom Line**: A 20% time investment in good structure now saves 200% time in long-term maintenance.

---

## 📸 Project Folder Hierarchy (IDE View)

Here's what the project looks like when opened in VS Code or Android Studio:

```
klyro/
├── 📁 lib/
│   ├── 📄 main.dart                        # Entry point
│   ├── 📄 firebase_options.dart            # Firebase config
│   ├── 📁 screens/
│   │   ├── 📄 login_screen.dart
│   │   ├── 📄 signup_screen.dart
│   │   ├── 📄 dashboard_screen.dart
│   │   ├── 📄 venue_listing_screen.dart
│   │   ├── 📄 venue_details_screen.dart
│   │   ├── 📄 profile_screen.dart
│   │   ├── 📄 main_navigation_screen.dart
│   │   ├── 📄 welcome_screen.dart
│   │   └── 📄 responsive_home.dart
│   ├── 📁 services/
│   │   └── 📄 auth_service.dart            # Firebase auth logic
│   └── 📁 theme/
│       └── 📄 app_theme.dart               # Global theme config
├── 📁 android/                             # Android build files
├── 📁 ios/                                 # iOS build files
├── 📁 web/                                 # Web build files
├── 📁 test/
│   └── 📄 widget_test.dart
├── 📄 pubspec.yaml                         # Dependencies
├── 📄 analysis_options.yaml                # Linter config
├── 📄 README.md                            # This file
└── 📄 PROJECT_STRUCTURE.md                 # Detailed structure guide
```

---

## 📚 Demo & Visual Overview

### App Screenshots

#### Responsive UI Implementation (Sprint 2)
This sprint introduces **`responsive_home.dart`**, demonstrating adaptive cross-device interfaces. 

We handled varying screen sizes by using:
- `LayoutBuilder` — Dynamically adjust layout based on constraints
- `MediaQuery` — Detect screen dimensions and orientation
- Conditional layouts — Single column on mobile, two-column grid on tablets

**Mobile vs Tablet Layout:**
```dart
final double screenWidth = MediaQuery.of(context).size.width;
final bool isTablet = screenWidth > 600;

if (isTablet) {
  return Row(                    // Horizontal layout for tablets
    children: [sidebar, mainContent],
  );
} else {
  return Column(                 // Vertical layout for phones
    children: [mainContent],
  );
}
```

**Current Demo Screenshot:**  
![Mobile App Screenshot](https://res.cloudinary.com/dtepzmcs3/image/upload/v1772447694/Screenshot_20260302_155430_bicz16.jpg)

*(Note: Tablet layout demo to be added in next sprint)*

---

## 🔥 Hot Reload, Debug Console & DevTools

This section documents our workflow using Flutter's three most powerful development tools.

### 1. Hot Reload — Instant UI Updates

Hot Reload lets you see code changes reflected **instantly** in the running app without losing state.

**How we used it:**

1. Ran the app with `flutter run`
2. Changed the featured card text in `dashboard_screen.dart`:
   ```dart
   // Before
   Text('Book Venues With The\nBest Offers!');

   // After (Hot Reload change)
   Text('Find & Book Your\nPerfect Turf!');
   ```
3. Saved the file — the text updated instantly on screen without restarting the app

**How to use:**
- **VS Code**: Press `r` in the terminal or save the file (auto-triggers Hot Reload)
- **Android Studio**: Click the ⚡ Hot Reload button in the toolbar
- **Terminal**: Press `r` while `flutter run` is active

---

### 2. Debug Console — Real-Time Logging

The Debug Console shows runtime logs, errors, and custom `debugPrint()` output.

**What we added:**

| File | Log Message | Trigger |
|------|-------------|---------|
| `main.dart` | `🚀 TurfBookingApp initialized — Firebase ready` | App startup |
| `main.dart` | `🔒 User not logged in` / `✅ User logged in` | Auth state change |
| `login_screen.dart` | `🔑 Login attempt for: email` | Login button tapped |
| `login_screen.dart` | `✅ Login successful` / `❌ Login failed` | After login result |
| `main_navigation_screen.dart` | `📱 Navigated to tab: Home` | Tab switched |
| `dashboard_screen.dart` | `🏟️ Book Now tapped` | Book Now button pressed |

**Example code:**
```dart
void _login() async {
  debugPrint('🔑 Login attempt for: ${_emailController.text.trim()}');
  try {
    await _authService.login(email: email, password: password);
    debugPrint('✅ Login successful');
  } catch (error) {
    debugPrint('❌ Login failed: $error');
  }
}
```

> **Tip:** Use `debugPrint()` instead of `print()` for cleaner output with automatic line wrapping.

---

### 3. Flutter DevTools — Debugging & Performance

Flutter DevTools is a browser-based suite for inspecting your app.

**How to launch:**
```bash
# Option 1: From terminal
flutter pub global activate devtools
flutter pub global run devtools

# Option 2: From VS Code
# Run app in debug mode → Cmd/Ctrl+Shift+P → "Open DevTools"
```

**Key features we explored:**

| Tool | Purpose |
|------|---------|
| **Widget Inspector** | Visualize the widget tree, inspect layout constraints, and modify properties live |
| **Performance Tab** | View frame rendering times and identify jank |
| **Memory Tab** | Analyze memory usage and detect leaks |
| **Network Tab** | Monitor Firebase API calls and HTTP requests |

---

### 📸 Screenshots

> **Note:** Replace these placeholders with actual screenshots from your demo session.

1. **Hot Reload** — App before and after changing the featured card text
2. **Debug Console** — Terminal showing `debugPrint()` output during navigation & login
3. **Flutter DevTools** — Widget Inspector view of the DashboardScreen widget tree

---

### 💭 Reflection

**How does Hot Reload improve productivity?**
Hot Reload eliminates the compile-wait-restart cycle. Instead of waiting 30–60 seconds to see a UI change, you see it in under a second. This makes design iteration dramatically faster — you can tweak padding, colors, fonts, and layouts in real time. It preserves app state too, so you don't have to navigate back to the screen you're working on.

**Why is DevTools useful for debugging and optimization?**
DevTools provides visibility that `print()` statements alone cannot. The Widget Inspector shows the actual render tree (not just what you wrote), exposing unexpected nesting, overflow issues, and layout problems. The Performance tab helps you catch janky frames before users notice, and the Memory tab reveals leaks that would otherwise only surface in production.

**How can you use these tools in a team development workflow?**
- **Hot Reload** lets designers and developers iterate on UI together in real time during review sessions
- **Debug Console** logs (using `debugPrint`) give teammates a shared understanding of runtime behavior without needing to step through breakpoints
- **DevTools** screenshots can be attached to PRs to demonstrate performance before/after optimization, making code reviews more informed

---

## 🔧 Common Development Tasks

### Adding a New Screen
1. Create `lib/screens/feature_screen.dart`
2. Extend `StatefulWidget` or `StatelessWidget`
3. Add route in `main_navigation_screen.dart`
4. Test navigation

### Adding Business Logic
1. Create/extend a service in `lib/services/`
2. Call service from screen's `initState()` or state changes
3. Update UI based on service response

### Customizing Theme
1. Edit `lib/theme/app_theme.dart`
2. Update colors, fonts, button styles
3. Hot reload to preview changes (`Ctrl+\` in VS Code)

### Running Tests
```bash
flutter test                    # Run all tests
flutter test test/widget_test.dart  # Run specific test
```

---

## 🤝 Team Development Best Practices

### Code Ownership
- **Prabhdeep Singh**: Overall architecture, Firebase integration, theme
- **[Team Member 2]**: Venue screens and listing features
- **[Team Member 3]**: Payment and booking logic
- **[Team Member 4]**: Android/iOS platform-specific code

### Git Workflow
```bash
# Create feature branch
git checkout -b feature/venue-booking

# Make changes (following folder structure)
flutter pub get
flutter format .          # Format code
flutter analyze          # Check for lint issues

# Commit with clear messages
git commit -m "Add venue booking feature"

# Push and create pull request
git push origin feature/venue-booking
```

### Code Review Checklist
- ✅ Follows naming conventions (snake_case, PascalCase, camelCase)
- ✅ Added in correct folder (Screen in `screens/`? Service in `services/`?)
- ✅ No duplicate code (Check if similar code exists elsewhere)
- ✅ Includes error handling
- ✅ Widget tests added for new components
- ✅ No breaking changes to public APIs

---

## 📖 Additional Resources

### Official Documentation
- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Guide](https://dart.dev/guides)
- [Firebase for Flutter](https://firebase.flutter.dev/)
- [Flutter Best Practices](https://docs.flutter.dev/development/best-practices)

### Project-Specific Guides
- 📄 [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) — Detailed folder structure and conventions
- 🐛 [Troubleshooting](#troubleshooting) — Common issues and solutions
- 🔗 [Team Collaboration Guidelines](#team-development-best-practices)

### Visual Resources
- [Responsive Design Guide](https://docs.flutter.dev/development/ui/layout/responsive)
- [Firebase Console](https://console.firebase.google.com/)
- [Material Design System](https://m3.material.io/)

---

## 🐛 Troubleshooting

### Common Issues

**Q: `flutter pub get` fails**
```bash
# Clear cache and retry
flutter clean
flutter pub get
```

**Q: Firebase authentication not working**
- Verify `google-services.json` (Android) is in `android/app/`
- Check Firebase Console for authentication method being enabled
- Ensure app package name matches Firebase project configuration

**Q: Hot reload not updating UI**
- Try hot restart: `R` in terminal (full app restart)
- Or `flutter run` to rebuild completely

**Q: Build fails on iOS**
```bash
cd ios
pod repo update
pod install
cd ..
flutter run
```

**Q: App icon not showing**
- Regenerate icons: Run `flutter pub get` to ensure `flutter_launcher_icons` is installed
- Rebuild: `flutter clean && flutter run`

---

## 📝 Version History

### Dockerization — March 9, 2026
- ✅ Added multi-stage `Dockerfile` (Flutter build → Nginx serve)
- ✅ Added `docker-compose.yml` for one-command build & run
- ✅ Added `nginx/nginx.conf` with SPA routing & gzip compression
- ✅ Added `.dockerignore` for optimized build context

### Sprint 2 — March 5, 2026
- ✅ Enhanced project documentation
- ✅ Created comprehensive PROJECT_STRUCTURE.md
- ✅ Implemented responsive UI design
- ✅ Firebase integration complete
- ✅ Authentication screens (Login, Signup)
- ✅ Venue browsing and details screens

### Sprint 1 — February 2026
- ✅ Project initialization
- ✅ Flutter setup and configuration
- ✅ Welcome screen implementation
- ✅ Basic theme system

---

## 📋 Future Roadmap

### Sprint 3 (Planned)
- [ ] Payment integration (Stripe/Razorpay)
- [ ] Real-time booking notifications
- [ ] User reviews and ratings
- [ ] Search filters and sorting

### Sprint 4 (Planned)
- [ ] Admin dashboard
- [ ] Venue management features
- [ ] Advanced calendar integration
- [ ] Analytics dashboard

### Future Enhancements
- [ ] Multi-language support (i18n)
- [ ] Dark mode support
- [ ] Offline-first capabilities
- [ ] Performance optimization
- [ ] AI-powered recommendations

---

## 📞 Support & Contact

For questions, issues, or contributions:

1. **Check documentation**: First, refer to [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md)
2. **Search existing issues**: Look in the repository's issue tracker
3. **Create new issue**: Provide detailed description and steps to reproduce
4. **Contact project lead**: Reach out to Prabhdeep Singh for architecture questions

---

## 📄 License

This project is private and not licensed for public distribution.

---

## 🎉 Conclusion

The **Community Turf Booking App (klyro)** demonstrates professional Flutter development practices. The modular folder structure, clear naming conventions, and well-documented codebase ensure that:

✅ **Scalability** — Easy to add new features
✅ **Maintainability** — Clear separation of concerns
✅ **Collaboration** — Multiple developers can work efficiently
✅ **Quality** — Consistent patterns and best practices

By investing in proper structure and documentation now, we're building a foundation that supports rapid growth and protects code quality as the project scales.

---

**Last Updated**: March 5, 2026  
**Maintained By**: Prabhdeep Singh  
**Project Repository**: [S66-032026-flutterfirebase-turf-management-app](.)

