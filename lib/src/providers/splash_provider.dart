import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taukeet/src/providers/settings_provider.dart'; // We'll create this next

// Provider
final splashProvider = StateNotifierProvider<SplashNotifier, SplashState>((ref) {
  return SplashNotifier(ref);
});

// State
class SplashState {
  final bool showNextButton;

  SplashState({this.showNextButton = false});

  SplashState copyWith({bool? showNextButton}) {
    return SplashState(
      showNextButton: showNextButton ?? this.showNextButton,
    );
  }
}

// Notifier
class SplashNotifier extends StateNotifier<SplashState> {
  final Ref ref;

  SplashNotifier(this.ref)
      : super(SplashState(
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