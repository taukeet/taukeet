import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:taukeet/src/providers/prayer_time_provider.dart';
import 'package:taukeet/src/services/geo_location_service.dart';
import 'package:taukeet/src/app.dart';
import 'package:taukeet/src/implementations/location_impl.dart';

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

  String prayerJsonStr = await rootBundle.loadString('assets/data/prayer.json');
  Map<String, dynamic> prayerData = json.decode(prayerJsonStr);

  getIt.registerSingleton<GeoLocationService>(LocationImpl());

  runApp(ProviderScope(
    overrides: [
      prayerDataProvider.overrideWithValue(prayerData),
    ],
    child: App(),
  ));
}
