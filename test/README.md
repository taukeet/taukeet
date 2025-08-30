# Taukeet Testing Guide

This directory contains comprehensive tests for the Taukeet prayer time application.

## Test Structure

```
test/
├── helpers/                 # Test utilities and mocks
│   └── test_helpers.dart   # Common test data and utilities
├── unit/                   # Unit tests
│   ├── entities/          # Entity/model tests
│   ├── providers/         # State management tests  
│   ├── services/          # Service interface tests
│   └── implementations/   # Service implementation tests
├── widget/                 # Widget tests
│   ├── screens/           # Screen widget tests
│   └── widgets/           # Component widget tests
├── integration/            # Integration tests
└── all_tests.dart         # Entry point for all tests
```

## Running Tests

### Using Flutter Commands

```bash
# Run all tests
flutter test

# Run specific test categories
flutter test test/unit
flutter test test/widget  
flutter test test/integration

# Run with coverage
flutter test --coverage

# Run a specific test file
flutter test test/unit/entities/address_test.dart
```

### Using the Test Runner Script

We've provided a custom test runner with additional features:

```bash
# Make the script executable (Linux/Mac)
chmod +x test_runner.dart

# Run all tests
dart test_runner.dart

# Run specific categories
dart test_runner.dart --unit
dart test_runner.dart --widget
dart test_runner.dart --integration

# Run with coverage
dart test_runner.dart --coverage

# Watch mode - rerun tests on file changes
dart test_runner.dart --watch

# Get help
dart test_runner.dart --help
```

## Test Categories

### Unit Tests

**Entities** - Test data models and their behavior:
- `address_test.dart` - Address entity serialization, validation
- `adjustments_test.dart` - Prayer time adjustments model  
- `prayer_time_test.dart` - Prayer time data structure

**Providers** - Test state management logic:
- `settings_provider_test.dart` - Settings state management
- `prayer_time_provider_test.dart` - Prayer time state management

**Services** - Test business logic implementations:
- `adhan_impl_test.dart` - Prayer time calculation service

### Widget Tests

**Components** - Test individual UI components:
- `primary_button_test.dart` - Primary button component
- `secondary_button_test.dart` - Secondary button component

**Screens** - Test complete screen widgets:
- `home_screen_test.dart` - Main prayer times screen
- `settings_screen_test.dart` - Settings configuration screen

### Integration Tests

End-to-end tests that verify complete user workflows:
- Navigation between screens
- Location fetching and prayer time calculation
- Settings persistence

## Test Data and Utilities

The `test/helpers/test_helpers.dart` file provides:

- **Mock Services**: Pre-configured mocks for external dependencies
- **Test Data Factories**: Generate consistent test data
- **Test Utilities**: Helper functions for common test operations
- **Custom Matchers**: Domain-specific test assertions

### Example Usage

```dart
import '../../helpers/test_helpers.dart';

void main() {
  group('My Tests', () {
    test('should create test address', () {
      final address = TestDataFactory.createTestAddress();
      expect(address.latitude, equals(24.8607));
    });

    test('should mock geo service', () {
      final mockService = MockGeoLocationService();
      // Configure mock behavior
    });
  });
}
```

## Coverage Reports

When running tests with coverage:

```bash
# Generate coverage
flutter test --coverage

# Generate HTML report (requires lcov)
genhtml coverage/lcov.info -o coverage/html

# Open report
open coverage/html/index.html
```

## Best Practices

### Test Structure
- Use **Arrange-Act-Assert** pattern
- Keep tests focused and independent
- Use descriptive test names
- Group related tests together

### Mocking
- Mock external dependencies (network, storage, etc.)
- Use dependency injection for testability
- Verify mock interactions when relevant

### Test Data
- Use test data factories for consistency
- Test edge cases and error conditions
- Include tests for different locales/languages

### Widget Testing
- Test user interactions (taps, scrolls, etc.)
- Verify UI state changes
- Test accessibility features
- Handle async operations properly

## Common Patterns

### Testing Providers
```dart
test('should update state correctly', () {
  final container = ProviderContainer();
  final notifier = container.read(myProvider.notifier);
  
  notifier.updateValue('new value');
  
  expect(container.read(myProvider).value, equals('new value'));
  container.dispose();
});
```

### Testing Widgets
```dart
testWidgets('should display prayer times', (tester) async {
  await tester.pumpWidget(MyApp());
  
  expect(find.text('Fajr'), findsOneWidget);
  expect(find.text('Dhuhr'), findsOneWidget);
});
```

### Testing Async Operations
```dart
test('should handle async location fetch', () async {
  when(() => mockService.fetchLocation())
      .thenAnswer((_) async => testAddress);
  
  final result = await locationProvider.fetchLocation();
  
  expect(result, equals(testAddress));
});
```

## Adding New Tests

1. **Create test file** following naming convention: `*_test.dart`
2. **Import dependencies** and test helpers
3. **Write test groups** with descriptive names
4. **Add to all_tests.dart** if needed for batch running
5. **Update this README** if adding new test categories

## Troubleshooting

### Common Issues

**Import errors**: Make sure all dependencies are in `pubspec.yaml`
**Mock setup**: Verify mocks are properly configured before use
**Widget tests**: Use `pumpAndSettle()` for async UI operations  
**Coverage**: Ensure all code paths are tested, not just happy paths

### Debugging Tests

```bash
# Run tests in verbose mode
flutter test --verbose

# Run single test with debugging
flutter test test/unit/entities/address_test.dart --verbose

# Print debug information in tests
debugPrint('Test debug info');
```
