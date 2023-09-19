import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taukeet/src/app.dart';
import 'package:taukeet/src/entities/address.dart';
import 'package:taukeet/src/entities/settings.dart';
import 'package:taukeet/src/libraries/prayer_time_library.dart';
import 'package:taukeet/src/libraries/settings_library.dart';

final getIt = GetIt.instance;

extension StringCasingExtension on String {
  String capitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String humanReadable() =>
      replaceAllMapped(RegExp(r'[A-Z]'), (match) => ' ${match.group(0)}')
          .trim();
}

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SettingsAdapter());
  Hive.registerAdapter(AddressAdapter());

  await SettingsLibrary.populateDefaultData();
  getIt.registerSingleton<PrayerTimeLibrary>(PrayerTimeLibrary());

  runApp(const App());
}
