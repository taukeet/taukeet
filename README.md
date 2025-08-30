# Taukeet - Salah Timing App 🕌

Taukeet is an open-source Flutter application that provides accurate Salah (Islamic prayer) timings. We use the [Adhan Dart](https://github.com/iamriajul/adhan-dart) package by [Riajul Islam](https://github.com/iamriajul) for precise prayer time calculations.

## 🌟 Features

- **Accurate Prayer Times** - Precise Salah timings using multiple calculation methods
- **Location-based** - Automatic location detection with manual override option
- **Multiple Languages** - Support for English, Arabic, Urdu, and Hindi
- **Customizable Settings** - Adjust calculation methods, madhabs, and time adjustments
- **Clean UI** - Modern, intuitive interface with dark theme support
- **Cross-platform** - Runs on Android, iOS, Web, Windows, macOS, and Linux

## 🚀 Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) (3.1.0 or higher)
- [Dart](https://dart.dev/get-dart) (3.0 or higher)
- Android Studio / VS Code with Flutter extensions

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/f24aalam/taukeet.git
   cd taukeet
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 🧪 Testing

Taukeet has a comprehensive test suite with **60+ tests** covering entities, services, providers, and widgets.

### Quick Test Commands

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test categories
flutter test test/unit/         # Unit tests only
flutter test test/widget/       # Widget tests only  
flutter test test/integration/  # Integration tests only
```

### Using Make Commands (Recommended)

```bash
# See all available commands
make help

# Run tests
make test              # All tests
make test-unit         # Unit tests only
make test-widget       # Widget tests only
make test-coverage     # Tests with coverage report
make test-watch        # Tests in watch mode

# Development commands
make deps              # Install dependencies
make lint              # Run linter
make analyze           # Static analysis
make format            # Format code
make clean             # Clean build files
```

### Test Structure

Our tests are organized in a clear hierarchy:

```
test/
├── helpers/           # Test utilities and mocks
├── unit/             # Unit tests (entities, services, providers)
├── widget/           # Widget tests
├── integration/      # End-to-end tests
└── README.md         # Detailed testing guide
```

**Test Coverage:**
- ✅ **26 Entity tests** - Data models and serialization
- ✅ **25 Service tests** - Prayer time calculations and business logic  
- ✅ **9 Provider tests** - State management with Riverpod
- ✅ **9 Widget tests** - UI components and interactions

### Running Individual Tests

```bash
# Run a specific test file
flutter test test/unit/entities/address_test.dart

# Run tests with verbose output
flutter test --verbose

# Run tests matching a pattern
flutter test --plain-name "Address Entity"
```

### Coverage Reports

```bash
# Generate coverage
flutter test --coverage

# Generate HTML report (requires lcov)
genhtml coverage/lcov.info -o coverage/html

# Open coverage report
open coverage/html/index.html  # macOS
xdg-open coverage/html/index.html  # Linux
```

## 🏗️ Architecture

Taukeet follows Flutter best practices with a clean architecture:

```
lib/
├── main.dart                 # App entry point
└── src/
    ├── app.dart             # App configuration and routing
    ├── entities/            # Data models
    ├── services/            # Abstract service interfaces
    ├── implementations/     # Concrete service implementations  
    ├── providers/           # State management (Riverpod)
    ├── screens/             # App screens/pages
    ├── widgets/             # Reusable UI components
    ├── utils/               # Helper utilities
    └── exceptions/          # Custom exceptions
```

### Key Dependencies

- **State Management**: [Riverpod](https://pub.dev/packages/flutter_riverpod) 2.6.1
- **Navigation**: [GoRouter](https://pub.dev/packages/go_router) 14.2.9  
- **Prayer Calculations**: [Adhan](https://pub.dev/packages/adhan) 2.0.0
- **Location Services**: [Location](https://pub.dev/packages/location) 7.0.0
- **Internationalization**: Built-in Flutter i18n
- **Local Storage**: [SharedPreferences](https://pub.dev/packages/shared_preferences) 2.5.2

## 🤝 Contributing

We welcome contributions of all kinds! Here's how you can help:

1. **🐛 Report Bugs** - [Create an issue](https://github.com/f24aalam/taukeet/issues)
2. **💡 Suggest Features** - [Start a discussion](https://github.com/f24aalam/taukeet/discussions)
3. **🔧 Submit PRs** - See our [Contributing Guidelines](CONTRIBUTING.md)
4. **📖 Improve Docs** - Help us make documentation better
5. **🧪 Add Tests** - Improve our test coverage

### Development Workflow

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Write tests** for your changes
4. **Make** your changes
5. **Run tests** to ensure everything works (`make test`)
6. **Commit** your changes (`git commit -m 'Add amazing feature'`)
7. **Push** to the branch (`git push origin feature/amazing-feature`)
8. **Open** a Pull Request

### Code Quality

We maintain high code quality standards:

```bash
# Before submitting a PR, run:
make ci-test    # Runs dependencies, analysis, and tests with coverage
make format     # Format your code
make analyze    # Static analysis
```

## 📱 Supported Platforms

- ✅ **Android** (API 21+)
- ✅ **iOS** (iOS 11+)  
- ✅ **Web** (Modern browsers)
- ✅ **Windows** (Windows 10+)
- ✅ **macOS** (macOS 10.14+)
- ✅ **Linux** (64-bit)

## 🗺️ Roadmap

- [x] ✅ **Tests** - Comprehensive test suite with 60+ tests
- [x] ✅ **Localization** - Multi-language support  
- [ ] 🔔 **Notifications** - Prayer time notifications
- [ ] 🧭 **Qiblah Direction** - Compass pointing to Mecca
- [ ] 📺 **TV Support** - Android TV and Apple TV apps
- [ ] ⌚ **Wearables** - Apple Watch and Wear OS apps
- [ ] 🌙 **Islamic Calendar** - Hijri calendar integration
- [ ] 📿 **Dhikr Counter** - Digital tasbih

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Riajul Islam](https://github.com/iamriajul) for the [Adhan Dart](https://github.com/iamriajul/adhan-dart) package
- The Flutter community for amazing packages and support
- All contributors who help make Taukeet better

## 📞 Support & Community

- 💬 **Discussions**: [GitHub Discussions](https://github.com/f24aalam/taukeet/discussions)
- 🐛 **Bug Reports**: [GitHub Issues](https://github.com/f24aalam/taukeet/issues)
- 📧 **Email**: [Contact Us](mailto:your-email@example.com)

---

**Made with ❤️ for the Muslim community**
