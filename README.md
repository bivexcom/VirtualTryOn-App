# 🎨 Virtual Try-On App

An AI-powered virtual try-on application built with Flutter following Clean Architecture principles.

## ✨ Features

- 🤖 AI-powered virtual garment try-on
- 👕 Support for up to 2 garment items simultaneously
- 🏬 Branded catalog (Zara, COS, Miu Miu, etc.)
- 📸 Photo gallery of generated looks
- 🌍 Multi-language support (9 languages)
- 🎨 Light & Dark themes
- 📱 Modern, smooth UI with animations

## 🚀 Quick Start

### Prerequisites
- Flutter SDK 3.8.1+
- Dart SDK
- iOS Simulator / Android Emulator / Physical Device

### Installation

1. **Clone and navigate to the project:**
```bash
cd virtual_try_on
```

2. **Install dependencies:**
```bash
flutter pub get
```

3. **Generate code (AutoRoute, Injectable, Freezed):**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. **Generate localizations:**
```bash
flutter gen-l10n
```

5. **Run the app:**
```bash
flutter run
```

## 📦 Tech Stack

### Core Framework
- **Flutter** - UI framework
- **Dart** - Programming language

### Architecture
- **Clean Architecture** - Separation of concerns
- **Bloc Pattern** - State management
- **HydratedBloc** - Persistent state
- **GetIt + Injectable** - Dependency injection

### Navigation & Routing
- **AutoRoute** - Type-safe routing with code generation
- **Cupertino Transitions** - Smooth iOS-style page transitions

### Data & Serialization
- **Freezed** - Immutable data classes with union types
- **JsonSerializable** - JSON serialization
- **Dio + Retrofit** - HTTP networking

### UI & UX
- **Material Design 3** - Modern UI components
- **Custom Themes** - Light & Dark modes
- **Haptic Feedback** - Touch response
- **Shimmer** - Loading placeholders
- **Cached Network Images** - Optimized image loading

### Internationalization
- **intl + ARB** - Multi-language support
- **9 Languages** - EN, TR, DE, FR, ES, IT, PT, RU, NL

### Testing
- **flutter_test** - Widget testing
- **bloc_test** - Bloc unit testing
- **mocktail** - Mocking library

## 📂 Project Structure

See [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) for detailed documentation.

```
lib/
├── application/      # Business logic (Bloc)
├── core/            # Utilities, constants, DI
├── const/           # Theme, colors, typography
├── l10n/            # Localization files
├── presentation/    # UI screens & widgets
├── repository/      # Data layer (models, services)
└── main.dart       # App entry point
```

## 🎯 Key Features Implementation

### 1. Onboarding Flow
- Welcome screen with hero animations
- Style preference selection
- Terms & Privacy policy links

### 2. Try-On Experience
- **Custom Mode**: Upload your own garments
- **Catalog Mode**: Browse branded items
- Gender selection
- Max 2 items per look
- Real-time AI processing

### 3. Gallery
- Grid view of all generated looks
- Filter by brand/category
- Quick access to result details

### 4. Profile & Settings
- Language selection (9 languages)
- Theme toggle (Light/Dark/System)
- Account preferences

## 🎨 Design System

### Colors
**Light Theme:**
- Background: #FFFFFF
- Surface: #F8F9FA
- Primary: #E91E63 (Pink)
- Secondary: #9C27B0 (Purple)

**Dark Theme:**
- Background: #0A0A0F
- Surface: #101015
- Primary: #FF4081 (Bright Pink)
- Secondary: #AB47BC (Light Purple)

### Typography
- Modern sans-serif font family
- Hierarchical text styles
- Accessible font sizes

### Spacing & Layout
- Consistent padding scale (4px to 40px)
- Rounded corners (20-28px radius)
- Soft shadows with 15-25px blur

## 🌍 Supported Languages

1. 🇬🇧 English
2. 🇹🇷 Turkish
3. 🇩🇪 German
4. 🇫🇷 French
5. 🇪🇸 Spanish
6. 🇮🇹 Italian
7. 🇵🇹 Portuguese
8. 🇷🇺 Russian
9. 🇳🇱 Dutch

## 🛠️ Development

### Code Generation
```bash
# Watch mode for continuous generation
flutter pub run build_runner watch --delete-conflicting-outputs

# One-time generation
flutter pub run build_runner build --delete-conflicting-outputs
```

### Adding a New Feature
1. Create feature folder in `lib/application/`
2. Create Bloc with Freezed states
3. Add screen in `lib/presentation/pages/`
4. Register route in `lib/core/router/app_router.dart`
5. Run code generation

### Testing
```bash
# Run all tests
flutter test

# With coverage
flutter test --coverage
```

### Localization
```bash
# After modifying ARB files
flutter gen-l10n
```

## 📱 Navigation Structure

```
Onboarding Screen (initial)
    ↓
Main Navigation (Bottom Tabs)
    ├── Try-On Tab
    │   ├── Custom
    │   └── Catalog
    ├── Gallery Tab
    └── Profile Tab
        └── Settings
```

## ⚡ Performance Optimizations

- ✅ Const constructors throughout
- ✅ Cached network images
- ✅ Shimmer loading states
- ✅ Lazy loading lists
- ✅ Optimized build methods
- ✅ Code splitting via routes

## 🔒 State Persistence

HydratedBloc automatically persists:
- User theme preference
- Selected language
- Last used configuration
- Gallery history

## 📖 Documentation

- [Setup Guide](SETUP_COMPLETE.md) - Complete setup documentation
- [Project Structure](PROJECT_STRUCTURE.md) - Detailed architecture guide
- [Rules](/.cursor/rules/rules.md) - Development guidelines and standards

## 🤝 Contributing

1. Follow Clean Architecture principles
2. Use Bloc for state management
3. All UI text must use localization
4. Add haptic feedback to interactions
5. Write tests for new features
6. Run `flutter analyze` before committing

## 📝 Code Style

- ✅ Use const constructors
- ✅ No widget-returning functions
- ✅ Use context extensions
- ✅ Add haptic feedback
- ✅ No hardcoded strings
- ✅ Proper error handling in Blocs

## 🎓 Architecture Principles

1. **Clean Architecture** - Clear separation of concerns
2. **Feature-Based** - Organized by business features
3. **SOLID Principles** - Maintainable code
4. **Dependency Injection** - Loose coupling
5. **Testability** - Easy to test at all levels

## 📄 License

This project is private and proprietary.

## 🚀 Deployment

### iOS
```bash
flutter build ios --release
```

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

---

**Status:** ✅ Ready for development
**Version:** 1.0.0
**Last Updated:** November 12, 2025

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
