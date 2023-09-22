import 'package:taukeet/src/entities/prayer_name.dart';

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