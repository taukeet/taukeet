import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taukeet/main.dart';
import 'package:taukeet/src/blocs/home/home_cubit.dart';
import 'package:taukeet/src/blocs/settings/settings_cubit.dart';
import 'package:taukeet/src/services/prayer_time_service.dart';
import 'package:taukeet/src/views/home_view.dart';
import 'package:taukeet/src/views/settings_view.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      name: 'settings',
      path: '/settings',
      builder: (context, state) => const SettingsView(),
    ),
  ],
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SettingsCubit(),
        ),
        BlocProvider(
          create: (context) => HomeCubit(),
        )
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          getIt<PrayerTimeService>().init(
            state.address,
            state.calculationMethod,
            state.madhab,
            state.higherLatitude,
          );
          BlocProvider.of<HomeCubit>(context).calculatePrayers();

          return MaterialApp.router(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: const Color(0xFFF0E7D8),
                secondary: const Color(0xFF191923),
              ),
            ),
            routerConfig: _router,
          );
        },
      ),
    );
  }
}
