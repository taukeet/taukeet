import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taukeet/core/errors/failures.dart';
import 'package:taukeet/core/usecases/usecase.dart';
import 'package:taukeet/features/location/domain/entities/address.dart';
import 'package:taukeet/features/location/domain/usecases/get_current_location.dart';
import 'package:taukeet/features/qiblah/presentation/providers/qiblah_provider.dart';
import 'package:taukeet/features/settings/domain/entities/settings.dart';
import 'package:taukeet/features/settings/domain/usecases/get_settings.dart';
import 'package:taukeet/features/qiblah/domain/usecases/get_qiblah_direction.dart';

// Mock classes
class MockGetCurrentLocation extends Mock implements GetCurrentLocation {}

class MockGetSettings extends Mock implements GetSettings {}

class MockGetQiblahDirection extends Mock implements GetQiblahDirection {}

void main() {
  late MockGetCurrentLocation mockGetCurrentLocation;
  late MockGetSettings mockGetSettings;
  late MockGetQiblahDirection mockGetQiblahDirection;
  late QiblahNotifier notifier;

  // Test data
  const testAddress = Address(
    latitude: 24.8607,
    longitude: 67.0011,
    address: 'Karachi, Pakistan',
  );

  const testQiblahDirection = 255.5;

  setUpAll(() {
    registerFallbackValue(GetQiblahDirectionParams(
      latitude: 0.0,
      longitude: 0.0,
    ));
  });

  setUp(() {
    mockGetCurrentLocation = MockGetCurrentLocation();
    mockGetSettings = MockGetSettings();
    mockGetQiblahDirection = MockGetQiblahDirection();

    notifier = QiblahNotifier(
      mockGetCurrentLocation,
      mockGetSettings,
      mockGetQiblahDirection,
    );
  });

  group('QiblahNotifier Initialization', () {
    test('should initialize with default state', () {
      // Assert
      expect(notifier.state.isFetchingLocation, false);
      expect(notifier.state.hasLocationPermission, true);
      expect(notifier.state.isLocationEnabled, true);
      expect(notifier.state.address, null);
      expect(notifier.state.qiblahDirection, null);
    });

    test('should load settings and calculate Qiblah on init success', () async {
      // Arrange
      final testSettings = Settings(address: testAddress);
      when(() => mockGetSettings(NoParams()))
          .thenAnswer((_) async => Right(testSettings));
      when(() => mockGetQiblahDirection(GetQiblahDirectionParams(
            latitude: testAddress.latitude,
            longitude: testAddress.longitude,
          ))).thenAnswer((_) async => const Right(testQiblahDirection));

      // Act
      await notifier.init();

      // Assert
      expect(notifier.state.address, testAddress);
      expect(notifier.state.qiblahDirection, testQiblahDirection);
      verify(() => mockGetSettings(NoParams())).called(1);
      verify(() => mockGetQiblahDirection(GetQiblahDirectionParams(
            latitude: testAddress.latitude,
            longitude: testAddress.longitude,
          ))).called(1);
    });

    test('should handle settings failure on init', () async {
      // Arrange
      when(() => mockGetSettings(NoParams()))
          .thenAnswer((_) async => Left(CacheFailure()));

      // Act
      await notifier.init();

      // Assert
      expect(notifier.state.address, null);
      expect(notifier.state.qiblahDirection, null);
      verify(() => mockGetSettings(NoParams())).called(1);
      verifyNever(() => mockGetQiblahDirection(any()));
    });

    test('should handle Qiblah calculation failure on init', () async {
      // Arrange
      final testSettings = Settings(address: testAddress);
      when(() => mockGetSettings(NoParams()))
          .thenAnswer((_) async => Right(testSettings));
      when(() => mockGetQiblahDirection(GetQiblahDirectionParams(
            latitude: testAddress.latitude,
            longitude: testAddress.longitude,
          ))).thenAnswer((_) async => Left(LocationFailure()));

      // Act
      await notifier.init();

      // Assert
      expect(notifier.state.address, testAddress);
      expect(notifier.state.qiblahDirection, null);
      verify(() => mockGetSettings(NoParams())).called(1);
      verify(() => mockGetQiblahDirection(GetQiblahDirectionParams(
            latitude: testAddress.latitude,
            longitude: testAddress.longitude,
          ))).called(1);
    });
  });

  group('fetchLocation Success', () {
    test('should update state when location fetch succeeds', () async {
      // Arrange
      const locale = 'en';
      when(() =>
              mockGetCurrentLocation(GetCurrentLocationParams(locale: locale)))
          .thenAnswer((_) async => const Right(testAddress));
      when(() => mockGetQiblahDirection(GetQiblahDirectionParams(
            latitude: testAddress.latitude,
            longitude: testAddress.longitude,
          ))).thenAnswer((_) async => const Right(testQiblahDirection));

      // Act
      final result = await notifier.fetchLocation(locale);

      // Assert
      expect(result, true);
      expect(notifier.state.isFetchingLocation, false);
      expect(notifier.state.hasLocationPermission, true);
      expect(notifier.state.isLocationEnabled, true);
      expect(notifier.state.address, testAddress);
      expect(notifier.state.qiblahDirection, testQiblahDirection);
      verify(() =>
              mockGetCurrentLocation(GetCurrentLocationParams(locale: locale)))
          .called(1);
      verify(() => mockGetQiblahDirection(GetQiblahDirectionParams(
            latitude: testAddress.latitude,
            longitude: testAddress.longitude,
          ))).called(1);
    });

    test('should set isFetchingLocation to true during fetch', () async {
      // Arrange
      const locale = 'en';
      when(() =>
              mockGetCurrentLocation(GetCurrentLocationParams(locale: locale)))
          .thenAnswer((_) async {
        // Allow checking state during async operation
        await Future.delayed(const Duration(milliseconds: 10));
        return const Right(testAddress);
      });
      when(() => mockGetQiblahDirection(any()))
          .thenAnswer((_) async => const Right(testQiblahDirection));

      // Act
      final fetchFuture = notifier.fetchLocation(locale);

      // Assert - should be fetching during operation
      expect(notifier.state.isFetchingLocation, true);

      // Wait for completion
      await fetchFuture;
      expect(notifier.state.isFetchingLocation, false);
    });
  });

  group('fetchLocation Failure - Location Errors', () {
    test('should handle location failure', () async {
      // Arrange
      const locale = 'en';
      when(() =>
              mockGetCurrentLocation(GetCurrentLocationParams(locale: locale)))
          .thenAnswer((_) async => Left(LocationFailure()));

      // Act
      final result = await notifier.fetchLocation(locale);

      // Assert
      expect(result, false);
      expect(notifier.state.isFetchingLocation, false);
      expect(notifier.state.hasLocationPermission,
          true); // unchanged since failure is not specific exception
      expect(notifier.state.isLocationEnabled, true);
      verify(() =>
              mockGetCurrentLocation(GetCurrentLocationParams(locale: locale)))
          .called(1);
      verifyNever(() => mockGetQiblahDirection(any()));
    });
  });

  group('fetchLocation Failure - Network/Other Errors', () {
    test('should handle network failure', () async {
      // Arrange
      const locale = 'en';
      when(() =>
              mockGetCurrentLocation(GetCurrentLocationParams(locale: locale)))
          .thenAnswer((_) async => Left(ServerFailure()));

      // Act
      final result = await notifier.fetchLocation(locale);

      // Assert
      expect(result, false);
      expect(notifier.state.isFetchingLocation, false);
      expect(notifier.state.hasLocationPermission, true);
      expect(notifier.state.isLocationEnabled, true);
      verify(() =>
              mockGetCurrentLocation(GetCurrentLocationParams(locale: locale)))
          .called(1);
      verifyNever(() => mockGetQiblahDirection(any()));
    });

    test('should handle location failure', () async {
      // Arrange
      const locale = 'en';
      when(() =>
              mockGetCurrentLocation(GetCurrentLocationParams(locale: locale)))
          .thenAnswer((_) async => Left(LocationFailure()));

      // Act
      final result = await notifier.fetchLocation(locale);

      // Assert
      expect(result, false);
      expect(notifier.state.isFetchingLocation, false);
      expect(notifier.state.hasLocationPermission, true);
      expect(notifier.state.isLocationEnabled, true);
      verify(() =>
              mockGetCurrentLocation(GetCurrentLocationParams(locale: locale)))
          .called(1);
      verifyNever(() => mockGetQiblahDirection(any()));
    });
  });

  group('fetchLocation - Qiblah Calculation Failure', () {
    test('should handle Qiblah calculation failure after successful location',
        () async {
      // Arrange
      const locale = 'en';
      when(() =>
              mockGetCurrentLocation(GetCurrentLocationParams(locale: locale)))
          .thenAnswer((_) async => const Right(testAddress));
      when(() => mockGetQiblahDirection(GetQiblahDirectionParams(
            latitude: testAddress.latitude,
            longitude: testAddress.longitude,
          ))).thenAnswer((_) async => Left(LocationFailure()));

      // Act
      final result = await notifier.fetchLocation(locale);

      // Assert
      expect(result, true); // Location fetch succeeded
      expect(notifier.state.isFetchingLocation, false);
      expect(notifier.state.hasLocationPermission, true);
      expect(notifier.state.isLocationEnabled, true);
      expect(notifier.state.address, testAddress);
      expect(notifier.state.qiblahDirection, null); // Qiblah failed
      verify(() =>
              mockGetCurrentLocation(GetCurrentLocationParams(locale: locale)))
          .called(1);
      verify(() => mockGetQiblahDirection(GetQiblahDirectionParams(
            latitude: testAddress.latitude,
            longitude: testAddress.longitude,
          ))).called(1);
    });
  });

  group('State Management', () {
    test('should copy state correctly with all parameters', () {
      // Arrange
      final originalState = QiblahState(
        isFetchingLocation: true,
        hasLocationPermission: false,
        isLocationEnabled: false,
        address: testAddress,
        qiblahDirection: testQiblahDirection,
      );

      // Act
      notifier.state = originalState;
      final newState = notifier.state.copyWith(
        isFetchingLocation: false,
        hasLocationPermission: true,
        isLocationEnabled: true,
        address: const Address(
          latitude: 0.0,
          longitude: 0.0,
          address: '',
        ),
        qiblahDirection: 0.0, // Use 0.0 instead of null
      );

      // Assert
      expect(newState.isFetchingLocation, false);
      expect(newState.hasLocationPermission, true);
      expect(newState.isLocationEnabled, true);
      expect(newState.address?.latitude, 0.0);
      expect(newState.address?.longitude, 0.0);
      expect(newState.qiblahDirection, 0.0);
    });

    test('should copy state correctly with partial parameters', () {
      // Arrange
      final originalState = QiblahState(
        isFetchingLocation: true,
        hasLocationPermission: false,
        isLocationEnabled: false,
        address: testAddress,
        qiblahDirection: testQiblahDirection,
      );

      // Act
      notifier.state = originalState;
      final newState = notifier.state.copyWith(
        qiblahDirection: 100.0,
      );

      // Assert
      expect(newState.isFetchingLocation, true); // unchanged
      expect(newState.hasLocationPermission, false); // unchanged
      expect(newState.isLocationEnabled, false); // unchanged
      expect(newState.address, testAddress); // unchanged
      expect(newState.qiblahDirection, 100.0); // changed
    });

    test('should maintain state immutability', () {
      // Arrange
      final originalState = QiblahState(
        isFetchingLocation: true,
        hasLocationPermission: false,
        isLocationEnabled: false,
        address: testAddress,
        qiblahDirection: testQiblahDirection,
      );

      // Act
      notifier.state = originalState;
      final newState = notifier.state.copyWith(
        isFetchingLocation: false,
      );

      // Assert
      expect(originalState.isFetchingLocation, true); // original unchanged
      expect(newState.isFetchingLocation, false); // new state changed
      expect(identical(originalState, newState), false); // different instances
    });
  });

  group('Edge Cases', () {
    test('should handle default address in settings', () async {
      // Arrange
      final defaultSettings = Settings();
      when(() => mockGetSettings(NoParams()))
          .thenAnswer((_) async => Right(defaultSettings));
      when(() => mockGetQiblahDirection(GetQiblahDirectionParams(
            latitude: defaultSettings.address.latitude,
            longitude: defaultSettings.address.longitude,
          ))).thenAnswer((_) async => const Right(testQiblahDirection));

      // Act
      await notifier.init();

      // Assert
      expect(notifier.state.address, isNotNull);
      expect(notifier.state.qiblahDirection, isNotNull);
      verify(() => mockGetSettings(NoParams())).called(1);
      verify(() => mockGetQiblahDirection(GetQiblahDirectionParams(
            latitude: defaultSettings.address.latitude,
            longitude: defaultSettings.address.longitude,
          ))).called(1);
    });

    test('should handle empty locale string', () async {
      // Arrange
      const locale = '';
      when(() =>
              mockGetCurrentLocation(GetCurrentLocationParams(locale: locale)))
          .thenAnswer((_) async => const Right(testAddress));
      when(() => mockGetQiblahDirection(any()))
          .thenAnswer((_) async => const Right(testQiblahDirection));

      // Act
      final result = await notifier.fetchLocation(locale);

      // Assert
      expect(result, true);
      verify(() =>
              mockGetCurrentLocation(GetCurrentLocationParams(locale: locale)))
          .called(1);
    });
  });
}
