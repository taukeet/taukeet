import 'package:adhan_dart/adhan_dart.dart';
import 'package:taukeet/src/entities/address.dart';

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
  final Address address;

  const PrayerTimeLibrary({
    required this.address,
  });

  List<PrayerTime> prayers(DateTime dateTime) {
    final prayerTimeMap = {
      Prayer.Fajr: PrayerName(english: "Fajr", arabic: "فجر"),
      Prayer.Sunrise: PrayerName(english: "Sunrise", arabic: "شروق"),
      Prayer.Dhuhr: PrayerName(english: "Dhuhr", arabic: "ظهر"),
      Prayer.Asr: PrayerName(english: "Asr", arabic: "عصر"),
      Prayer.Maghrib: PrayerName(english: "Maghrib", arabic: "مغرب"),
      Prayer.Isha: PrayerName(english: "Isha", arabic: "عشاء"),
    };

    Coordinates coordinates = Coordinates(address.latitude, address.longitude);
    CalculationParameters params = CalculationMethod.MuslimWorldLeague();
    params.madhab = Madhab.Hanafi;
    PrayerTimes prayerTimes = PrayerTimes(coordinates, dateTime, params);

    return prayerTimeMap.keys.map((prayer) {
      return PrayerTime(
        name: prayerTimeMap[prayer]!,
        startTime: prayerTimes.timeForPrayer(prayer)!.toLocal(),
        isCurrentPrayer: false,
      );
    }).toList();
  }
}
