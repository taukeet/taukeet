import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taukeet/features/prayer_times/data/repositories/prayer_repository_impl.dart';
import 'package:taukeet/features/prayer_times/domain/usecases/get_current_prayer.dart';
import 'package:taukeet/features/prayer_times/domain/usecases/get_prayer_times.dart';
import 'package:taukeet/features/prayer_times/presentation/providers/prayer_times_provider.dart';
import 'package:taukeet/src/providers/prayer_time_provider.dart'
    as presentation_providers;
import 'package:taukeet/src/app.dart';
import 'package:taukeet/shared/l10n/locale_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String prayerJsonStr = await rootBundle.loadString('assets/data/prayer.json');
  Map<String, dynamic> prayerData = json.decode(prayerJsonStr);

  await LocaleHelper.loadLocales();

  final prayerRepo = PrayerRepositoryImpl(data: prayerData);
  final getPrayerTimesUseCase = GetPrayerTimes(prayerRepo);
  final getCurrentPrayerUseCase = GetCurrentPrayer(prayerRepo);

  runApp(ProviderScope(
    overrides: [
      presentation_providers.prayerDataProvider.overrideWithValue(prayerData),
      getPrayerTimesUseCaseProvider.overrideWithValue(getPrayerTimesUseCase),
      getCurrentPrayerUseCaseProvider
          .overrideWithValue(getCurrentPrayerUseCase),
    ],
    child: App(),
  ));
}
