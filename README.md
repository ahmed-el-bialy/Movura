<div align="center">

# 🎬 Movura

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-blue.svg?style=for-the-badge)](https://flutter.dev)

**A sleek, modern entertainment application for cinephiles and TV show enthusiasts. Discover, track, and explore the world of cinema and television with a premium dark user interface and seamless navigation.**

[✨ Features](#-features) • [📸 Screenshots](#-screenshots) • [🏗️ Architecture](#-architecture) • [🚀 Getting Started](#-getting-started) • [👤 Author](#-author)

</div>

---

## 🎯 Overview

**Movura** is a production-ready Flutter entertainment application that provides comprehensive movie and TV show information with ratings, reviews, and detailed content discovery. It features a premium high-contrast dark interface, smooth animations, intelligent search, and responsive design — built as a portfolio project demonstrating modern mobile development practices with clean architecture, BLoC state management, repository pattern, and type-safe API clients.

### 💡 Key Highlights
- 🎬 **Movie & Show Database** — Browse comprehensive database of movies and TV shows
- ⭐ **Smart Search** — Find movies and shows by title, actor, or genre
- 📝 **Detailed Information** — Complete cast, crew, plot, ratings, and reviews
- ⚡ **Fast Performance** — Cached images and optimized data fetching
- 🎥 **Multimedia Content** — Integrated trailers and video player
- 🌙 **Premium Dark UI** — High-contrast dark interface for eye comfort
- 📱 **Fully Responsive** — Adaptive layouts for all screen sizes
- 🛡️ **Error Resilience** — Graceful error handling and loading states
- 🏗️ **Clean Architecture** — Feature-based modular structure
- 🔌 **Type-Safe API** — Retrofit-generated HTTP client
- 💫 **Smooth Animations** — Shimmer effects and transitions
- 🔑 **Dependency Injection** — GetIt for scalable service management

---

## ✨ Features

### 🏠 Home Screen
- **Trending Movies** — Latest and most popular movies
- **Trending Shows** — Popular TV series and shows
- **Featured Content** — Curated recommendations
- **Quick Access** — Fast navigation to all categories
- **Loading States** — Shimmer skeleton loading animations

### 🔍 Search Feature
- **Multi-Category Search** — Search movies and shows simultaneously
- **Advanced Filters** — Filter by genre, year, rating
- **Auto-Complete** — Suggestions while typing
- **Search History** — Quick access to previous searches
- **Real-Time Results** — Live search results

### 📽️ Details Screen
- **Full Information** — Title, plot, ratings, release date
- **Cast & Crew** — Complete list with photos and roles
- **Reviews & Ratings** — User and critic reviews
- **Similar Content** — Recommendations based on title
- **Video Trailers** — Watch official trailers in-app
- **Share Options** — Share on social media

### 🎨 User Experience
- **Smart Image Handling** — Cached images with fallbacks
- **Dark Mode Interface** — Premium high-contrast theme
- **Smooth Animations** — Transitions and loading effects
- **Error States** — Helpful error messages
- **Empty States** — Friendly messages for no results
- **Responsive Design** — Works on all devices

### ⚙️ Technical Features
- **REST API Integration** — Real-time data via Retrofit + Dio
- **BLoC Architecture** — Clean state management
- **Repository Pattern** — Data abstraction layer
- **Type-Safe API** — Retrofit with annotations
- **JSON Serialization** — Automatic model conversion
- **Image Caching** — CachedNetworkImage optimization
- **Dependency Injection** — GetIt for service location
- **Environment Config** — `.env` file support
- **Shimmer Loading** — Professional skeleton screens
- **Video Integration** — YouTube trailer player

---

## 📸 Screenshots

| Home Screen | Search Results | Details View |
|:----------:|:-------------:|:----------:|
| Browse trending movies and shows | Search and filter content | Full movie/show details |

| Cast & Reviews | Dark Interface | Loading States |
|:-------------:|:----------:|:-------------:|
| Complete cast information | Premium dark theme | Smooth shimmer effects |

---

## 🛠️ Technical Stack

<div align="center">

| Component | Technology | Purpose |
|:-----------------:|:----------------:|:------------------------------:|
| **Framework** | Flutter 3.x | Cross-platform UI |
| **Language** | Dart 3.11+ | Core development |
| **State Management** | BLoC ^9.1.1 | Business logic layer |
| **HTTP Client** | Dio ^5.9.2 | Networking |
| **Type-Safe API** | Retrofit ^4.9.2 | API interfaces |
| **API Generator** | retrofit_generator ^10.2.6 | Code generation |
| **JSON Parsing** | json_serializable ^6.14.0 | Model serialization |
| **Build System** | build_runner ^2.15.0 | Code generation |
| **Debug Logging** | pretty_dio_logger ^1.4.0 | HTTP debugging |
| **Image Caching** | cached_network_image ^3.4.1 | Image optimization |
| **Video Player** | youtube_player_flutter ^9.1.3 | Trailer integration |
| **Responsive UI** | flutter_screenutil ^5.9.3 | Screen adaptation |
| **Shimmer** | shimmer ^3.0.0 | Loading animations |
| **Rating Widget** | flutter_rating_bar ^4.0.1 | User ratings |
| **Time Format** | timeago ^3.7.1 | Relative timestamps |
| **Expandable Pages** | expandable_page_view ^1.3.0 | Flexible layouts |
| **Localization** | intl ^0.20.2 | Multi-language support |
| **Service Locator** | get_it ^9.2.1 | Dependency injection |
| **Environment** | flutter_dotenv ^6.0.1 | Configuration |
| **Native Splash** | flutter_native_splash ^2.4.8 | Launch screen |
| **App Icons** | flutter_launcher_icons ^0.14.4 | Platform icons |
| **App Rename** | rename ^3.1.0 | Bundle configuration |
| **Design** | Material 3 | Latest design patterns |

</div>

---

## 🏗️ Architecture

### 📁 Clean Architecture Structure

```
lib/
├── main.dart                          # App entry point
│
├── core/                              # 🏢 Core Layer (Shared)
│   ├── networking/
│   │   ├── api_service.dart           # Retrofit API interface
│   │   ├── api_service.g.dart         # Generated Retrofit client
│   │   ├── di.dart                    # Dependency injection setup
│   │   └── constants.dart             # API constants
│   ├── routing/
│   │   └── app_router.dart            # Navigation management
│   ├── theming/
│   │   ├── colors.dart                # App color palette
│   │   ├── styles.dart                # Text styles
│   │   └── theme.dart                 # Material theme
│   ├── models/
│   │   ├── movie_model.dart           # Movie data model
│   │   ├── show_model.dart            # Show data model
│   │   └── *.g.dart                   # Generated JSON code
│   ├── widgets/
│   │   ├── shimmer_loader.dart        # Loading skeleton
│   │   ├── error_widget.dart          # Error display
│   │   └── common_widgets.dart        # Reusable components
│   └── utils/
│       ├── extensions.dart            # Dart extensions
│       ├── constants.dart             # App constants
│       └── helpers.dart               # Helper functions
│
├── features/                          # ✨ Feature Modules
│   ├── home/
│   │   ├── data/
│   │   │   ├── models/                # Home-specific models
│   │   │   ├── repositories/          # Data abstraction
│   │   │   └── data_sources/          # API calls
│   │   ├── presentation/
│   │   │   ├── bloc/                  # BLoC state management
│   │   │   ├── pages/                 # Home screen
│   │   │   └── widgets/               # Home widgets
│   │   └── home_feature.dart          # Feature barrel file
│   │
│   ├── search/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   ├── repositories/
│   │   │   └── data_sources/
│   │   ├── presentation/
│   │   │   ├── bloc/
│   │   │   ├── pages/
│   │   │   └── widgets/
│   │   └── search_feature.dart
│   │
│   └── details/
│       ├── data/
│       │   ├── models/
│       │   ├── repositories/
│       │   └── data_sources/
│       ├── presentation/
│       │   ├── bloc/
│       │   ├── pages/
│       │   └── widgets/
│       └── details_feature.dart

assets/
├── fonts/
│   ├── Manrope-Regular.ttf
│   ├── Montserrat-Regular.ttf
│   └── Sora-Regular.ttf
└── images/
    └── app_icons/
```

### 🔄 Data Flow Architecture

```
┌──────────────────────────────────────────────────────────┐
│                   UI Layer (Presentation)                 │
│              Pages, Widgets, BLoC Listeners              │
└──────────────────────────────────────────────────────────┘
                            ↑↓
┌──────────────────────────────────────────────────────────┐
│              Business Logic Layer (BLoC)                  │
│         State Management, Business Rules, Events         │
└──────────────────────────────────────────────────────────┘
                            ↑↓
┌──────────────────────────────────────────────────────────┐
│            Data Layer (Repositories)                      │
│         Abstract Data Access, Caching Strategy           │
└──────────────────────────────────────────────────────────┘
                            ↑↓
┌──────────────────────────────────────────────────────────┐
│          Data Sources (Remote API & Local Cache)         │
│     Retrofit HTTP Client, Database, Shared Preferences   │
└──────────────────────────────────────────────────────────┘
                            ↑↓
┌──────────────────────────────────────────────────────────┐
│                 External Services                         │
│              Movie API, YouTube, Analytics               │
└──────────────────────────────────────────────────────────┘
```

---

## 🌐 API Integration

The app integrates with a movie database API to fetch content.

| Endpoint | Method | Purpose |
|:---------|:------:|:--------|
| `/trending/movie/week` | `GET` | Trending movies |
| `/trending/tv/week` | `GET` | Trending shows |
| `/search/multi` | `GET` | Search movies & shows |
| `/movie/{id}` | `GET` | Movie details |
| `/tv/{id}` | `GET` | Show details |
| `/movie/{id}/videos` | `GET` | Trailers & videos |
| `/movie/{id}/credits` | `GET` | Cast & crew info |

**HTTP Client:** Dio with Retrofit, automatic JSON parsing, error handling

---

## ⚙️ Code Generation

This project uses Dart `build_runner` for automated code generation.

### Build Commands
```bash
# Generate code once
flutter pub run build_runner build

# Generate with conflict resolution
flutter pub run build_runner build --delete-conflicting-outputs

# Watch for changes (development)
flutter pub run build_runner watch --delete-conflicting-outputs
```

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter

  # State Management
  flutter_bloc: ^9.1.1

  # Networking
  dio: ^5.9.2
  retrofit: ^4.9.2
  retrofit_generator: ^10.2.6
  pretty_dio_logger: ^1.4.0

  # JSON
  json_annotation: ^4.12.0

  # UI & Media
  cached_network_image: ^3.4.1
  flutter_screenutil: ^5.9.3
  shimmer: ^3.0.0
  youtube_player_flutter: ^9.1.3
  flutter_rating_bar: ^4.0.1
  expandable_page_view: ^1.3.0
  cupertino_icons: ^1.0.9

  # Utilities
  timeago: ^3.7.1
  intl: ^0.20.2
  get_it: ^9.2.1
  flutter_dotenv: ^6.0.1

  # Native
  flutter_native_splash: ^2.4.8
  flutter_launcher_icons: ^0.14.4
  rename: ^3.1.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
  json_serializable: ^6.14.0
  build_runner: ^2.15.0
```

---

## 🚀 Getting Started

### 📋 Prerequisites

| Requirement | Version | Purpose |
|:----------:|:---------:|:---------|
| Flutter SDK | >=3.0.0 | Framework |
| Dart SDK | >=3.11.5 | Language |
| Movie API Key | — | Content database |

### 💻 Installation

```bash
# 1. Clone repository
git clone https://github.com/ahmed-el-bialy/Movura.git
cd Movura

# 2. Install dependencies
flutter pub get

# 3. Generate code (required)
flutter pub run build_runner build --delete-conflicting-outputs

# 4. Setup environment variables
#    Create .env file with your API key:
#    API_KEY=your_api_key_here
#    BASE_URL=https://api.themoviedb.org/3

# 5. Run the app
flutter run

# Build for production
flutter build apk --release      # Android
flutter build ios --release      # iOS
```

---

## 🎨 Customization

### Environment Variables (.env)
```env
API_KEY=your_movie_api_key
BASE_URL=https://api.themoviedb.org/3
LANGUAGE=en
IMAGE_BASE_URL=https://image.tmdb.org/t/p/w500
```

### App Branding
```bash
# Update app name and bundle ID
flutter pub run rename:main --bundleId com.example.movura
flutter pub run rename:main --appName "Movura"

# Generate splash screen
flutter pub run flutter_native_splash:create

# Generate app icons
flutter pub run flutter_launcher_icons:generate
```

---

## 🏃 Running

### Development
```bash
flutter run -v                    # Verbose mode
flutter run --profile             # Profile mode
```

### Testing
```bash
flutter test                      # Run all tests
flutter test --coverage           # Coverage report
```

### Build
```bash
flutter build apk --release       # Android APK
flutter build ios --release       # iOS app
flutter build web --release       # Web app
```

---

## 📊 Project Status

| Feature | Status |
|:--------|:------:|
| Home Screen | ✅ Complete |
| Movie Search | ✅ Complete |
| Details Page | ✅ Complete |
| Video Player | ✅ Complete |
| Cast & Reviews | ✅ Complete |
| Favorites | 🔄 In Progress |
| Dark Mode | 🔄 In Progress |
| Offline Cache | 🔄 Planned |
| Recommendations | 🔄 Planned |
| Social Share | 🔄 Planned |
| Notifications | 🔄 Planned |

---

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. **Fork** the repository
2. **Create** a feature branch: `git checkout -b feature/amazing-feature`
3. **Generate code** after changes: `flutter pub run build_runner build`
4. **Commit** with clear messages: `git commit -m 'feat: Add amazing feature'`
5. **Push** to branch: `git push origin feature/amazing-feature`
6. **Open** a Pull Request

### Code Style
- Follow [Dart style guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful names
- Add comments for complex logic
- Run linter: `flutter analyze`
- Format code: `dart format lib/`

---

## 📄 License

This project is licensed under the **MIT License** — see [LICENSE](LICENSE) for details.

---

## 🐛 Support

Found a bug or have feedback?
- **Report Issues:** [GitHub Issues](https://github.com/ahmed-el-bialy/Movura/issues)
- **Documentation:** [Wiki](https://github.com/ahmed-el-bialy/Movura/wiki)

---

## 👤 Author

<div align="center">

**Ahmed El-Bialy**  
*Flutter Developer | Mobile App Specialist*

[![LinkedIn](https://img.shields.io/badge/LinkedIn-%230077B5.svg?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/ahmedel-bialy/)
[![Email](https://img.shields.io/badge/Email-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:ah.elbialy.dev@gmail.com)
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/ahmed-el-bialy)

📧 **ah.elbialy.dev@gmail.com**  
📞 **+20 102 212 1573**

</div>

---

<div align="center">

### ⭐ Give this project a star if you found it helpful!

**Built with ❤️ by Ahmed El-Bialy**

</div>
