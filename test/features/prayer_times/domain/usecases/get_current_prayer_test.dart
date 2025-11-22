import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taukeet/core/errors/failures.dart';
import 'package:taukeet/features/location/domain/entities/address.dart';
import 'package:taukeet/features/prayer_times/domain/entities/adjustments.dart';
import 'package:taukeet/features/prayer_times/domain/entities/prayer_name.dart';
import 'package:taukeet/features/prayer_times/domain/entities/prayer_time.dart';
import 'package:taukeet/features/prayer_times/domain/repositories/prayer_repository.dart';
import 'package:taukeet/features/prayer_times/domain/usecases/get_current_prayer.dart';

class MockPrayerRepository extends Mock implements PrayerRepository {}

void main() {
  group('GetCurrentPrayer', () {
    late MockPrayerRepository mockRepository;
    late GetCurrentPrayer useCase;

    setUp(() {
      mockRepository = MockPrayerRepository();
      useCase = GetCurrentPrayer(mockRepository);
    });

    group('success cases', () {
      test('should return current prayer when repository call succeeds',
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
        final expectedPrayerTime = PrayerTime(
          name: PrayerName(english: "Fajr", arabic: "فجر"),
          startTime: DateTime(2023, 12, 1, 5, 30),
          isCurrentPrayer: false,
        );

        when(() => mockRepository.currentPrayer())
            .thenReturn(expectedPrayerTime);

        // Act
        final params = GetCurrentPrayerParams(
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
          (r) => expect(r, equals(expectedPrayerTime)),
        );
        verify(() => mockRepository.init(
              testAddress,
              testAdjustments,
              'Delhi',
              'hanafi',
              'None',
            )).called(1);
        verify(() => mockRepository.currentPrayer()).called(1);
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
        final expectedPrayerTime = PrayerTime(
          name: PrayerName(english: "Dhuhr", arabic: "ظهر"),
          startTime: DateTime(2023, 12, 1, 12, 15),
          isCurrentPrayer: false,
        );

        when(() => mockRepository.currentPrayer())
            .thenReturn(expectedPrayerTime);

        // Act
        final params = GetCurrentPrayerParams(
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
        final expectedPrayerTime = PrayerTime(
          name: PrayerName(english: "Asr", arabic: "عصر"),
          startTime: DateTime(2023, 12, 1, 15, 45),
          isCurrentPrayer: false,
        );

        when(() => mockRepository.currentPrayer())
            .thenReturn(expectedPrayerTime);

        // Act
        final params = GetCurrentPrayerParams(
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
          (r) => expect(r, equals(expectedPrayerTime)),
        );
        verify(() => mockRepository.init(
              testAddress,
              testAdjustments,
              'MuslimWorldLeague',
              'hanafi',
              'None',
            )).called(1);
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

        when(() => mockRepository.currentPrayer())
            .thenThrow(Exception('Repository error'));

        // Act
        final params = GetCurrentPrayerParams(
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
        verify(() => mockRepository.currentPrayer()).called(1);
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

        when(() => mockRepository.currentPrayer())
            .thenThrow(Exception('Unknown error'));

        // Act
        final params = GetCurrentPrayerParams(
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
        final expectedPrayerTime = PrayerTime(
          name: PrayerName(english: "Isha", arabic: "عشاء"),
          startTime: DateTime(2023, 12, 1, 20, 0),
          isCurrentPrayer: false,
        );

        when(() => mockRepository.currentPrayer())
            .thenReturn(expectedPrayerTime);

        // Act
        final params = GetCurrentPrayerParams(
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
          (r) => expect(r, equals(expectedPrayerTime)),
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
        final expectedPrayerTime = PrayerTime(
          name: PrayerName(english: "Maghrib", arabic: "مغرب"),
          startTime: DateTime(2023, 12, 1, 18, 30),
          isCurrentPrayer: false,
        );

        when(() => mockRepository.currentPrayer())
            .thenReturn(expectedPrayerTime);

        // Act
        final params = GetCurrentPrayerParams(
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
          (r) => expect(r, equals(expectedPrayerTime)),
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
        final expectedPrayerTime = PrayerTime(
          name: PrayerName(english: "Dhuhr", arabic: "ظهر"),
          startTime: DateTime(2023, 12, 1, 12, 15),
          isCurrentPrayer: true,
        );

        when(() => mockRepository.currentPrayer())
            .thenReturn(expectedPrayerTime);

        // Act
        final params = GetCurrentPrayerParams(
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
            expect(r.name.english, equals("Dhuhr"));
            expect(r.name.arabic, equals("ظهر"));
            expect(r.isCurrentPrayer, isTrue);
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
    });
  });
}
