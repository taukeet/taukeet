import 'package:adhan_dart/adhan_dart.dart';

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
  final double latitude;
  final double longitude;

  const PrayerTimeLibrary({
    required this.latitude,
    required this.longitude,
  });

  List<PrayerTime> get prayers {
    final prayerTimeMap = {
      Prayer.Fajr: PrayerName(english: "Fajr", arabic: "فجر"),
      Prayer.Sunrise: PrayerName(english: "Sunrise", arabic: "شروق"),
      Prayer.Dhuhr: PrayerName(english: "Dhuhr", arabic: "ظهر"),
      Prayer.Asr: PrayerName(english: "Asr", arabic: "عصر"),
      Prayer.Maghrib: PrayerName(english: "Maghrib", arabic: "مغرب"),
      Prayer.Isha: PrayerName(english: "Isha", arabic: "عشاء"),
    };

    Coordinates coordinates = Coordinates(latitude, longitude);
    CalculationParameters params = CalculationMethod.MuslimWorldLeague();
    PrayerTimes prayerTimes = PrayerTimes(coordinates, DateTime.now(), params);

    return prayerTimeMap.keys.map((prayer) {
      return PrayerTime(
        name: prayerTimeMap[prayer]!,
        startTime: prayerTimes.timeForPrayer(prayer)!.toLocal(),
        isCurrentPrayer: false,
      );
    }).toList();
  }
}
