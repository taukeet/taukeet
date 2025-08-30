# 🛠️ Development Guide

Quick reference for Taukeet development and testing.

## 🚀 Quick Start

```bash
# Setup
git clone https://github.com/f24aalam/taukeet.git
cd taukeet
flutter pub get

# Run app
flutter run

# Run all tests
flutter test
```

## 🧪 Testing Commands

### Using Make (Recommended)
```bash
make help                 # Show all commands
make test                 # Run all tests  
make test-unit           # Unit tests only
make test-widget         # Widget tests only
make test-coverage       # Tests with coverage
make test-watch          # Watch mode
make ci-test             # Full CI pipeline
```

### Using Flutter CLI
```bash
flutter test                                    # All tests
flutter test --coverage                        # With coverage  
flutter test test/unit/                        # Unit tests
flutter test test/widget/                      # Widget tests
flutter test test/unit/entities/address_test.dart  # Single file
flutter test --watch                           # Watch mode
flutter test --verbose                         # Verbose output
```

## 📁 Test Structure

```
test/
├── helpers/test_helpers.dart    # Test utilities, mocks, factories
├── unit/
│   ├── entities/               # Data model tests (26 tests)
│   ├── implementations/        # Service implementation tests (25 tests) 
│   └── providers/             # State management tests (9 tests)
├── widget/                    # UI component tests (9 tests)
├── integration/               # End-to-end tests
└── all_tests.dart            # Test runner entry point
```

## 🧪 Test Types

### Entity Tests
Test data models, serialization, validation:
```bash
flutter test test/unit/entities/
```

### Service Tests  
Test business logic and external integrations:
```bash
flutter test test/unit/implementations/
```

### Provider Tests
Test state management with Riverpod:
```bash
flutter test test/unit/providers/
```

### Widget Tests
Test UI components and user interactions:
```bash
flutter test test/widget/
```

## 📊 Coverage Reports

```bash
# Generate coverage
flutter test --coverage

# Generate HTML report (requires lcov on Linux/macOS)
genhtml coverage/lcov.info -o coverage/html

# Open report
xdg-open coverage/html/index.html  # Linux
open coverage/html/index.html      # macOS
```

## 🔧 Development Commands

```bash
# Dependencies
make deps              # Install dependencies
flutter pub get        # Manual dependency install

# Code Quality  
make lint              # Run linter
make analyze           # Static analysis
make format            # Format code
flutter analyze        # Manual analysis
dart format lib/ test/ # Manual formatting

# Cleaning
make clean             # Clean and reinstall deps
flutter clean          # Clean build files
```

## 🏗️ Adding New Tests

### 1. Entity Test Example
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:taukeet/src/entities/my_entity.dart';

void main() {
  group('MyEntity Tests', () {
    test('should create entity with properties', () {
      // Arrange
      const entity = MyEntity(id: 1, name: 'test');
      
      // Act & Assert
      expect(entity.id, equals(1));
      expect(entity.name, equals('test'));
    });
  });
}
```

### 2. Widget Test Example
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taukeet/src/widgets/my_widget.dart';

void main() {
  group('MyWidget Tests', () {
    testWidgets('should display text', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: MyWidget(text: 'Hello'),
        ),
      );
      
      // Assert
      expect(find.text('Hello'), findsOneWidget);
    });
  });
}
```

### 3. Provider Test Example
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taukeet/src/providers/my_provider.dart';

void main() {
  group('MyProvider Tests', () {
    test('should update state', () {
      // Arrange
      final container = ProviderContainer();
      
      // Act
      container.read(myProvider.notifier).updateValue('new');
      
      // Assert
      expect(container.read(myProvider).value, equals('new'));
      
      container.dispose();
    });
  });
}
```

## 🎯 Testing Best Practices

### Structure
- Use **Arrange-Act-Assert** pattern
- Keep tests focused and independent  
- Use descriptive test names
- Group related tests with `group()`

### Data
- Use `TestDataFactory` for consistent test data
- Test edge cases and error conditions
- Include Arabic/Unicode text for i18n testing

### Mocking
- Mock external dependencies (network, storage, etc.)
- Use dependency injection for testability
- Verify mock interactions when relevant

### Widget Testing
- Test user interactions (taps, scrolls)
- Verify UI state changes
- Use `pumpAndSettle()` for async operations
- Test accessibility features

## 🔍 Debugging Tests

```bash
# Run with verbose output
flutter test --verbose

# Run single test with debugging
flutter test test/unit/entities/address_test.dart --verbose

# Print debug info in tests
debugPrint('Debug information');

# Run with coverage and verbose
flutter test --coverage --verbose
```

## 📋 Pre-commit Checklist

Before submitting code:

```bash
# 1. Format code
make format

# 2. Run static analysis  
make analyze

# 3. Run all tests
make test

# 4. Check test coverage
make test-coverage

# 5. Full CI pipeline
make ci-test
```

## 🐛 Troubleshooting

### Common Issues

**Import errors**: Check `pubspec.yaml` dependencies
```bash
flutter pub get
```

**Mock setup failures**: Verify mocks are configured before use
```dart
when(() => mockService.method()).thenReturn(result);
```

**Widget test failures**: Use `pumpAndSettle()` for async operations
```dart
await tester.pumpAndSettle();
```

**Provider test errors**: Dispose containers after use
```dart
container.dispose();
```

### Test Debugging

```bash
# Run specific failing test
flutter test test/unit/entities/address_test.dart

# Check for missing dependencies
flutter doctor

# Clean and rebuild
make clean
flutter pub get
```

## 🚢 CI/CD Integration

For continuous integration, use:
```bash
make ci-test
```

This runs:
1. `flutter pub get` - Install dependencies
2. `flutter analyze --fatal-infos` - Static analysis  
3. `flutter test --coverage` - All tests with coverage

## 📚 Resources

- [Flutter Testing Documentation](https://docs.flutter.dev/testing)
- [Riverpod Testing Guide](https://riverpod.dev/docs/cookbooks/testing)
- [Test Directory README](test/README.md) - Detailed testing guide
- [Mocktail Documentation](https://pub.dev/packages/mocktail)
