import 'package:adhan/adhan.dart';

class PrayerTime {
  final String prayer;
  final DateTime startTime;
  final DateTime endTime;
  final bool isCurrentPrayer;

  PrayerTime({
    required this.prayer,
    required this.startTime,
    required this.endTime,
    this.isCurrentPrayer = false,
  });
}

class PrayerService {
  final Coordinates coordinates;
  final CalculationParameters params;
  final Madhab madhab;
  late PrayerTimes prayerTimes;

  PrayerService({
    required this.coordinates,
    required this.params,
    required this.madhab,
  }) {
    params.madhab = madhab;
    prayerTimes = _getPrayerTimes(DateTime.now());
  }

  /// Return current prayer and ending time
  PrayerTime getCurrentPrayer() {
    Prayer prayer = prayerTimes.currentPrayer();
    Prayer nextPrayer = prayerTimes.nextPrayer() == Prayer.none
        ? Prayer.fajr
        : prayerTimes.nextPrayer();

    if (prayer == Prayer.none && prayerTimes.nextPrayer() == Prayer.fajr) {
      prayer = Prayer.isha;
    }

    return PrayerTime(
      prayer: _getPrayerName(prayer),
      startTime: prayerTimes.timeForPrayer(prayer)!,
      endTime: prayerTimes.timeForPrayer(nextPrayer)!,
    );
  }

  PrayerTime getNextPrayer() {
    Prayer prayer = prayerTimes.nextPrayer();
    // DateTime prayerStartTime = prayerTimes.timeForPrayer(prayer)!;

    if (prayer == Prayer.none && prayerTimes.currentPrayer() == Prayer.isha) {
      prayer = Prayer.fajr;

      var today = DateTime.now();
      // var tomorrow = today.add(Duration(days: 1));
    }

    return PrayerTime(
      prayer: _getPrayerName(prayer),
      startTime: prayerTimes.timeForPrayer(prayer)!,
      endTime: DateTime.now(), //prayerTimes.timeForPrayer(nextPrayer)!,
    );
  }

  /// Return the list of PrayerTime Object
  List<PrayerTime> getPrayerTimes() {
    List<PrayerTime> times = [];

    for (var prayer in Prayer.values) {
      switch (prayer) {
        case Prayer.none:
          break;
        case Prayer.fajr:
          times.add(PrayerTime(
            prayer: 'fajr',
            startTime: prayerTimes.fajr,
            endTime: prayerTimes.sunrise,
            isCurrentPrayer: prayerTimes.currentPrayer() == Prayer.fajr,
          ));
          break;
        case Prayer.sunrise:
          times.add(PrayerTime(
            prayer: 'sunrise',
            startTime: prayerTimes.sunrise,
            endTime: prayerTimes.dhuhr,
            isCurrentPrayer: prayerTimes.currentPrayer() == Prayer.sunrise,
          ));
          break;
        case Prayer.dhuhr:
          times.add(PrayerTime(
            prayer: 'dhuhr',
            startTime: prayerTimes.dhuhr,
            endTime: prayerTimes.asr,
            isCurrentPrayer: prayerTimes.currentPrayer() == Prayer.dhuhr,
          ));
          break;
        case Prayer.asr:
          times.add(PrayerTime(
            prayer: 'asr',
            startTime: prayerTimes.asr,
            endTime: prayerTimes.maghrib,
            isCurrentPrayer: prayerTimes.currentPrayer() == Prayer.asr,
          ));
          break;
        case Prayer.maghrib:
          times.add(PrayerTime(
            prayer: 'maghrib',
            startTime: prayerTimes.maghrib,
            endTime: prayerTimes.isha,
            isCurrentPrayer: prayerTimes.currentPrayer() == Prayer.maghrib,
          ));
          break;
        case Prayer.isha:
          times.add(PrayerTime(
            prayer: 'isha',
            startTime: prayerTimes.isha,
            endTime: prayerTimes.fajr,
            isCurrentPrayer: prayerTimes.currentPrayer() == Prayer.maghrib,
          ));
          break;
      }
    }

    return times;
  }

  /// return the strring name of prayer
  String _getPrayerName(Prayer prayer) {
    switch (prayer) {
      case Prayer.none:
        return "none";
      case Prayer.fajr:
        return "fajr";
      case Prayer.sunrise:
        return "sunrise";
      case Prayer.dhuhr:
        return "dhuhr";
      case Prayer.asr:
        return "asr";
      case Prayer.maghrib:
        return "maghrib";
      case Prayer.isha:
        return "isha";
    }
  }

  PrayerTimes _getPrayerTimes(DateTime dateTime) {
    return PrayerTimes(
      coordinates,
      DateComponents.from(dateTime),
      params,
    );
  }
}
