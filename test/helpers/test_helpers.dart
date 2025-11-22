import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taukeet/features/location/domain/entities/address.dart';
import 'package:taukeet/features/prayer_times/domain/entities/adjustments.dart';
import 'package:taukeet/features/prayer_times/domain/entities/prayer_name.dart';
import 'package:taukeet/features/prayer_times/domain/entities/prayer_time.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

// Test data factories
class TestDataFactory {
  static Address createTestAddress({
    double latitude = 28.7041,
    double longitude = 77.1025,
    String address = "Delhi, India",
  }) {
    return Address(
      latitude: latitude,
      longitude: longitude,
      address: address,
    );
  }

  static Adjustments createTestAdjustments({
    int fajr = 0,
    int sunrise = 0,
    int dhuhr = 0,
    int asr = 0,
    int maghrib = 0,
    int isha = 0,
  }) {
    return Adjustments(
      fajr: fajr,
      sunrise: sunrise,
      dhuhr: dhuhr,
      asr: asr,
      maghrib: maghrib,
      isha: isha,
    );
  }

  static PrayerTime createTestPrayerTime({
    String englishName = "Fajr",
    String arabicName = "فجر",
    DateTime? startTime,
    bool isCurrentPrayer = false,
  }) {
    return PrayerTime(
      name: PrayerName(english: englishName, arabic: arabicName),
      startTime: startTime ?? DateTime(2023, 12, 1, 5, 30),
      isCurrentPrayer: isCurrentPrayer,
    );
  }

  static List<PrayerTime> createTestPrayerList({DateTime? date}) {
    final testDate = date ?? DateTime(2023, 12, 1);
    return [
      PrayerTime(
        name: PrayerName(english: "Fajr", arabic: "فجر"),
        startTime: DateTime(testDate.year, testDate.month, testDate.day, 5, 30),
        isCurrentPrayer: false,
      ),
      PrayerTime(
        name: PrayerName(english: "Sunrise", arabic: "شروق"),
        startTime: DateTime(testDate.year, testDate.month, testDate.day, 6, 45),
        isCurrentPrayer: false,
      ),
      PrayerTime(
        name: PrayerName(english: "Dhuhr", arabic: "ظهر"),
        startTime: DateTime(testDate.year, testDate.month, testDate.day, 12, 15),
        isCurrentPrayer: testDate.hour == 12 && testDate.minute >= 15,
      ),
      PrayerTime(
        name: PrayerName(english: "Asr", arabic: "عصر"),
        startTime: DateTime(testDate.year, testDate.month, testDate.day, 15, 45),
        isCurrentPrayer: testDate.hour == 15 && testDate.minute >= 45,
      ),
      PrayerTime(
        name: PrayerName(english: "Maghrib", arabic: "مغرب"),
        startTime: DateTime(testDate.year, testDate.month, testDate.day, 18, 30),
        isCurrentPrayer: testDate.hour == 18 && testDate.minute >= 30,
      ),
      PrayerTime(
        name: PrayerName(english: "Isha", arabic: "عشاء"),
        startTime: DateTime(testDate.year, testDate.month, testDate.day, 20, 0),
        isCurrentPrayer: testDate.hour == 20 && testDate.minute >= 0,
      ),
    ];
  }

  static Map<String, dynamic> createTestPrayerData() {
    return {
      'methods': [
        'Dubai',
        'Egyptian',
        'Delhi',
        'Kuwait',
        'MoonsightingCommittee',
        'MuslimWorldLeague',
        'NorthAmerica',
        'Qatar',
        'Singapore',
        'Tehran',
        'Turkey',
        'UmmAlQura',
      ],
      'latitudes': [
        'MiddleOfTheNight',
        'SeventhOfTheNight',
        'TwilightAngle',
      ],
      'madhabs': [
        {'name': 'Hanafi', 'value': 'hanafi'},
        {'name': 'Shafi', 'value': 'shafi'},
      ],
    };
  }
}

// Test utilities
class TestUtils {
  /// Setup shared preferences mocks for testing
  static void setupSharedPreferencesMocks() {
    SharedPreferences.setMockInitialValues({});
  }

  /// Verify that a function throws a specific exception
  static Future<void> expectThrowsAsync<T extends Object>(
    Future<void> Function() callback,
    Matcher matcher,
  ) async {
    try {
      await callback();
      fail('Expected exception of type $T');
    } catch (e) {
      expect(e, matcher);
    }
  }

  /// Create a test container with overridden providers for testing
  static Map<String, dynamic> createTestSettingsJson({
    Address? address,
    Adjustments? adjustments,
    String madhab = 'hanafi',
    String calculationMethod = 'Karachi',
    String higherLatitude = 'None',
    bool hasFetchedInitialLocation = true,
    bool isTutorialCompleted = true,
  }) {
    return {
      'address': (address ?? TestDataFactory.createTestAddress()).toMap(),
      'adjustments':
          (adjustments ?? TestDataFactory.createTestAdjustments()).toMap(),
      'madhab': madhab,
      'calculation_method': calculationMethod,
      'higher_latitude': higherLatitude,
      'has_fetched_initial_location': hasFetchedInitialLocation,
      'is_tutorial_completed': isTutorialCompleted,
    };
  }
}

// Custom matchers
class IsDateTime extends Matcher {
  const IsDateTime();

  @override
  bool matches(item, Map matchState) => item is DateTime;

  @override
  Description describe(Description description) =>
      description.add('is DateTime');
}

const isDateTime = IsDateTime();

class IsAddress extends Matcher {
  const IsAddress();

  @override
  bool matches(item, Map matchState) => item is Address;

  @override
  Description describe(Description description) =>
      description.add('is Address');
}

const isAddress = IsAddress();
