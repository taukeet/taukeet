import 'package:adhan/adhan.dart';
import 'package:taukeet/contracts/storage_service.dart';
import 'package:taukeet/services/adhan_prayer_service.dart';

abstract class PrayerService {
  void refreshTimes(StorageService storageService);
  PrayerTime getCurrentPrayer();
  List<PrayerTime> getPrayerTimes();
  List<CalculationMethod> get calculationMethods;
}
