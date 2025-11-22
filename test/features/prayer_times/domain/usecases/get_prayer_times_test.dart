import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taukeet/core/errors/failures.dart';
import 'package:taukeet/features/location/domain/entities/address.dart';
import 'package:taukeet/features/prayer_times/domain/entities/adjustments.dart';
import 'package:taukeet/features/prayer_times/domain/entities/prayer_name.dart';
import 'package:taukeet/features/prayer_times/domain/entities/prayer_time.dart';
import 'package:taukeet/features/prayer_times/domain/repositories/prayer_repository.dart';
import 'package:taukeet/features/prayer_times/domain/usecases/get_prayer_times.dart';

class MockPrayerRepository extends Mock implements PrayerRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(Address(
      latitude: 0.0,
      longitude: 0.0,
      address: 'Test',
    ));
    registerFallbackValue(const Adjustments(
      fajr: 0,
      sunrise: 0,
      dhuhr: 0,
      asr: 0,
      maghrib: 0,
      isha: 0,
    ));
  });

  group('GetPrayerTimes', () {
    late MockPrayerRepository mockRepository;
    late GetPrayerTimes useCase;

    setUp(() {
      mockRepository = MockPrayerRepository();
      useCase = GetPrayerTimes(mockRepository);
    });

    group('success cases', () {
      test('should return list of prayer times when repository call succeeds',
          () async {
        // Arrange
        final testAddress = Address(
          latitude: 28.7041,
          longitude: 77.1025,
          address: 'Delhi, India',
        );
        final testAdjustments = const Adjustments(
          fajr: 0,
          sunrise: 0,
          dhuhr: 0,
          asr: 0,
          maghrib: 0,
          isha: 0,
        );
        final expectedPrayerTimes = [
          PrayerTime(
            name: PrayerName(english: "Fajr", arabic: "فجر"),
            startTime: DateTime(2023, 12, 1, 5, 30),
            isCurrentPrayer: false,
          ),
          PrayerTime(
            name: PrayerName(english: "Dhuhr", arabic: "ظهر"),
            startTime: DateTime(2023, 12, 1, 12, 15),
            isCurrentPrayer: false,
          ),
        ];

        when(() => mockRepository.prayers(any()))
            .thenReturn(expectedPrayerTimes);

        // Act
        final params = GetPrayerTimesParams(
          date: DateTime(2023, 12, 1),
          location: testAddress,
          adjustments: testAdjustments,
          calculationMethod: 'Delhi',
          madhab: 'hanafi',
          higherLatitude: 'None',
        );

        final result = await useCase(params);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (l) => fail('Expected Right but got Left: $l'),
          (r) => expect(r, equals(expectedPrayerTimes)),
        );
        verify(() => mockRepository.init(
              testAddress,
              testAdjustments,
              'Delhi',
              'hanafi',
              'None',
            )).called(1);
        verify(() => mockRepository.prayers(DateTime(2023, 12, 1))).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test('should initialize repository with correct parameters', () async {
        // Arrange
        final testAddress = Address(
          latitude: 28.7041,
          longitude: 77.1025,
          address: 'Delhi, India',
        );
        final testAdjustments = const Adjustments(
          fajr: 0,
          sunrise: 0,
          dhuhr: 0,
          asr: 0,
          maghrib: 0,
          isha: 0,
        );
        final expectedPrayerTimes = [
          PrayerTime(
            name: PrayerName(english: "Fajr", arabic: "فجر"),
            startTime: DateTime(2023, 12, 1, 5, 30),
            isCurrentPrayer: false,
          ),
        ];

        when(() => mockRepository.prayers(any()))
            .thenReturn(expectedPrayerTimes);

        // Act
        final params = GetPrayerTimesParams(
          date: DateTime(2023, 12, 1),
          location: testAddress,
          adjustments: testAdjustments,
          calculationMethod: 'UmmAlQura',
          madhab: 'shafi',
          higherLatitude: 'TwilightAngle',
        );

        await useCase(params);

        // Assert
        verify(() => mockRepository.init(
              testAddress,
              testAdjustments,
              'UmmAlQura',
              'shafi',
              'TwilightAngle',
            )).called(1);
        verify(() => mockRepository.prayers(DateTime(2023, 12, 1))).called(1);
      });

      test('should handle different calculation methods', () async {
        // Arrange
        final testAddress = Address(
          latitude: 28.7041,
          longitude: 77.1025,
          address: 'Delhi, India',
        );
        final testAdjustments = const Adjustments(
          fajr: 0,
          sunrise: 0,
          dhuhr: 0,
          asr: 0,
          maghrib: 0,
          isha: 0,
        );
        final expectedPrayerTimes = [
          PrayerTime(
            name: PrayerName(english: "Fajr", arabic: "فجر"),
            startTime: DateTime(2023, 12, 1, 5, 30),
            isCurrentPrayer: false,
          ),
        ];

        when(() => mockRepository.prayers(any()))
            .thenReturn(expectedPrayerTimes);

        // Act
        final params = GetPrayerTimesParams(
          date: DateTime(2023, 12, 1),
          location: testAddress,
          adjustments: testAdjustments,
          calculationMethod: 'MuslimWorldLeague',
          madhab: 'hanafi',
          higherLatitude: 'None',
        );

        final result = await useCase(params);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (l) => fail('Expected Right but got Left: $l'),
          (r) => expect(r, equals(expectedPrayerTimes)),
        );
        verify(() => mockRepository.init(
              testAddress,
              testAdjustments,
              'MuslimWorldLeague',
              'hanafi',
              'None',
            )).called(1);
      });

      test('should handle empty prayer times list', () async {
        // Arrange
        final testAddress = Address(
          latitude: 28.7041,
          longitude: 77.1025,
          address: 'Delhi, India',
        );
        final testAdjustments = const Adjustments(
          fajr: 0,
          sunrise: 0,
          dhuhr: 0,
          asr: 0,
          maghrib: 0,
          isha: 0,
        );

        when(() => mockRepository.prayers(any())).thenReturn(<PrayerTime>[]);

        // Act
        final params = GetPrayerTimesParams(
          date: DateTime(2023, 12, 1),
          location: testAddress,
          adjustments: testAdjustments,
          calculationMethod: 'Delhi',
          madhab: 'hanafi',
          higherLatitude: 'None',
        );

        final result = await useCase(params);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (l) => fail('Expected Right but got Left: $l'),
          (r) => expect(r, isEmpty),
        );
      });
    });

    group('failure cases', () {
      test('should return ServerFailure when repository throws exception',
          () async {
        // Arrange
        final testAddress = Address(
          latitude: 28.7041,
          longitude: 77.1025,
          address: 'Delhi, India',
        );
        final testAdjustments = const Adjustments(
          fajr: 0,
          sunrise: 0,
          dhuhr: 0,
          asr: 0,
          maghrib: 0,
          isha: 0,
        );

        when(() => mockRepository.init(any(), any(), any(), any(), any()))
            .thenReturn(null);
        when(() => mockRepository.prayers(any()))
            .thenThrow(Exception('Repository error'));

        // Act
        final params = GetPrayerTimesParams(
          date: DateTime(2023, 12, 1),
          location: testAddress,
          adjustments: testAdjustments,
          calculationMethod: 'Delhi',
          madhab: 'hanafi',
          higherLatitude: 'None',
        );

        final result = await useCase(params);

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (l) => expect(l, isA<ServerFailure>()),
          (r) => fail('Expected Left but got Right: $r'),
        );
        verify(() => mockRepository.init(
              testAddress,
              testAdjustments,
              'Delhi',
              'hanafi',
              'None',
            )).called(1);
        verify(() => mockRepository.prayers(DateTime(2023, 12, 1))).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test(
          'should return ServerFailure when repository throws generic Exception',
          () async {
        // Arrange
        final testAddress = Address(
          latitude: 28.7041,
          longitude: 77.1025,
          address: 'Delhi, India',
        );
        final testAdjustments = const Adjustments(
          fajr: 0,
          sunrise: 0,
          dhuhr: 0,
          asr: 0,
          maghrib: 0,
          isha: 0,
        );

        when(() => mockRepository.init(any(), any(), any(), any(), any()))
            .thenReturn(null);
        when(() => mockRepository.prayers(any()))
            .thenThrow(Exception('Unknown error'));

        // Act
        final params = GetPrayerTimesParams(
          date: DateTime(2023, 12, 1),
          location: testAddress,
          adjustments: testAdjustments,
          calculationMethod: 'Delhi',
          madhab: 'hanafi',
          higherLatitude: 'None',
        );

        final result = await useCase(params);

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (l) => expect(l, isA<ServerFailure>()),
          (r) => fail('Expected Left but got Right: $r'),
        );
      });
    });

    group('parameter validation', () {
      test('should handle Delhi coordinates correctly', () async {
        // Arrange
        final delhiAddress = Address(
          latitude: 28.7041,
          longitude: 77.1025,
          address: 'Delhi, India',
        );
        final testAdjustments = const Adjustments(
          fajr: 0,
          sunrise: 0,
          dhuhr: 0,
          asr: 0,
          maghrib: 0,
          isha: 0,
        );
        final expectedPrayerTimes = [
          PrayerTime(
            name: PrayerName(english: "Fajr", arabic: "فجر"),
            startTime: DateTime(2023, 12, 1, 5, 30),
            isCurrentPrayer: false,
          ),
        ];

        when(() => mockRepository.prayers(any()))
            .thenReturn(expectedPrayerTimes);

        // Act
        final params = GetPrayerTimesParams(
          date: DateTime(2023, 12, 1),
          location: delhiAddress,
          adjustments: testAdjustments,
          calculationMethod: 'Delhi',
          madhab: 'hanafi',
          higherLatitude: 'None',
        );

        final result = await useCase(params);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (l) => fail('Expected Right but got Left: $l'),
          (r) => expect(r, equals(expectedPrayerTimes)),
        );
        verify(() => mockRepository.init(
              delhiAddress,
              testAdjustments,
              'Delhi',
              'hanafi',
              'None',
            )).called(1);
      });

      test('should handle zero adjustments', () async {
        // Arrange
        final testAddress = Address(
          latitude: 28.7041,
          longitude: 77.1025,
          address: 'Delhi, India',
        );
        final zeroAdjustments = const Adjustments(
          fajr: 0,
          sunrise: 0,
          dhuhr: 0,
          asr: 0,
          maghrib: 0,
          isha: 0,
        );
        final expectedPrayerTimes = [
          PrayerTime(
            name: PrayerName(english: "Fajr", arabic: "فجر"),
            startTime: DateTime(2023, 12, 1, 5, 30),
            isCurrentPrayer: false,
          ),
        ];

        when(() => mockRepository.prayers(any()))
            .thenReturn(expectedPrayerTimes);

        // Act
        final params = GetPrayerTimesParams(
          date: DateTime(2023, 12, 1),
          location: testAddress,
          adjustments: zeroAdjustments,
          calculationMethod: 'Delhi',
          madhab: 'hanafi',
          higherLatitude: 'None',
        );

        final result = await useCase(params);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (l) => fail('Expected Right but got Left: $l'),
          (r) => expect(r, equals(expectedPrayerTimes)),
        );
        verify(() => mockRepository.init(
              testAddress,
              zeroAdjustments,
              'Delhi',
              'hanafi',
              'None',
            )).called(1);
      });
    });

    group('integration tests', () {
      test('should work with complete prayer configuration', () async {
        // Arrange
        final testAddress = Address(
          latitude: 28.7041,
          longitude: 77.1025,
          address: 'Delhi, India',
        );
        final testAdjustments = const Adjustments(
          fajr: 0,
          sunrise: 0,
          dhuhr: 0,
          asr: 0,
          maghrib: 0,
          isha: 0,
        );
        final expectedPrayerTimes = [
          PrayerTime(
            name: PrayerName(english: "Fajr", arabic: "فجر"),
            startTime: DateTime(2023, 12, 1, 5, 30),
            isCurrentPrayer: false,
          ),
          PrayerTime(
            name: PrayerName(english: "Dhuhr", arabic: "ظهر"),
            startTime: DateTime(2023, 12, 1, 12, 15),
            isCurrentPrayer: false,
          ),
        ];

        when(() => mockRepository.prayers(any()))
            .thenReturn(expectedPrayerTimes);

        // Act
        final params = GetPrayerTimesParams(
          date: DateTime(2023, 12, 1),
          location: testAddress,
          adjustments: testAdjustments,
          calculationMethod: 'UmmAlQura',
          madhab: 'hanafi',
          higherLatitude: 'MiddleOfTheNight',
        );

        final result = await useCase(params);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (l) => fail('Expected Right but got Left: $l'),
          (r) {
            // Verify all required prayers are present
            final prayerNames = r.map((p) => p.name.english).toList();
            expect(prayerNames, containsAll(['Fajr', 'Dhuhr']));
          },
        );
        verify(() => mockRepository.init(
              testAddress,
              testAdjustments,
              'UmmAlQura',
              'hanafi',
              'MiddleOfTheNight',
            )).called(1);
      });

      test('should validate prayer time structure', () async {
        // Arrange
        final testAddress = Address(
          latitude: 28.7041,
          longitude: 77.1025,
          address: 'Delhi, India',
        );
        final testAdjustments = const Adjustments(
          fajr: 0,
          sunrise: 0,
          dhuhr: 0,
          asr: 0,
          maghrib: 0,
          isha: 0,
        );
        final expectedPrayerTimes = [
          PrayerTime(
            name: PrayerName(english: "Fajr", arabic: "فجر"),
            startTime: DateTime(2023, 12, 1, 5, 30),
            isCurrentPrayer: false,
          ),
        ];

        when(() => mockRepository.prayers(any()))
            .thenReturn(expectedPrayerTimes);

        // Act
        final params = GetPrayerTimesParams(
          date: DateTime(2023, 12, 1),
          location: testAddress,
          adjustments: testAdjustments,
          calculationMethod: 'Delhi',
          madhab: 'hanafi',
          higherLatitude: 'None',
        );

        final result = await useCase(params);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (l) => fail('Expected Right but got Left: $l'),
          (r) {
            // Validate prayer time structure
            for (final prayerTime in r) {
              expect(prayerTime.name.english, isNotEmpty);
              expect(prayerTime.name.arabic, isNotEmpty);
              expect(prayerTime.startTime, isA<DateTime>());
              expect(prayerTime.isCurrentPrayer, isA<bool>());
            }
          },
        );
      });
    });
  });
}
