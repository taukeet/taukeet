import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taukeet/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:taukeet/features/onboarding/presentation/pages/splash_page.dart';
import 'package:taukeet/features/prayer_times/presentation/pages/home_page.dart';
import 'package:taukeet/features/settings/presentation/pages/adjustments_page.dart';
import 'package:taukeet/features/settings/presentation/pages/settings_page.dart';
import 'package:taukeet/generated/l10n.dart';
import 'package:taukeet/features/settings/presentation/providers/locale_provider.dart';
import 'package:taukeet/app/scaffold_with_nested_navigation.dart';
import 'package:taukeet/features/qiblah/presentation/pages/qiblah_page.dart';

class AppColors {
  static const primary = Color(0xFF4A6CF7); // Blue highlight
  static const secondary = Color(0xFFF0E7D8); // Accent cream
  static const background = Color(0xFF1A1A1A); // Dark background
  static const surface = Color(0xFF2A2A2A); // Card/dark surface
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey =
    GlobalKey<NavigatorState>(debugLabel: 'homeShell');
final _shellNavigatorQiblahKey =
    GlobalKey<NavigatorState>(debugLabel: 'qiblahShell'); // New key
final _shellNavigatorSettingsKey =
    GlobalKey<NavigatorState>(debugLabel: 'settingsShell');

final _router = GoRouter(
  initialLocation: '/', // Changed to '/'
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      name: 'splash',
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      name: 'intro',
      path: '/intro',
      builder: (context, state) => const OnboardingPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            GoRoute(
              name: 'home',
              path: '/home',
              // Removed redirect from here
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorQiblahKey, // New branch
          routes: [
            GoRoute(
              name: 'qiblah',
              path: '/qiblah',
              builder: (context, state) => const QiblahPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorSettingsKey,
          routes: [
            GoRoute(
              name: 'settings',
              path: '/settings',
              builder: (context, state) => const SettingsPage(),
              routes: [
                GoRoute(
                  name: 'settings.adjustments',
                  path: 'adjustments',
                  builder: (context, state) => const AdjustmentsPage(),
                ),
              ],
            ),
          ],
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
          useMaterial3: true,
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            brightness: Brightness.dark,
          ).copyWith(
            surface: AppColors.surface,
            secondary: AppColors.secondary,
          ),
          scaffoldBackgroundColor: AppColors.background,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.surface,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            bodyMedium: TextStyle(fontSize: 14),
            bodySmall: TextStyle(fontSize: 12),
          ),
        ),
        routerConfig: _router,
        locale: localeState.locale,
        localizationsDelegates: const [
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
