import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taukeet/src/providers/settings_provider.dart'; // We'll create this next

// Provider
final introProvider = StateNotifierProvider<IntroNotifier, IntroState>((ref) {
  return IntroNotifier(ref);
});

// State
class IntroState {
  final bool showNextButton;

  IntroState({this.showNextButton = false});

  IntroState copyWith({bool? showNextButton}) {
    return IntroState(
      showNextButton: showNextButton ?? this.showNextButton,
    );
  }
}

// Notifier
class IntroNotifier extends StateNotifier<IntroState> {
  final Ref ref;

  IntroNotifier(this.ref)
      : super(IntroState(
          showNextButton:
              ref.read(settingsProvider).address.address.isNotEmpty,
        ));

  Future<bool> fetchLocation() async {
    // Call fetchLocation from settingsProvider
    final result = await ref.read(settingsProvider.notifier).fetchLocation();
    if (result) {
      state = state.copyWith(showNextButton: true);
    }

    return result;
  }
}