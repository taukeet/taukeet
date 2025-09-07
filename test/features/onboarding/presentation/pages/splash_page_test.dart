import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:taukeet/features/onboarding/presentation/pages/splash_page.dart';
import 'package:taukeet/features/settings/domain/entities/settings.dart';
import 'package:taukeet/features/settings/presentation/providers/settings_provider.dart';
import 'package:taukeet/generated/l10n.dart';

import '../../../../helpers/test_helpers.dart';

void main() {
  group('SplashPage', () {
    late GoRouter goRouter;

    Widget createWidgetUnderTest(
        {required AsyncValue<Settings> settings,
        Duration splashDelay = Duration.zero}) {
      return ProviderScope(
        overrides: [
          settingsFutureProvider.overrideWith((ref) {
            if (settings.isLoading) {
              return Completer<Settings>().future;
            }
            if (settings.hasError) {
              return Future.error(settings.error!);
            }
            return Future.value(settings.value);
          }),
        ],
        child: MaterialApp.router(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.supportedLocales,
          routerConfig: goRouter = GoRouter(
            initialLocation: '/',
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => SplashPage(
                  splashDelay: splashDelay,
                ),
              ),
              GoRoute(
                path: '/intro',
                name: 'intro',
                builder: (context, state) => const Scaffold(
                  body: Text('Intro Page'),
                ),
              ),
              GoRoute(
                path: '/home',
                name: 'home',
                builder: (context, state) => const Scaffold(
                  body: Text('Home Page'),
                ),
              ),
            ],
          ),
        ),
      );
    }

    setUp(() async {
      await S.delegate.load(const Locale('en'));
    });

    testWidgets('should show loading indicator when settings are loading',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        settings: const AsyncValue.loading(),
      ));

      expect(find.byKey(const Key('splash_loading')), findsOneWidget);
    });

    testWidgets('should show error message when settings fail to load',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        settings: AsyncValue.error('error', StackTrace.current),
      ));

      await tester.pumpAndSettle();

      expect(find.byKey(const Key('splash_error')), findsOneWidget);
    });

    testWidgets('should navigate to intro page when tutorial is not completed',
        (WidgetTester tester) async {
      final settings = Settings.fromMap(
        TestUtils.createTestSettingsJson(isTutorialCompleted: false),
      );

      await tester.pumpWidget(createWidgetUnderTest(
        settings: AsyncValue.data(settings),
      ));

      await tester.pumpAndSettle();

      expect(goRouter.routeInformationProvider.value.uri.toString(), '/intro');
    });

    testWidgets('should navigate to home page when tutorial is completed',
        (WidgetTester tester) async {
      final settings = Settings.fromMap(
        TestUtils.createTestSettingsJson(isTutorialCompleted: true),
      );

      await tester.pumpWidget(createWidgetUnderTest(
        settings: AsyncValue.data(settings),
      ));

      await tester.pumpAndSettle();

      expect(goRouter.routeInformationProvider.value.uri.toString(), '/home');
    });

    testWidgets('should show splash content with fade-in animation',
        (WidgetTester tester) async {
      final settings = Settings.fromMap(
        TestUtils.createTestSettingsJson(),
      );

      await tester.pumpWidget(createWidgetUnderTest(
        settings: AsyncValue.data(settings),
        splashDelay: const Duration(milliseconds: 500),
      ));

      // At the beginning of the animation
      await tester.pump();
      Opacity opacity = tester.widget(find.byType(Opacity));
      expect(opacity.opacity, closeTo(0.0, 0.001));

      // After the animation is complete
      await tester.pump(const Duration(milliseconds: 500));
      opacity = tester.widget(find.byType(Opacity));
      expect(opacity.opacity, closeTo(1.0, 0.001));

      expect(find.byKey(const Key('splash_icon')), findsOneWidget);
      expect(find.byKey(const Key('splash_title')), findsOneWidget);
    });
  });
}
