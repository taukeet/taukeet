import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taukeet/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:taukeet/features/onboarding/presentation/providers/onboarding_page_provider.dart';
import 'package:taukeet/features/settings/presentation/providers/settings_provider.dart';
import 'package:taukeet/generated/l10n.dart';

import '../../../../helpers/test_helpers.dart';

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  group('OnboardingPage', () {
    late MockGoRouter goRouter;
    late S strings;

    setUp(() async {
      goRouter = MockGoRouter();
      strings = await S.delegate.load(const Locale('en'));
    });

    Widget createWidgetUnderTest() {
      return ProviderScope(
        overrides: [
          settingsProvider,
          onboardingPageProvider,
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.supportedLocales,
          home: InheritedGoRouter(
            goRouter: goRouter,
            child: const OnboardingPage(),
          ),
        ),
      );
    }

    testWidgets('should show the first slide initially',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(SplashContainer), findsOneWidget);
      expect(find.text(strings.chooseLanguage), findsOneWidget);
    });
  });
}
