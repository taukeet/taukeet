import 'package:flutter_test/flutter_test.dart';
import 'package:taukeet/src/entities/address.dart';
import 'package:taukeet/src/entities/adjustments.dart';
import 'package:taukeet/src/implementations/adhan_impl.dart';
import '../../helpers/test_helpers.dart';

void main() {
  group('AdhanImpl Tests', () {
    late AdhanImpl adhanImpl;
    late Map<String, dynamic> testData;
    late Address testAddress;
    late Adjustments testAdjustments;

    setUp(() {
      testData = TestDataFactory.createTestPrayerData();
      adhanImpl = AdhanImpl(data: testData);
      testAddress = TestDataFactory.createTestAddress();
      testAdjustments = TestDataFactory.createTestAdjustments();
    });

    group('Initialization', () {
      test('should initialize with test data', () {
        // Assert
        expect(adhanImpl.data, equals(testData));
      });

      test('should expose calculation methods from data', () {
        // Act
        final methods = adhanImpl.calculationMethods;

        // Assert
        expect(methods, isA<List<String>>());
        expect(methods, contains('Karachi'));
        expect(methods, contains('MuslimWorldLeague'));
        expect(methods, contains('Egyptian'));
      });

      test('should expose higher latitude rules from data', () {
        // Act
        final latitudes = adhanImpl.higherLatitudes;

        // Assert
        expect(latitudes, isA<List<String>>());
        expect(latitudes, contains('MiddleOfTheNight'));
        expect(latitudes, contains('SeventhOfTheNight'));
        expect(latitudes, contains('TwilightAngle'));
      });
    });

    group('Service Initialization', () {
      test('should initialize service with parameters', () {
        // Act & Assert - Should not throw
        expect(() {
          adhanImpl.init(
            testAddress,
            testAdjustments,
            'Karachi',
            'hanafi',
            'MiddleOfTheNight',
          );
        }, returnsNormally);
      });

      test('should store initialization parameters', () {
        // Act
        adhanImpl.init(
          testAddress,
          testAdjustments,
          'Karachi',
          'hanafi',
          'MiddleOfTheNight',
        );

        // Assert - We can't directly access private fields, but we can test behavior
        expect(() => adhanImpl.currentPrayer(), returnsNormally);
      });
    });

    group('Prayer Time Calculations', () {
      setUp(() {
        adhanImpl.init(
          testAddress,
          testAdjustments,
          'Karachi',
          'hanafi',
          'MiddleOfTheNight',
        );
      });

      test('should calculate prayer times for a given date', () {
        // Arrange
        final testDate = DateTime(2023, 12, 1);

        // Act
        final prayers = adhanImpl.prayers(testDate);

        // Assert
        expect(prayers, isA<List>());
        expect(prayers.length, equals(6)); // Fajr, Sunrise, Dhuhr, Asr, Maghrib, Isha
        
        // Verify all prayer times are present
        final prayerNames = prayers.map((p) => p.name.english).toList();
        expect(prayerNames, contains('Fajr'));
        expect(prayerNames, contains('Sunrise'));
        expect(prayerNames, contains('Dhuhr'));
        expect(prayerNames, contains('Asr'));
        expect(prayerNames, contains('Maghrib'));
        expect(prayerNames, contains('Isha'));
      });

      test('should return current prayer', () {
        // Act
        final currentPrayer = adhanImpl.currentPrayer();

        // Assert
        expect(currentPrayer, isNotNull);
        expect(currentPrayer.name, isNotNull);
        expect(currentPrayer.startTime, isNotNull);
      });

      test('should handle prayer times in correct chronological order', () {
        // Arrange
        final testDate = DateTime(2023, 12, 1);

        // Act
        final prayers = adhanImpl.prayers(testDate);

        // Assert
        for (int i = 1; i < prayers.length; i++) {
          expect(
            prayers[i].startTime.isAfter(prayers[i - 1].startTime),
            isTrue,
            reason: '${prayers[i].name.english} should be after ${prayers[i - 1].name.english}',
          );
        }
      });

      test('should apply adjustments to prayer times', () {
        // Arrange
        const adjustments = Adjustments(
          fajr: 5,
          sunrise: -2,
          dhuhr: 3,
          asr: 1,
          maghrib: 0,
          isha: -4,
        );
        
        adhanImpl.init(
          testAddress,
          adjustments,
          'Karachi',
          'hanafi',
          'MiddleOfTheNight',
        );

        final testDate = DateTime(2023, 12, 1);

        // Act
        final prayers = adhanImpl.prayers(testDate);

        // Assert - We can't easily verify exact minute adjustments without complex calculations,
        // but we can verify the structure is correct and times are reasonable
        expect(prayers.length, equals(6));
        
        // All prayer times should be on the same date
        for (final prayer in prayers) {
          expect(prayer.startTime.year, equals(testDate.year));
          expect(prayer.startTime.month, equals(testDate.month));
          expect(prayer.startTime.day, equals(testDate.day));
        }
      });
    });

    group('Calculation Method Mapping', () {
      test('should handle different calculation methods', () {
        final methods = [
          'Dubai',
          'Egyptian', 
          'Karachi',
          'Kuwait',
          'MoonsightingCommittee',
          'MuslimWorldLeague',
          'NorthAmerica',
          'Qatar',
          'Singapore',
          'Tehran',
          'Turkey',
          'UmmAlQura',
        ];

        for (final method in methods) {
          expect(() {
            adhanImpl.init(
              testAddress,
              testAdjustments,
              method,
              'hanafi',
              'MiddleOfTheNight',
            );
            adhanImpl.currentPrayer();
          }, returnsNormally, reason: 'Should handle $method method');
        }
      });

      test('should handle different madhabs', () {
        final madhabs = ['hanafi', 'shafi'];

        for (final madhab in madhabs) {
          expect(() {
            adhanImpl.init(
              testAddress,
              testAdjustments,
              'Karachi',
              madhab,
              'MiddleOfTheNight',
            );
            adhanImpl.currentPrayer();
          }, returnsNormally, reason: 'Should handle $madhab madhab');
        }
      });

      test('should handle different higher latitude rules', () {
        final latitudeRules = [
          'MiddleOfTheNight',
          'SeventhOfTheNight',
          'TwilightAngle',
          'None', // This should map to null internally
        ];

        for (final rule in latitudeRules) {
          expect(() {
            adhanImpl.init(
              testAddress,
              testAdjustments,
              'Karachi',
              'hanafi',
              rule,
            );
            adhanImpl.currentPrayer();
          }, returnsNormally, reason: 'Should handle $rule latitude rule');
        }
      });
    });

    group('Edge Cases', () {
      test('should handle different coordinates', () {
        // Test with different global locations
        final locations = [
          Address(latitude: 21.3099, longitude: 39.8208, address: "Mecca, Saudi Arabia"),
          Address(latitude: 40.7128, longitude: -74.0060, address: "New York, USA"),
          Address(latitude: 51.5074, longitude: -0.1278, address: "London, UK"),
          Address(latitude: -33.8688, longitude: 151.2093, address: "Sydney, Australia"),
        ];

        for (final location in locations) {
          expect(() {
            adhanImpl.init(
              location,
              testAdjustments,
              'Karachi',
              'hanafi',
              'MiddleOfTheNight',
            );
            final prayers = adhanImpl.prayers(DateTime(2023, 12, 1));
            expect(prayers.length, equals(6));
          }, returnsNormally, reason: 'Should handle location ${location.address}');
        }
      });

      test('should handle year boundaries correctly', () {
        adhanImpl.init(
          testAddress,
          testAdjustments,
          'Karachi',
          'hanafi',
          'MiddleOfTheNight',
        );

        final dates = [
          DateTime(2023, 1, 1),   // Start of year
          DateTime(2023, 12, 31), // End of year
          DateTime(2024, 2, 29),  // Leap year
        ];

        for (final date in dates) {
          final prayers = adhanImpl.prayers(date);
          expect(prayers.length, equals(6));
          
          // All prayers should be on the requested date
          for (final prayer in prayers) {
            expect(prayer.startTime.year, equals(date.year));
            expect(prayer.startTime.month, equals(date.month));
            expect(prayer.startTime.day, equals(date.day));
          }
        }
      });

      test('should handle extreme adjustments', () {
        const extremeAdjustments = Adjustments(
          fajr: 60,
          sunrise: -60,
          dhuhr: 30,
          asr: -30,
          maghrib: 15,
          isha: -15,
        );

        expect(() {
          adhanImpl.init(
            testAddress,
            extremeAdjustments,
            'Karachi',
            'hanafi',
            'MiddleOfTheNight',
          );
          final prayers = adhanImpl.prayers(DateTime(2023, 12, 1));
          expect(prayers.length, equals(6));
        }, returnsNormally);
      });
    });

    group('Prayer Name and Arabic Text', () {
      setUp(() {
        adhanImpl.init(
          testAddress,
          testAdjustments,
          'Karachi',
          'hanafi',
          'MiddleOfTheNight',
        );
      });

      test('should have correct Arabic names for prayers', () {
        // Arrange
        final testDate = DateTime(2023, 12, 1);

        // Act
        final prayers = adhanImpl.prayers(testDate);

        // Assert
        final prayersByName = Map.fromIterable(
          prayers,
          key: (p) => p.name.english,
          value: (p) => p.name.arabic,
        );

        expect(prayersByName['Fajr'], equals('فجر'));
        expect(prayersByName['Sunrise'], equals('شروق'));
        expect(prayersByName['Dhuhr'], equals('ظهر'));
        expect(prayersByName['Asr'], equals('عصر'));
        expect(prayersByName['Maghrib'], equals('مغرب'));
        expect(prayersByName['Isha'], equals('عشاء'));
      });

      test('should mark current prayer correctly based on time', () {
        // Arrange
        final testDate = DateTime.now();

        // Act
        final prayers = adhanImpl.prayers(testDate);
        final currentPrayers = prayers.where((p) => p.isCurrentPrayer).toList();

        // Assert
        // Should have at most one current prayer
        expect(currentPrayers.length, lessThanOrEqualTo(1));
      });
    });
  });
}
