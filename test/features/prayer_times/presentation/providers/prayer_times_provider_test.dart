import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import 'package:taukeet/features/location/domain/entities/address.dart';
import 'package:taukeet/features/prayer_times/domain/entities/adjustments.dart';
import 'package:taukeet/features/prayer_times/domain/entities/prayer_name.dart';
import 'package:taukeet/features/prayer_times/domain/entities/prayer_time.dart';
import 'package:taukeet/features/prayer_times/domain/usecases/get_calculation_methods.dart';
import 'package:taukeet/features/prayer_times/domain/usecases/get_current_prayer.dart';
import 'package:taukeet/features/prayer_times/domain/usecases/get_higher_latitudes.dart';
import 'package:taukeet/features/prayer_times/domain/usecases/get_prayer_times.dart';
import 'package:taukeet/features/prayer_times/presentation/providers/prayer_times_provider.dart';
import 'package:taukeet/features/settings/presentation/providers/settings_provider.dart';
import 'package:taukeet/features/settings/domain/entities/settings.dart';
import 'package:taukeet/core/usecases/usecase.dart';
import 'package:taukeet/core/errors/failures.dart';

// Mock classes
class MockGetPrayerTimes extends Mock implements GetPrayerTimes {}
class MockGetCurrentPrayer extends Mock implements GetCurrentPrayer {}
class MockGetCalculationMethods extends Mock implements GetCalculationMethods {}
class MockGetHigherLatitudes extends Mock implements GetHigherLatitudes {}

// Mock Ref for SettingsNotifier
class MockRef extends Mock implements Ref {}

