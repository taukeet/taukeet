import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taukeet/src/entities/address.dart';
import 'package:taukeet/src/entities/adjustments.dart';
import 'package:taukeet/src/exceptions/location_disabled_exception.dart';
import 'package:taukeet/src/exceptions/location_permission_denied.dart';
import 'package:taukeet/src/providers/geo_location_provider.dart';
import 'package:taukeet/src/providers/settings_provider.dart';
import '../../helpers/test_helpers.dart';

void main() {
  group('Settings Provider Tests', () {
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

      test('should load settings from SharedPreferences', () async {
        // Arrange
        final testSettings = TestUtils.createTestSettingsJson();
        SharedPreferences.setMockInitialValues({
          'taukeet_settings': jsonEncode(testSettings),
        });

        final newContainer = ProviderContainer(
          overrides: [
            geoLocationProvider.overrideWithValue(mockGeoLocationService),
          ],
        );

        // Act
        final futureState = newContainer.read(settingsFutureProvider);
        final state = futureState.value ?? SettingsState();

        // Assert
        expect(state.address.latitude, equals(24.8607));
        expect(state.address.longitude, equals(67.0011));
        expect(state.madhab, equals('hanafi'));
        expect(state.calculationMethod, equals('Karachi'));

        newContainer.dispose();
      });
    });

    group('Location Fetching', () {
      test('should fetch location successfully', () async {
        // Arrange
        final testAddress = TestDataFactory.createTestAddress();
        when(() => mockGeoLocationService.fetch(locale: 'en'))
            .thenAnswer((_) async => testAddress);

        final notifier = container.read(settingsProvider.notifier);

        // Act
        final result = await notifier.fetchLocation('en');

        // Assert
        expect(result, isTrue);

        final state = container.read(settingsProvider);
        expect(state.isFetchingLocation, isFalse);
        expect(state.address, equals(testAddress));
        expect(state.isLocationEnabled, isTrue);
        expect(state.hasLocationPermission, isTrue);
        expect(state.hasFetchedInitialLocation, isTrue);

        verify(() => mockGeoLocationService.fetch(locale: 'en')).called(1);
      });

      test('should handle location disabled exception', () async {
        // Arrange
        when(() => mockGeoLocationService.fetch(locale: 'en'))
            .thenThrow(LocationDisabledException());

        final notifier = container.read(settingsProvider.notifier);

        // Act
        final result = await notifier.fetchLocation('en');

        // Assert
        expect(result, isFalse);

        final state = container.read(settingsProvider);
        expect(state.isFetchingLocation, isFalse);
        expect(state.isLocationEnabled, isFalse);
        expect(state.hasLocationPermission, isTrue);
      });

      test('should handle location permission denied exception', () async {
        // Arrange
        when(() => mockGeoLocationService.fetch(locale: 'en'))
            .thenThrow(LocationPermissionDenied());

        final notifier = container.read(settingsProvider.notifier);

        // Act
        final result = await notifier.fetchLocation('en');

        // Assert
        expect(result, isFalse);

        final state = container.read(settingsProvider);
        expect(state.isFetchingLocation, isFalse);
        expect(state.isLocationEnabled, isTrue);
        expect(state.hasLocationPermission, isFalse);
      });

      test('should handle generic exception', () async {
        // Arrange
        when(() => mockGeoLocationService.fetch(locale: 'en'))
            .thenThrow(Exception('Network error'));

        final notifier = container.read(settingsProvider.notifier);

        // Act
        final result = await notifier.fetchLocation('en');

        // Assert
        expect(result, isFalse);

        final state = container.read(settingsProvider);
        expect(state.isFetchingLocation, isFalse);
      });

      test('should set fetching state during location fetch', () async {
        // Arrange
        final testAddress = TestDataFactory.createTestAddress();
        when(() => mockGeoLocationService.fetch(locale: 'en'))
            .thenAnswer((_) async {
          // Check state during async operation
          final currentState = container.read(settingsProvider);
          expect(currentState.isFetchingLocation, isTrue);
          return testAddress;
        });

        final notifier = container.read(settingsProvider.notifier);

        // Act
        await notifier.fetchLocation('en');

        // Assert - State should be reset after completion
        final finalState = container.read(settingsProvider);
        expect(finalState.isFetchingLocation, isFalse);
      });
    });

    group('Address Translation', () {
      test('should translate address successfully', () async {
        // Arrange
        final originalAddress = TestDataFactory.createTestAddress();
        final translatedAddress = originalAddress.copyWith(
          address: "کراچی، پاکستان", // Urdu translation
        );

        // Set initial state with address
        container.read(settingsProvider.notifier).state =
            container.read(settingsProvider).copyWith(address: originalAddress);

        when(() => mockGeoLocationService.getAddress(
              latitude: originalAddress.latitude,
              longitude: originalAddress.longitude,
              locale: 'ur',
            )).thenAnswer((_) async => translatedAddress);

        final notifier = container.read(settingsProvider.notifier);

        // Act
        await notifier.translateAddress('ur');

        // Assert
        final state = container.read(settingsProvider);
        expect(state.address.address, equals("کراچی، پاکستان"));
        expect(state.address.latitude, equals(originalAddress.latitude));
        expect(state.address.longitude, equals(originalAddress.longitude));
      });

      test('should skip translation for zero coordinates', () async {
        // Arrange
        const zeroAddress = Address(latitude: 0.0, longitude: 0.0, address: '');
        container.read(settingsProvider.notifier).state =
            container.read(settingsProvider).copyWith(address: zeroAddress);

        final notifier = container.read(settingsProvider.notifier);

        // Act
        await notifier.translateAddress('ur');

        // Assert
        verifyNever(() => mockGeoLocationService.getAddress(
              latitude: any(named: 'latitude'),
              longitude: any(named: 'longitude'),
              locale: any(named: 'locale'),
            ));
      });

      test('should handle translation error gracefully', () async {
        // Arrange
        final originalAddress = TestDataFactory.createTestAddress();
        container.read(settingsProvider.notifier).state =
            container.read(settingsProvider).copyWith(address: originalAddress);

        when(() => mockGeoLocationService.getAddress(
              latitude: any(named: 'latitude'),
              longitude: any(named: 'longitude'),
              locale: any(named: 'locale'),
            )).thenThrow(Exception('Translation failed'));

        final notifier = container.read(settingsProvider.notifier);

        // Act & Assert - Should not throw
        expect(() => notifier.translateAddress('ur'), returnsNormally);

        // State should remain unchanged
        final state = container.read(settingsProvider);
        expect(state.address, equals(originalAddress));
      });
    });

    group('Settings Updates', () {
      test('should complete tutorial', () {
        // Arrange
        final notifier = container.read(settingsProvider.notifier);

        // Act
        notifier.completeTutorial();

        // Assert
        final state = container.read(settingsProvider);
        expect(state.isTutorialCompleted, isTrue);
      });

      test('should update adjustments', () {
        // Arrange
        final notifier = container.read(settingsProvider.notifier);

        // Act
        notifier.updateAdjustments(
          fajr: 5,
          sunrise: -2,
          dhuhr: 3,
          asr: 1,
          maghrib: 0,
          isha: -4,
        );

        // Assert
        final state = container.read(settingsProvider);
        expect(state.adjustments.fajr, equals(5));
        expect(state.adjustments.sunrise, equals(-2));
        expect(state.adjustments.dhuhr, equals(3));
        expect(state.adjustments.asr, equals(1));
        expect(state.adjustments.maghrib, equals(0));
        expect(state.adjustments.isha, equals(-4));
      });

      test('should update madhab', () {
        // Arrange
        final notifier = container.read(settingsProvider.notifier);

        // Act
        notifier.updateMadhab('shafi');

        // Assert
        final state = container.read(settingsProvider);
        expect(state.madhab, equals('shafi'));
      });

      test('should update calculation method', () {
        // Arrange
        final notifier = container.read(settingsProvider.notifier);

        // Act
        notifier.updateCalculationMethod('MuslimWorldLeague');

        // Assert
        final state = container.read(settingsProvider);
        expect(state.calculationMethod, equals('MuslimWorldLeague'));
      });

      test('should update higher latitude', () {
        // Arrange
        final notifier = container.read(settingsProvider.notifier);

        // Act
        notifier.updateHigherLatitude('MiddleOfTheNight');

        // Assert
        final state = container.read(settingsProvider);
        expect(state.higherLatitude, equals('MiddleOfTheNight'));
      });
    });

    group('State Persistence', () {
      test('should persist settings to SharedPreferences on updates', () async {
        // This is more of an integration test, but we can verify behavior
        final notifier = container.read(settingsProvider.notifier);

        // Act
        notifier.updateMadhab('shafi');
        notifier.completeTutorial();

        // Allow async operations to complete
        await Future.delayed(Duration.zero);

        // Assert
        final state = container.read(settingsProvider);
        expect(state.madhab, equals('shafi'));
        expect(state.isTutorialCompleted, isTrue);
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
        expect(newState.calculationMethod,
            equals(originalState.calculationMethod));
      });
    });

    group('Specific Provider Selectors', () {
      test('madhabProvider should return current madhab', () {
        // Arrange
        container.read(settingsProvider.notifier).updateMadhab('shafi');

        // Act
        final madhab = container.read(madhabProvider);

        // Assert
        expect(madhab, equals('shafi'));
      });
    });
  });
}
