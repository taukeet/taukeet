import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taukeet/generated/l10n.dart';
import 'package:taukeet/src/providers/locale_provider.dart';
import 'package:taukeet/src/screens/home_screen.dart';
import 'package:taukeet/src/screens/home_screen_new.dart';
import 'package:taukeet/src/screens/intro_screen.dart';
import 'package:taukeet/src/screens/splash_screen.dart';
import 'package:taukeet/src/screens/settings_screen.dart';
import 'package:taukeet/src/screens/adjustments_screen.dart';
import 'package:taukeet/src/providers/settings_provider.dart';

final _router = GoRouter(
  redirect: (context, state) {
    return null;
  },
  routes: [
    GoRoute(
      name: 'splash',
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      name: 'intro',
      path: '/intro',
      builder: (context, state) => const IntroScreen(),
    ),
    GoRoute(
      name: 'home',
      path: '/home',
      redirect: (context, state) {
        final container = ProviderContainer(
          parent: ProviderScope.containerOf(context),
        );
        final isTutorialCompleted = container
            .read(settingsProvider.select((s) => s.isTutorialCompleted));

        if (!isTutorialCompleted) {
          return '/intro';
        }

        return null;
      },
      builder: (context, state) => const HomeScreenNew(),
    ),
    GoRoute(
      name: 'settings',
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
      routes: [
        GoRoute(
          name: 'settings.adjustments',
          path: 'adjustments',
          builder: (context, state) => const AdjustmentsScreen(),
        ),
      ],
    ),
  ],
);

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeState = ref.watch(localeProvider);

    return ProviderScope(
      child: MaterialApp.router(
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
        locale: localeState.locale,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.supportedLocales,
      ),
    );
  }
}
