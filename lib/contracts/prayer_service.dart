import 'package:adhan/adhan.dart';
import 'package:taukeet/services/adhan_prayer_service.dart';

abstract class PrayerService {
  void initialize(
    Coordinates coordinates,
    Madhab madhab,
    CalculationParameters params,
  );
  PrayerTime getCurrentPrayer();
  PrayerTime getNextPrayer();
  List<PrayerTime> getPrayerTimes();
  List<CalculationMethod> get calculationMethods;
}
