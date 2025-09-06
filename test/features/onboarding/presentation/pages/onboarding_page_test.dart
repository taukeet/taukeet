import 'package:carousel_slider/carousel_slider.dart';
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
import 'package:taukeet/shared/widgets/primary_button.dart';
import 'package:taukeet/features/settings/domain/entities/settings.dart';

import '../../../../helpers/test_helpers.dart';

class MockGoRouter extends Mock implements GoRouter {}

class MockOnboardingPageNotifier extends StateNotifier<OnboardingPageState> with Mock implements OnboardingPageNotifier {
  MockOnboardingPageNotifier(super.state);

  final CarouselController carouselController = CarouselController();

  @override
  Future<bool> fetchLocation() async {
    return true;
  }

  @override
  void updateCurrentSlide(int index) {
    state = state.copyWith(currentSlide: index);
  }
}

class MockSettingsNotifier extends StateNotifier<SettingsState> with Mock implements SettingsNotifier {
  MockSettingsNotifier(super.state);
}

void main() {
  group('OnboardingPage', () {
    late MockGoRouter goRouter;
    late S strings;
    late MockOnboardingPageNotifier onboardingPageNotifier;
    late MockSettingsNotifier settingsNotifier;

    setUp(() async {
      goRouter = MockGoRouter();
      strings = await S.delegate.load(const Locale('en'));
      onboardingPageNotifier = MockOnboardingPageNotifier(OnboardingPageState());
      settingsNotifier = MockSettingsNotifier(SettingsState(settings: Settings()));
    });

    Widget createWidgetUnderTest() {
      return ProviderScope(
        overrides: [
          settingsProvider.overrideWith((ref) => settingsNotifier),
          onboardingPageProvider.overrideWith((ref) => onboardingPageNotifier),
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

    testWidgets('should show the first slide initially', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(SplashContainer), findsOneWidget);
      expect(find.text(strings.chooseLanguage), findsOneWidget);
    });

    testWidgets('should have the next button disabled initially', (WidgetTester tester) async {
      onboardingPageNotifier.state = OnboardingPageState(showNextButton: false);

      await tester.pumpWidget(createWidgetUnderTest());

      final nextButton = find.widgetWithText(PrimaryButton, strings.next);
      expect(tester.widget<PrimaryButton>(nextButton).onPressed, isNull);
    });

    testWidgets('should enable the next button when a language is selected', (WidgetTester tester) async {
      onboardingPageNotifier.state = OnboardingPageState(showNextButton: true);

      await tester.pumpWidget(createWidgetUnderTest());

      final nextButton = find.widgetWithText(PrimaryButton, strings.next);
      expect(tester.widget<PrimaryButton>(nextButton).onPressed, isNotNull);
    });

    testWidgets('should navigate to the next slide when the next button is tapped', (WidgetTester tester) async {
      onboardingPageNotifier.state = OnboardingPageState(showNextButton: true);

      await tester.pumpWidget(createWidgetUnderTest());

      final nextButton = find.widgetWithText(PrimaryButton, strings.next);
      await tester.tap(nextButton);
      await tester.pumpAndSettle();

      expect(onboardingPageNotifier.state.currentSlide, 1);
    });
  });
}
