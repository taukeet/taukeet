import 'package:adhan/adhan.dart';
import 'package:get_it/get_it.dart';
import 'package:taukeet/contracts/prayer_service.dart';
import 'package:taukeet/services/adhan_prayer_service.dart';

final getIt = GetIt.instance;

setupServiceLocator() {
  getIt.registerSingleton<PrayerService>(
    AdhanPrayerService(
      coordinates: Coordinates(21.1458, 79.0882),
      params: CalculationMethod.karachi.getParameters(),
      madhab: Madhab.hanafi,
    ),
  );
}
