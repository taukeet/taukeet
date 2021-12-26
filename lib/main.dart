import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taukeet/bloc/timer_bloc.dart';
import 'package:taukeet/contracts/location_service.dart';
import 'package:taukeet/contracts/prayer_service.dart';
import 'package:taukeet/contracts/storage_service.dart';
import 'package:taukeet/cubit/prayer_cubit.dart';
import 'package:taukeet/cubit/settings_cubit.dart';
import 'package:taukeet/home.dart';
import 'package:taukeet/intro.dart';
import 'package:taukeet/service_locator.dart';
import 'package:taukeet/ticker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final StorageService storageService = getIt<StorageService>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsCubit>(
          create: (context) => SettingsCubit(
            prayerService: getIt<PrayerService>(),
            locationService: getIt<LocationService>(),
            storageService: getIt<StorageService>(),
          )..initialize(),
        ),
        BlocProvider<TimerBloc>(
          create: (context) => TimerBloc(
              ticker: const Ticker(), prayerService: getIt<PrayerService>())
            ..add(const TimerStarted()),
        ),
        BlocProvider<PrayerCubit>(
          create: (context) => PrayerCubit(
            prayerService: getIt<PrayerService>(),
            settingsCubit: BlocProvider.of<SettingsCubit>(context),
          )..initialize(),
        ),
      ],
      child: MaterialApp(
        title: "Taukeet",
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: storageService.getString("madhab") != null &&
                storageService.getString("calculationMethod") != null &&
                storageService.getDouble("latitude") != null &&
                storageService.getDouble("longitude") != null
            ? Home()
            : const Intro(),
      ),
    );
  }
}
