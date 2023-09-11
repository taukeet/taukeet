import 'package:pray_times/pray_times.dart';

class PrayerTime {
  final String name;
  final String time;
  final Map<String, String> names = const {
    "Fajr": "فجر",
    "Sunrise": "شروق",
    "Dhuhr": "ظهر",
    "Asr": "عصر",
    "Sunset": "غروب",
    "Maghrib": "مغرب",
    "Isha": "عشاء"
  };

  const PrayerTime({
    required this.name,
    required this.time,
  });

  String secondName(String name) => names[name]!;
}

class PrayerTimeLibrary {
  final double latitude;
  final double longitude;
  final double timezone;

  const PrayerTimeLibrary({
    this.latitude = 31.7775067,
    this.longitude = 35.2368801,
    this.timezone = 2,
  });

  List<PrayerTime> get prayerTimes {
    List<PrayerTime> prayerTimeList = [];

    PrayerTimes prayers = PrayerTimes();
    prayers.setTimeFormat(prayers.Time24);
    prayers.setCalcMethod(prayers.MWL);
    prayers.setAsrJuristic(prayers.Shafii);
    prayers.setAdjustHighLats(prayers.AngleBased);
    var offsets = [0, 0, 0, 0, 0, 0, 0];
    prayers.tune(offsets);

    final date = DateTime(2023, DateTime.january, 20);
    List<String> times =
        prayers.getPrayerTimes(date, latitude, longitude, timezone);
    List<String> names = prayers.getTimeNames();

    for (int i = 0; i < times.length; i++) {
      prayerTimeList.add(PrayerTime(name: names[i], time: times[i]));
    }

    return prayerTimeList;
  }
}
