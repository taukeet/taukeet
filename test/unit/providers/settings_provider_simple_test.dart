import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taukeet/src/providers/geo_location_provider.dart';
import 'package:taukeet/src/providers/settings_provider.dart';
import '../../helpers/test_helpers.dart';

void main() {
  group('Settings Provider Simple Tests', () {
    late MockGeoLocationService mockGeoLocationService;
    late ProviderContainer container;

    setUp(() {
      mockGeoLocationService = MockGeoLocationService();
      TestUtils.setupSharedPreferencesMocks();
      
      container = ProviderContainer(
        overrides: [
          geoLocationProvider.overrideWithValue(mockGeoLocationService),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    group('Initial State', () {
      test('should have default initial state', () {
        // Act
        final state = container.read(settingsProvider);

        // Assert
        expect(state.isFetchingLocation, isFalse);
        expect(state.isLocationEnabled, isTrue);
        expect(state.hasFetchedInitialLocation, isFalse);
        expect(state.hasLocationPermission, isTrue);
        expect(state.isTutorialCompleted, isFalse);
        expect(state.address.latitude, equals(0.0));
        expect(state.address.longitude, equals(0.0));
        expect(state.address.address, isEmpty);
        expect(state.madhab, equals('hanafi'));
        expect(state.calculationMethod, equals('Karachi'));
        expect(state.higherLatitude, equals('None'));
      });
    });

    group('SettingsState', () {
      test('should create SettingsState from Map', () {
        // Arrange
        final map = TestUtils.createTestSettingsJson();

        // Act
        final state = SettingsState.fromMap(map);

        // Assert
        expect(state.address.latitude, equals(24.8607));
        expect(state.madhab, equals('hanafi'));
        expect(state.calculationMethod, equals('Karachi'));
        expect(state.hasFetchedInitialLocation, isTrue);
        expect(state.isTutorialCompleted, isTrue);
      });

      test('should convert SettingsState to Map', () {
        // Arrange
        final state = SettingsState(
          address: TestDataFactory.createTestAddress(),
          adjustments: TestDataFactory.createTestAdjustments(),
          madhab: 'shafi',
          calculationMethod: 'Egyptian',
          higherLatitude: 'TwilightAngle',
          hasFetchedInitialLocation: true,
          isTutorialCompleted: true,
        );

        // Act
        final map = state.toMap();

        // Assert
        expect(map['madhab'], equals('shafi'));
        expect(map['calculation_method'], equals('Egyptian'));
        expect(map['higher_latitude'], equals('TwilightAngle'));
        expect(map['has_fetched_initial_location'], isTrue);
        expect(map['is_tutorial_completed'], isTrue);
      });

      test('should handle copyWith correctly', () {
        // Arrange
        final originalState = SettingsState();

        // Act
        final newState = originalState.copyWith(
          madhab: 'shafi',
          isTutorialCompleted: true,
        );

        // Assert
        expect(newState.madhab, equals('shafi'));
        expect(newState.isTutorialCompleted, isTrue);
        expect(newState.calculationMethod, equals(originalState.calculationMethod));
      });
    });

    group('State Mutations without SharedPreferences', () {
      test('should update state directly', () {
        // Arrange
        final notifier = container.read(settingsProvider.notifier);
        final originalState = container.read(settingsProvider);

        // Act - Update state directly without persistence
        notifier.state = originalState.copyWith(
          madhab: 'shafi',
          calculationMethod: 'Egyptian',
        );

        // Assert
        final newState = container.read(settingsProvider);
        expect(newState.madhab, equals('shafi'));
        expect(newState.calculationMethod, equals('Egyptian'));
        expect(newState.isTutorialCompleted, isFalse); // unchanged
      });

      test('should handle tutorial completion state change', () {
        // Arrange
        final notifier = container.read(settingsProvider.notifier);
        final originalState = container.read(settingsProvider);

        // Act
        notifier.state = originalState.copyWith(isTutorialCompleted: true);

        // Assert
        final newState = container.read(settingsProvider);
        expect(newState.isTutorialCompleted, isTrue);
        expect(newState.madhab, equals(originalState.madhab)); // unchanged
      });

      test('should handle location fetching state change', () {
        // Arrange
        final notifier = container.read(settingsProvider.notifier);
        final originalState = container.read(settingsProvider);
        final newAddress = TestDataFactory.createTestAddress();

        // Act
        notifier.state = originalState.copyWith(
          isFetchingLocation: false,
          address: newAddress,
          hasFetchedInitialLocation: true,
        );

        // Assert
        final newState = container.read(settingsProvider);
        expect(newState.isFetchingLocation, isFalse);
        expect(newState.address, equals(newAddress));
        expect(newState.hasFetchedInitialLocation, isTrue);
      });
    });

    group('Specific Provider Selectors', () {
      test('madhabProvider should return current madhab', () {
        // Arrange
        final notifier = container.read(settingsProvider.notifier);
        final originalState = container.read(settingsProvider);
        
        // Act
        notifier.state = originalState.copyWith(madhab: 'shafi');
        final madhab = container.read(madhabProvider);

        // Assert
        expect(madhab, equals('shafi'));
      });
    });
  });
}
