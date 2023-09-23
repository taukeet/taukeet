import 'package:taukeet/src/entities/address.dart';
import 'package:taukeet/src/entities/prayer_time.dart';

abstract class PrayerTimeService {
  List<Map<String, String>> get calculationMethods;
  List<Map<String, String>> get higherLatitudes;
  List<Map<String, String>> get madhabs;
  void init(
    Address address,
    String calculationMethod,
    String madhab,
    String higherLatitude,
  );
  List<PrayerTime> prayers(DateTime dateTime);
  PrayerTime currentPrayer();
}
