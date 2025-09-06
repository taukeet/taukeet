import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:taukeet/core/di/injection.dart';
import 'package:taukeet/features/location/domain/repositories/location_repository.dart';
import 'package:taukeet/features/location/domain/usecases/get_address_from_coordinates.dart';
import 'package:taukeet/features/location/domain/usecases/get_current_location.dart';
import 'package:taukeet/features/prayer_times/data/repositories/prayer_repository_impl.dart';
import 'package:taukeet/features/prayer_times/domain/usecases/get_calculation_methods.dart';
import 'package:taukeet/features/prayer_times/domain/usecases/get_current_prayer.dart';
import 'package:taukeet/features/prayer_times/domain/usecases/get_higher_latitudes.dart';
import 'package:taukeet/features/prayer_times/domain/usecases/get_prayer_times.dart';
import 'package:taukeet/features/prayer_times/presentation/providers/prayer_times_provider.dart';
import 'package:taukeet/features/settings/domain/repositories/settings_repository.dart';
import 'package:taukeet/features/settings/domain/usecases/get_settings.dart';
import 'package:taukeet/features/settings/domain/usecases/update_settings.dart';
import 'package:taukeet/features/settings/domain/usecases/reset_settings.dart';
import 'package:taukeet/features/settings/presentation/providers/settings_provider.dart';
import 'package:taukeet/app/app.dart';
import 'package:taukeet/shared/l10n/locale_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String prayerJsonStr = await rootBundle.loadString('assets/data/prayer.json');
  Map<String, dynamic> prayerData = json.decode(prayerJsonStr);

  await configureDependencies();

  await LocaleHelper.loadLocales();

  final prayerRepo = PrayerRepositoryImpl(data: prayerData);
  final getPrayerTimesUseCase = GetPrayerTimes(prayerRepo);
  final getCurrentPrayerUseCase = GetCurrentPrayer(prayerRepo);
  final getCalculationMethodsUseCase = GetCalculationMethods(prayerRepo);
  final getHigherLatitudesUseCase = GetHigherLatitudes(prayerRepo);

  final settingsRepo = GetIt.instance<SettingsRepository>();
  final getSettingsUseCase = GetSettings(settingsRepo);
  final updateSettingsUseCase = UpdateSettings(settingsRepo);
  final resetSettingsUseCase = ResetSettings(settingsRepo);

  final locationRepo = GetIt.instance<LocationRepository>();
  final getCurrentLocationUseCase = GetCurrentLocation(locationRepo);
  final getAddressFromCoordinatesUseCase =
      GetAddressFromCoordinates(locationRepo);

  runApp(ProviderScope(
    overrides: [
      prayerDataProvider.overrideWithValue(prayerData),
      getPrayerTimesUseCaseProvider.overrideWithValue(getPrayerTimesUseCase),
      getCurrentPrayerUseCaseProvider
          .overrideWithValue(getCurrentPrayerUseCase),
      getCalculationMethodsUseCaseProvider
          .overrideWithValue(getCalculationMethodsUseCase),
      getHigherLatitudesUseCaseProvider
          .overrideWithValue(getHigherLatitudesUseCase),
      getSettingsUseCaseProvider.overrideWithValue(getSettingsUseCase),
      updateSettingsUseCaseProvider.overrideWithValue(updateSettingsUseCase),
      resetSettingsUseCaseProvider.overrideWithValue(resetSettingsUseCase),
      getCurrentLocationUseCaseProvider
          .overrideWithValue(getCurrentLocationUseCase),
      getAddressFromCoordinatesUseCaseProvider
          .overrideWithValue(getAddressFromCoordinatesUseCase),
    ],
    child: App(),
  ));
}
