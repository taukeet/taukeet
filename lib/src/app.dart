import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taukeet/main.dart';
import 'package:taukeet/src/blocs/home/home_cubit.dart';
import 'package:taukeet/src/blocs/settings/settings_cubit.dart';
import 'package:taukeet/src/blocs/splash/splash_cubit.dart';
import 'package:taukeet/src/screens/splash_screen.dart';
import 'package:taukeet/src/services/prayer_time_service.dart';
import 'package:taukeet/src/views/adjustments_view.dart';
import 'package:taukeet/src/views/home_view.dart';
import 'package:taukeet/src/views/settings_view.dart';
import 'package:taukeet/src/views/splash_view.dart';

final _router = GoRouter(
  redirect: (context, state) {
    return null;
  },
  routes: [
    GoRoute(
      name: 'root',
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    // GoRoute(
    //   name: 'home',
    //   path: '/',
    //   redirect: (context, state) {
    //     if (!BlocProvider.of<SettingsCubit>(context)
    //         .state
    //         .isTutorialCompleted) {
    //       return '/splash';
    //     }
    //     return null;
    //   },
    //   builder: (context, state) => const HomeView(),
    // ),
    GoRoute(
      name: 'splash',
      path: '/splash',
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      name: 'settings',
      path: '/settings',
      builder: (context, state) => const SettingsView(),
      routes: [
        GoRoute(
          name: 'settings.adjustments',
          path: 'adjustments',
          builder: (context, state) => const AdjustmentsView(),
        )
      ],
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
        ),
        BlocProvider(
          create: (context) => SplashCubit(
            settingsCubit: BlocProvider.of<SettingsCubit>(context),
          ),
        ),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          getIt<PrayerTimeService>().init(
            state.address,
            state.adjustments,
            state.calculationMethod,
            state.madhab,
            state.higherLatitude,
          );
          BlocProvider.of<HomeCubit>(context).calculatePrayers();

          return MaterialApp.router(
            theme: ThemeData(
              appBarTheme: Theme.of(context).appBarTheme.copyWith(
                    backgroundColor: const Color(0xFFF0E7D8),
                  ),
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: const Color(0xFF191923),
                secondary: const Color(0xFFF0E7D8),
              ),
            ),
            routerConfig: _router,
          );
        },
      ),
    );
  }
}
