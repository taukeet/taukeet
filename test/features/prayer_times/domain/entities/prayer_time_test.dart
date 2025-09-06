import 'package:flutter_test/flutter_test.dart';
import 'package:taukeet/features/prayer_times/domain/entities/prayer_name.dart';
import 'package:taukeet/features/prayer_times/domain/entities/prayer_time.dart';

void main() {
  group('PrayerTime Entity Tests', () {
    final testPrayerName = PrayerName(english: "Fajr", arabic: "فجر");
    final testStartTime = DateTime(2023, 12, 1, 5, 30);

    test('should create PrayerTime with all properties', () {
      // Act
      final prayerTime = PrayerTime(
        name: testPrayerName,
        startTime: testStartTime,
        isCurrentPrayer: true,
      );

      // Assert
      expect(prayerTime.name, equals(testPrayerName));
      expect(prayerTime.startTime, equals(testStartTime));
      expect(prayerTime.isCurrentPrayer, isTrue);
    });

    test('should create PrayerTime with default isCurrentPrayer false', () {
      // Act
      final prayerTime = PrayerTime(
        name: testPrayerName,
        startTime: testStartTime,
      );

      // Assert
      expect(prayerTime.name, equals(testPrayerName));
      expect(prayerTime.startTime, equals(testStartTime));
      expect(prayerTime.isCurrentPrayer, isFalse);
    });

    test('should handle different prayer names correctly', () {
      // Arrange
      final prayers = [
        PrayerName(english: "Fajr", arabic: "فجر"),
        PrayerName(english: "Dhuhr", arabic: "ظهر"),
        PrayerName(english: "Asr", arabic: "عصر"),
        PrayerName(english: "Maghrib", arabic: "مغرب"),
        PrayerName(english: "Isha", arabic: "عشاء"),
      ];

      final prayerTimes = prayers.map((prayer) {
        return PrayerTime(
          name: prayer,
          startTime: testStartTime,
          isCurrentPrayer: false,
        );
      }).toList();

      // Assert
      expect(prayerTimes.length, equals(5));
      expect(prayerTimes[0].name.english, equals("Fajr"));
      expect(prayerTimes[1].name.english, equals("Dhuhr"));
      expect(prayerTimes[2].name.english, equals("Asr"));
      expect(prayerTimes[3].name.english, equals("Maghrib"));
      expect(prayerTimes[4].name.english, equals("Isha"));
    });

    test('should handle different start times correctly', () {
      // Arrange
      final morningTime = DateTime(2023, 12, 1, 5, 30);
      final afternoonTime = DateTime(2023, 12, 1, 12, 15);
      final eveningTime = DateTime(2023, 12, 1, 18, 30);

      // Act
      final morningPrayer = PrayerTime(
        name: PrayerName(english: "Fajr", arabic: "فجر"),
        startTime: morningTime,
      );

      final afternoonPrayer = PrayerTime(
        name: PrayerName(english: "Dhuhr", arabic: "ظهر"),
        startTime: afternoonTime,
      );

      final eveningPrayer = PrayerTime(
        name: PrayerName(english: "Maghrib", arabic: "مغرب"),
        startTime: eveningTime,
      );

      // Assert
      expect(morningPrayer.startTime.hour, equals(5));
      expect(afternoonPrayer.startTime.hour, equals(12));
      expect(eveningPrayer.startTime.hour, equals(18));
    });

    test('should handle isCurrentPrayer flag correctly', () {
      // Arrange
      final prayers = [
        PrayerTime(
          name: PrayerName(english: "Fajr", arabic: "فجر"),
          startTime: DateTime(2023, 12, 1, 5, 30),
          isCurrentPrayer: false,
        ),
        PrayerTime(
          name: PrayerName(english: "Dhuhr", arabic: "ظهر"),
          startTime: DateTime(2023, 12, 1, 12, 15),
          isCurrentPrayer: true,
        ),
        PrayerTime(
          name: PrayerName(english: "Asr", arabic: "عصر"),
          startTime: DateTime(2023, 12, 1, 15, 45),
          isCurrentPrayer: false,
        ),
      ];

      // Act & Assert
      expect(prayers[0].isCurrentPrayer, isFalse);
      expect(prayers[1].isCurrentPrayer, isTrue);
      expect(prayers[2].isCurrentPrayer, isFalse);

      final currentPrayers = prayers.where((p) => p.isCurrentPrayer).toList();
      expect(currentPrayers.length, equals(1));
      expect(currentPrayers.first.name.english, equals("Dhuhr"));
    });

    test('should handle edge cases with time zones', () {
      // Arrange
      final utcTime = DateTime.utc(2023, 12, 1, 5, 30);
      final localTime = DateTime(2023, 12, 1, 5, 30);

      // Act
      final utcPrayer = PrayerTime(
        name: testPrayerName,
        startTime: utcTime,
      );

      final localPrayer = PrayerTime(
        name: testPrayerName,
        startTime: localTime,
      );

      // Assert
      expect(utcPrayer.startTime.isUtc, isTrue);
      expect(localPrayer.startTime.isUtc, isFalse);
    });

    test('should handle date boundaries correctly', () {
      // Arrange
      final endOfDay = DateTime(2023, 12, 1, 23, 59);
      final startOfDay = DateTime(2023, 12, 2, 0, 1);

      // Act
      final lastPrayer = PrayerTime(
        name: PrayerName(english: "Isha", arabic: "عشاء"),
        startTime: endOfDay,
      );

      final firstPrayer = PrayerTime(
        name: PrayerName(english: "Fajr", arabic: "فجر"),
        startTime: startOfDay,
      );

      // Assert
      expect(lastPrayer.startTime.day, equals(1));
      expect(firstPrayer.startTime.day, equals(2));
      expect(lastPrayer.startTime.hour, equals(23));
      expect(firstPrayer.startTime.hour, equals(0));
    });
  });
}
