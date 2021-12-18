import 'package:taukeet/services/adhan_prayer_service.dart';

abstract class PrayerService {
  PrayerTime getCurrentPrayer();
  PrayerTime getNextPrayer();
  List<PrayerTime> getPrayerTimes();
}
