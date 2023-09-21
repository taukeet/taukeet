import 'package:adhan_dart/adhan_dart.dart';
import 'package:taukeet/main.dart';
import 'package:taukeet/src/entities/address.dart';
import 'package:taukeet/src/libraries/settings_library.dart';

class PrayerName {
  final String english;
  final String arabic;

  PrayerName({required this.english, required this.arabic});
}

class PrayerTime {
  final PrayerName name;
  final DateTime startTime;
  final bool isCurrentPrayer;

  PrayerTime({
    required this.name,
    required this.startTime,
    this.isCurrentPrayer = false,
  });
}

class PrayerTimeLibrary {
  List<Map<String, String>> get calculationMethods => [
        {
          'name': 'MuslimWorldLeague',
          'description':
              'Muslim World League (MWL) method, usually used in Europe, Far East, and parts of America. Default in most calculators.'
        },
        {
          'name': 'Egyptian',
          'description':
              'Egyptian General Authority of Survey method, commonly used in Egypt.'
        },
        {
          'name': 'Karachi',
          'description':
              'University of Islamic Sciences, Karachi method, widely used in Karachi, Pakistan.'
        },
        {
          'name': 'UmmAlQura',
          'description':
              'Umm al-Qura University, Makkah method, utilized in Makkah, Saudi Arabia.'
        },
        {
          'name': 'Dubai',
          'description':
              'Dubai method, specific to Dubai, United Arab Emirates.'
        },
        {
          'name': 'MoonsightingCommittee',
          'description':
              'Moonsighting Committee method, based on moonsighting observations.'
        },
        {
          'name': 'NorthAmerica',
          'description':
              'Islamic Society of North America (ISNA) method, commonly used in North America.'
        },
        {
          'name': 'Kuwait',
          'description': 'Kuwait method, commonly used in Kuwait.'
        },
        {'name': 'Qatar', 'description': 'Qatar method, specific to Qatar.'},
        {
          'name': 'Singapore',
          'description': 'Singapore method, specific to Singapore.'
        },
        {
          'name': 'Tehran',
          'description':
              'Institute of Geophysics, University of Tehran method, commonly used in Tehran, Iran.'
        },
        {
          'name': 'Turkey',
          'description': 'Dianet, Turkey method, utilized in Turkey.'
        },
        {
          'name': 'Morocco',
          'description':
              'Moroccan Ministry of Habous and Islamic Affairs method, commonly used in Morocco.'
        },
        {
          'name': 'Other',
          'description':
              'Other or generic calculation method with no specific parameters.'
        },
      ];

  final _prayerTimeMap = {
    Prayer.Fajr: PrayerName(english: "Fajr", arabic: "فجر"),
    Prayer.Sunrise: PrayerName(english: "Sunrise", arabic: "شروق"),
    Prayer.Dhuhr: PrayerName(english: "Dhuhr", arabic: "ظهر"),
    Prayer.Asr: PrayerName(english: "Asr", arabic: "عصر"),
    Prayer.Maghrib: PrayerName(english: "Maghrib", arabic: "مغرب"),
    Prayer.Isha: PrayerName(english: "Isha", arabic: "عشاء"),
  };

  dynamic _calculationMehod(String methodName) {
    switch (methodName) {
      case 'Dubai':
        return CalculationMethod.Dubai();
      case 'Egyptian':
        return CalculationMethod.Egyptian();
      case 'Karachi':
        return CalculationMethod.Karachi();
      case 'Kuwait':
        return CalculationMethod.Kuwait();
      case 'Morocco':
        return CalculationMethod.Morocco();
      case 'MoonsightingCommittee':
        return CalculationMethod.MoonsightingCommittee();
      case 'MuslimWorldLeague':
        return CalculationMethod.MuslimWorldLeague();
      case 'NorthAmerica':
        return CalculationMethod.NorthAmerica();
      case 'Qatar':
        return CalculationMethod.Qatar();
      case 'Singapore':
        return CalculationMethod.Singapore();
      case 'Tehran':
        return CalculationMethod.Tehran();
      case 'Turkey':
        return CalculationMethod.Turkey();
      case 'UmmAlQura':
        return CalculationMethod.UmmAlQura();
      default:
        return CalculationMethod
            .Other(); // Return 'Other' method if the provided method name is not found
    }
  }

  PrayerTimes _calculatePrayertimes(DateTime dateTime) {
    Address address = SettingsLibrary.getSettings().address;
    Coordinates coordinates = Coordinates(address.latitude, address.longitude);
    CalculationParameters params =
        _calculationMehod(SettingsLibrary.getSettings().calculationMethod);
    params.madhab = SettingsLibrary.getSettings().madhab;
    return PrayerTimes(coordinates, dateTime, params);
  }

  List<PrayerTime> prayers(DateTime dateTime) {
    PrayerTimes prayerTimes = _calculatePrayertimes(dateTime);
    final currentPrayer = prayerTimes.currentPrayer(date: DateTime.now());

    return _prayerTimeMap.keys.map((prayer) {
      return PrayerTime(
        name: _prayerTimeMap[prayer]!,
        startTime: prayerTimes.timeForPrayer(prayer)!.toLocal(),
        isCurrentPrayer: currentPrayer == prayer && dateTime.isToday(),
      );
    }).toList();
  }

  PrayerTime currentPrayer() {
    PrayerTimes prayerTimes = _calculatePrayertimes(DateTime.now());
    final prayer = prayerTimes.currentPrayer(date: DateTime.now());

    return PrayerTime(
      name: _prayerTimeMap[prayer]!,
      startTime: prayerTimes.timeForPrayer(prayer)!.toLocal(),
      isCurrentPrayer: false,
    );
  }
}
