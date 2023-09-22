import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taukeet/src/implementations/adhan_impl.dart';
import 'package:taukeet/src/services/geo_location_service.dart';
import 'package:taukeet/src/app.dart';
import 'package:taukeet/src/entities/address.dart';
import 'package:taukeet/src/entities/settings.dart';
import 'package:taukeet/src/libraries/settings_library.dart';
import 'package:taukeet/src/implementations/location_impl.dart';
import 'package:taukeet/src/services/prayer_time_service.dart';

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
  WidgetsFlutterBinding.ensureInitialized();
  // Load the JSON file from the assets folder
  String prayerJsonStr = await rootBundle.loadString('assets/data/prayer.json');

  // Parse the JSON data
  Map<String, dynamic> prayerData = json.decode(prayerJsonStr);

  await Hive.initFlutter();
  Hive.registerAdapter(SettingsAdapter());
  Hive.registerAdapter(AddressAdapter());

  getIt.registerSingleton<SettingsLibrary>(SettingsLibrary());
  await getIt<SettingsLibrary>().populateDefaultData();

  getIt.registerSingleton<GeoLocationService>(LocationImpl());
  getIt.registerSingleton<PrayerTimeService>(AdhanImpl(data: prayerData));

  // // Now you can use the jsonData as needed
  // print(jsonData[
  //     'methods']); // Replace 'key' with the actual key in your JSON data

  runApp(const App());
}
