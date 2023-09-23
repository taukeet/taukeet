import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:taukeet/src/implementations/adhan_impl.dart';
import 'package:taukeet/src/services/geo_location_service.dart';
import 'package:taukeet/src/app.dart';
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
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  // Load the JSON file from the assets folder
  String prayerJsonStr = await rootBundle.loadString('assets/data/prayer.json');

  // Parse the JSON data
  Map<String, dynamic> prayerData = json.decode(prayerJsonStr);

  getIt.registerSingleton<GeoLocationService>(LocationImpl());
  getIt.registerSingleton<PrayerTimeService>(AdhanImpl(data: prayerData));

  runApp(const App());
}
