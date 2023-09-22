import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taukeet/src/interfaces/geo_location.dart';
import 'package:taukeet/src/app.dart';
import 'package:taukeet/src/entities/address.dart';
import 'package:taukeet/src/entities/settings.dart';
import 'package:taukeet/src/libraries/prayer_time_library.dart';
import 'package:taukeet/src/libraries/settings_library.dart';
import 'package:taukeet/src/services/location_service.dart';

final getIt = GetIt.instance;

extension StringCasingExtension on String {
  String capitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String humanReadable() =>
      replaceAllMapped(RegExp(r'[A-Z]'), (match) => ' ${match.group(0)}')
          .trim();
}

extension DateTimeExtensions on DateTime {
  bool isToday() {
    final currentDate = DateTime.now();
    return year == currentDate.year &&
        month == currentDate.month &&
        day == currentDate.day;
  }
}

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SettingsAdapter());
  Hive.registerAdapter(AddressAdapter());

  getIt.registerSingleton<SettingsLibrary>(SettingsLibrary());
  await getIt<SettingsLibrary>().populateDefaultData();
  getIt.registerSingleton<PrayerTimeLibrary>(PrayerTimeLibrary());
  getIt.registerSingleton<GeoLocation>(LocationService());

  runApp(const App());
}