void main() {
  setUpAll(() {
    registerFallbackValue(GetPrayerTimesParams(
      date: DateTime.now(),
      location: const Address(latitude: 28.7041, longitude: 77.1025, address: "Delhi, India"),
      adjustments: const Adjustments(fajr: 0, sunrise: 0, dhuhr: 0, asr: 0, maghrib: 0, isha: 0),
      calculationMethod: 'Delhi',
      madhab: 'hanafi',
      higherLatitude: 'None',
    ));
    registerFallbackValue(GetCurrentPrayerParams(
      location: const Address(latitude: 28.7041, longitude: 77.1025, address: "Delhi, India"),
      adjustments: const Adjustments(fajr: 0, sunrise: 0, dhuhr: 0, asr: 0, maghrib: 0, isha: 0),
      calculationMethod: 'Delhi',
      madhab: 'hanafi',
      higherLatitude: 'None',
    ));
    registerFallbackValue(NoParams());
  });

  group('PrayerTimesProvider', () {
    late ProviderContainer container;
    late MockGetPrayerTimes mockGetPrayerTimes;
    late MockGetCurrentPrayer mockGetCurrentPrayer;
    late MockGetCalculationMethods mockGetCalculationMethods;
    late MockGetHigherLatitudes mockGetHigherLatitudes;

    setUp(() {
      mockGetPrayerTimes = MockGetPrayerTimes();
      mockGetCurrentPrayer = MockGetCurrentPrayer();
      mockGetCalculationMethods = MockGetCalculationMethods();
      mockGetHigherLatitudes = MockGetHigherLatitudes();

      container = ProviderContainer(
        overrides: [
          getPrayerTimesUseCaseProvider.overrideWithValue(mockGetPrayerTimes),
          getCurrentPrayerUseCaseProvider.overrideWithValue(mockGetCurrentPrayer),
          getCalculationMethodsUseCaseProvider.overrideWithValue(mockGetCalculationMethods),
          getHigherLatitudesUseCaseProvider.overrideWithValue(mockGetHigherLatitudes),
          settingsProvider.overrideWith((ref) {
    final mockRef = MockRef();
    final defaultSettings = const Settings(
      address: Address(latitude: 28.7041, longitude: 77.1025, address: "Delhi, India"),
      adjustments: Adjustments(fajr: 0, sunrise: 0, dhuhr: 0, asr: 0, maghrib: 0, isha: 0),
      madhab: "hanafi",
      calculationMethod: "Delhi",
      higherLatitude: "None",
      hasFetchedInitialLocation: true,
      isTutorialCompleted: true,
    );
    return SettingsNotifier(mockRef, defaultSettings);
  }),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    group('prayerTimesProvider', () {
      test('should return prayer times when use case succeeds', () async {
        // Arrange
        final testPrayers = [
          PrayerTime(
            name: PrayerName(english: "Fajr", arabic: "فجر"),
            startTime: DateTime(2023, 12, 1, 5, 30),
            isCurrentPrayer: false,
          ),
        ];

        when(() => mockGetPrayerTimes(any()))
            .thenAnswer((_) async => Right(testPrayers));

        // Act
        final result = await container.read(prayerTimesProvider(DateTime(2023, 12, 1)).future);

        // Assert
        expect(result, equals(testPrayers));
        verify(() => mockGetPrayerTimes(any())).called(1);
      });

test('should return empty list when use case fails', () async {
        // Arrange
        when(() => mockGetPrayerTimes(any()))
            .thenAnswer((_) async => Left(ServerFailure()));

        // Act
        final result = await container.read(prayerTimesProvider(DateTime(2023, 12, 1)).future);

        // Assert
        expect(result, isEmpty);
        verify(() => mockGetPrayerTimes(any())).called(1);
      });
    });

    group('currentPrayerProvider', () {
      test('should return current prayer when use case succeeds', () async {
        // Arrange
        final testPrayer = PrayerTime(
          name: PrayerName(english: "Dhuhr", arabic: "ظهر"),
          startTime: DateTime(2023, 12, 1, 12, 15),
          isCurrentPrayer: false,
        );

        when(() => mockGetCurrentPrayer(any()))
            .thenAnswer((_) async => Right(testPrayer));

        // Act
        final result = await container.read(currentPrayerProvider(DateTime(2023, 12, 1)).future);

        // Assert
        expect(result, equals(testPrayer));
        verify(() => mockGetCurrentPrayer(any())).called(1);
      });

      test('should return null when use case fails', () async {
        // Arrange
        when(() => mockGetCurrentPrayer(any()))
            .thenAnswer((_) async => Left(ServerFailure()));

        // Act
        final result = await container.read(currentPrayerProvider(DateTime(2023, 12, 1)).future);

        // Assert
        expect(result, isNull);
        verify(() => mockGetCurrentPrayer(any())).called(1);
      });
    });

    group('calculationMethodsProvider', () {
      test('should return calculation methods when use case succeeds', () async {
        // Arrange
        final testMethods = ['Delhi', 'UmmAlQura', 'MuslimWorldLeague'];

        when(() => mockGetCalculationMethods(any()))
            .thenAnswer((_) async => Right(testMethods));

        // Act
        final result = await container.read(calculationMethodsProvider.future);

        // Assert
        expect(result, equals(testMethods));
        verify(() => mockGetCalculationMethods(any())).called(1);
      });

      test('should return empty list when use case fails', () async {
        // Arrange
        when(() => mockGetCalculationMethods(any()))
            .thenAnswer((_) async => Left(ServerFailure()));

        // Act
        final result = await container.read(calculationMethodsProvider.future);

        // Assert
        expect(result, isEmpty);
        verify(() => mockGetCalculationMethods(any())).called(1);
      });
    });

    group('higherLatitudesProvider', () {
      test('should return higher latitudes when use case succeeds', () async {
        // Arrange
        final testLatitudes = ['MiddleOfTheNight', 'SeventhOfTheNight', 'TwilightAngle'];

        when(() => mockGetHigherLatitudes(any()))
            .thenAnswer((_) async => Right(testLatitudes));

        // Act
        final result = await container.read(higherLatitudesProvider.future);

        // Assert
        expect(result, equals(testLatitudes));
        verify(() => mockGetHigherLatitudes(any())).called(1);
      });

      test('should return empty list when use case fails', () async {
        // Arrange
        when(() => mockGetHigherLatitudes(any()))
            .thenAnswer((_) async => Left(ServerFailure()));

        // Act
        final result = await container.read(higherLatitudesProvider.future);

        // Assert
        expect(result, isEmpty);
        verify(() => mockGetHigherLatitudes(any())).called(1);
      });
    });

    group('error handling', () {
test('should handle use case exceptions gracefully', () async {
        // Arrange
        when(() => mockGetPrayerTimes(any()))
            .thenThrow(Exception('Use case error'));

        // Act & Assert
        expect(
          () async => await container.read(prayerTimesProvider(DateTime(2023, 12, 1)).future),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
}