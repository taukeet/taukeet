import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taukeet/src/providers/prayer_time_provider.dart';
import 'package:taukeet/src/app.dart';
import 'package:taukeet/src/utils/locale_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String prayerJsonStr = await rootBundle.loadString('assets/data/prayer.json');
  Map<String, dynamic> prayerData = json.decode(prayerJsonStr);

  await LocaleHelper.loadLocales();

  runApp(ProviderScope(
    overrides: [
      prayerDataProvider.overrideWithValue(prayerData),
    ],
    child: App(),
  ));
}
