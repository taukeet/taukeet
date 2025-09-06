import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taukeet/features/settings/presentation/providers/locale_provider.dart';
import 'package:taukeet/features/settings/presentation/providers/settings_provider.dart';

// Provider
final onboardingPageProvider =
    StateNotifierProvider<OnboardingPageNotifier, OnboardingPageState>((ref) {
  return OnboardingPageNotifier(ref);
});

// State
class OnboardingPageState {
  final bool showNextButton;
  final int currentSlide;

  OnboardingPageState({
    this.showNextButton = true, // Start with true for language slide
    this.currentSlide = 0,
  });

  OnboardingPageState copyWith({
    bool? showNextButton,
    int? currentSlide,
  }) {
    return OnboardingPageState(
      showNextButton: showNextButton ?? this.showNextButton,
      currentSlide: currentSlide ?? this.currentSlide,
    );
  }
}

// Notifier
class OnboardingPageNotifier extends StateNotifier<OnboardingPageState> {
  final Ref ref;

  OnboardingPageNotifier(this.ref) : super(OnboardingPageState()) {
    // Listen to settings changes to update button state
    ref.listen(settingsProvider, (previous, next) {
      _updateButtonState();
    });
  }

  void updateCurrentSlide(int index) {
    state = state.copyWith(currentSlide: index);
    _updateButtonState();
  }

  void _updateButtonState() {
    bool shouldShowNext = true;

    switch (state.currentSlide) {
      case 0: // Language slide - always enabled
        shouldShowNext = true;
        break;
      case 1: // Location slide - enabled only if address is selected
      case 2: // Madhab slide - enabled only if address is selected
      case 3: // Calculation method slide - enabled only if address is selected
        shouldShowNext =
            ref.read(settingsProvider).settings.hasFetchedInitialLocation;
        break;
      default:
        shouldShowNext = true;
    }

    if (state.showNextButton != shouldShowNext) {
      state = state.copyWith(showNextButton: shouldShowNext);
    }
  }

  Future<bool> fetchLocation() async {
    // Call fetchLocation from settingsProvider
    final result = await ref
        .read(settingsProvider.notifier)
        .fetchLocation(ref.read(localeProvider).locale.languageCode);

    // Update button state after location fetch
    _updateButtonState();

    return result;
  }
}
