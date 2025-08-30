import 'package:flutter_test/flutter_test.dart';
import 'package:taukeet/features/prayer_times/domain/entities/adjustments.dart';

void main() {
  group('Adjustments Entity Tests', () {
    test('should create Adjustments with all properties', () {
      // Act
      const adjustments = Adjustments(
        fajr: 5,
        sunrise: -2,
        dhuhr: 3,
        asr: 1,
        maghrib: 0,
        isha: -4,
      );

      // Assert
      expect(adjustments.fajr, equals(5));
      expect(adjustments.sunrise, equals(-2));
      expect(adjustments.dhuhr, equals(3));
      expect(adjustments.asr, equals(1));
      expect(adjustments.maghrib, equals(0));
      expect(adjustments.isha, equals(-4));
    });

    test('should create Adjustments with zero values', () {
      // Act
      const adjustments = Adjustments(
        fajr: 0,
        sunrise: 0,
        dhuhr: 0,
        asr: 0,
        maghrib: 0,
        isha: 0,
      );

      // Assert
      expect(adjustments.fajr, equals(0));
      expect(adjustments.sunrise, equals(0));
      expect(adjustments.dhuhr, equals(0));
      expect(adjustments.asr, equals(0));
      expect(adjustments.maghrib, equals(0));
      expect(adjustments.isha, equals(0));
    });

    test('should handle negative adjustment values', () {
      // Act
      const adjustments = Adjustments(
        fajr: -10,
        sunrise: -15,
        dhuhr: -5,
        asr: -3,
        maghrib: -8,
        isha: -12,
      );

      // Assert
      expect(adjustments.fajr, equals(-10));
      expect(adjustments.sunrise, equals(-15));
      expect(adjustments.dhuhr, equals(-5));
      expect(adjustments.asr, equals(-3));
      expect(adjustments.maghrib, equals(-8));
      expect(adjustments.isha, equals(-12));
    });

    test('should handle positive adjustment values', () {
      // Act
      const adjustments = Adjustments(
        fajr: 10,
        sunrise: 15,
        dhuhr: 5,
        asr: 3,
        maghrib: 8,
        isha: 12,
      );

      // Assert
      expect(adjustments.fajr, equals(10));
      expect(adjustments.sunrise, equals(15));
      expect(adjustments.dhuhr, equals(5));
      expect(adjustments.asr, equals(3));
      expect(adjustments.maghrib, equals(8));
      expect(adjustments.isha, equals(12));
    });

    test('should serialize to JSON correctly', () {
      // Arrange
      const adjustments = Adjustments(
        fajr: 5,
        sunrise: -2,
        dhuhr: 3,
        asr: 1,
        maghrib: 0,
        isha: -4,
      );

      // Act
      final json = adjustments.toJson();
      final decoded = Adjustments.fromJson(json);

      // Assert
      expect(decoded.fajr, equals(adjustments.fajr));
      expect(decoded.sunrise, equals(adjustments.sunrise));
      expect(decoded.dhuhr, equals(adjustments.dhuhr));
      expect(decoded.asr, equals(adjustments.asr));
      expect(decoded.maghrib, equals(adjustments.maghrib));
      expect(decoded.isha, equals(adjustments.isha));
    });

    test('should create from Map correctly', () {
      // Arrange
      final map = {
        'fajr': 5,
        'sunrise': -2,
        'dhuhr': 3,
        'asr': 1,
        'maghrib': 0,
        'isha': -4,
      };

      // Act
      final adjustments = Adjustments.fromMap(map);

      // Assert
      expect(adjustments.fajr, equals(5));
      expect(adjustments.sunrise, equals(-2));
      expect(adjustments.dhuhr, equals(3));
      expect(adjustments.asr, equals(1));
      expect(adjustments.maghrib, equals(0));
      expect(adjustments.isha, equals(-4));
    });

    test('should convert to Map correctly', () {
      // Arrange
      const adjustments = Adjustments(
        fajr: 5,
        sunrise: -2,
        dhuhr: 3,
        asr: 1,
        maghrib: 0,
        isha: -4,
      );

      // Act
      final map = adjustments.toMap();

      // Assert
      expect(map['fajr'], equals(5));
      expect(map['sunrise'], equals(-2));
      expect(map['dhuhr'], equals(3));
      expect(map['asr'], equals(1));
      expect(map['maghrib'], equals(0));
      expect(map['isha'], equals(-4));
    });

    test('should handle copyWith correctly', () {
      // Arrange
      const originalAdjustments = Adjustments(
        fajr: 5,
        sunrise: -2,
        dhuhr: 3,
        asr: 1,
        maghrib: 0,
        isha: -4,
      );

      // Act
      final updatedAdjustments = originalAdjustments.copyWith(
        fajr: 10,
        isha: -8,
      );

      // Assert
      expect(updatedAdjustments.fajr, equals(10));
      expect(updatedAdjustments.sunrise, equals(originalAdjustments.sunrise));
      expect(updatedAdjustments.dhuhr, equals(originalAdjustments.dhuhr));
      expect(updatedAdjustments.asr, equals(originalAdjustments.asr));
      expect(updatedAdjustments.maghrib, equals(originalAdjustments.maghrib));
      expect(updatedAdjustments.isha, equals(-8));
    });

    test('should handle copyWith with no changes', () {
      // Arrange
      const originalAdjustments = Adjustments(
        fajr: 5,
        sunrise: -2,
        dhuhr: 3,
        asr: 1,
        maghrib: 0,
        isha: -4,
      );

      // Act
      final copiedAdjustments = originalAdjustments.copyWith();

      // Assert
      expect(copiedAdjustments.fajr, equals(originalAdjustments.fajr));
      expect(copiedAdjustments.sunrise, equals(originalAdjustments.sunrise));
      expect(copiedAdjustments.dhuhr, equals(originalAdjustments.dhuhr));
      expect(copiedAdjustments.asr, equals(originalAdjustments.asr));
      expect(copiedAdjustments.maghrib, equals(originalAdjustments.maghrib));
      expect(copiedAdjustments.isha, equals(originalAdjustments.isha));
    });

    test('should handle extreme values', () {
      // Act
      const extremeAdjustments = Adjustments(
        fajr: 999,
        sunrise: -999,
        dhuhr: 500,
        asr: -500,
        maghrib: 100,
        isha: -100,
      );

      // Assert
      expect(extremeAdjustments.fajr, equals(999));
      expect(extremeAdjustments.sunrise, equals(-999));
      expect(extremeAdjustments.dhuhr, equals(500));
      expect(extremeAdjustments.asr, equals(-500));
      expect(extremeAdjustments.maghrib, equals(100));
      expect(extremeAdjustments.isha, equals(-100));
    });

    test('should maintain immutability', () {
      // Arrange
      const adjustments = Adjustments(
        fajr: 5,
        sunrise: -2,
        dhuhr: 3,
        asr: 1,
        maghrib: 0,
        isha: -4,
      );

      // Act
      final modified = adjustments.copyWith(fajr: 20);

      // Assert
      expect(adjustments.fajr, equals(5)); // Original unchanged
      expect(modified.fajr, equals(20)); // Copy modified
    });
  });
}
