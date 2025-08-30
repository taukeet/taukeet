import 'package:taukeet/features/location/domain/entities/address.dart';
import 'package:taukeet/features/prayer_times/domain/entities/adjustments.dart';
import 'package:taukeet/features/prayer_times/domain/entities/prayer_time.dart';

abstract class PrayerRepository {
  List<String> get calculationMethods;
  List<String> get higherLatitudes;
  List<Map<String, String>> get madhabs;
  void init(
    Address address,
    Adjustments adjustments,
    String calculationMethod,
    String madhab,
    String higherLatitude,
  );
  List<PrayerTime> prayers(DateTime dateTime);
  PrayerTime currentPrayer();
}
