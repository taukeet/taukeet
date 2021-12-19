import 'package:adhan/adhan.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taukeet/contracts/location_service.dart';
import 'package:taukeet/contracts/prayer_service.dart';
import 'package:taukeet/contracts/storage_service.dart';
import 'package:taukeet/services/adhan_prayer_service.dart';
import 'package:taukeet/services/geo_location_service.dart';
import 'package:taukeet/services/prefs_storage_service.dart';

final getIt = GetIt.instance;

setupServiceLocator() async {
  getIt.registerSingleton<LocationService>(GeoLocationService());
  getIt.registerSingleton<StorageService>(
      PrefsStorageService(prefs: await SharedPreferences.getInstance()));
  getIt.registerSingleton<PrayerService>(
    AdhanPrayerService(
      coordinates: Coordinates(21.1458, 79.0882),
      params: CalculationMethod.karachi.getParameters(),
      madhab: Madhab.hanafi,
    ),
  );
}
