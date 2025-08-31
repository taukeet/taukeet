import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taukeet/features/prayer_times/domain/entities/prayer_time.dart';
import 'package:taukeet/features/prayer_times/presentation/providers/prayer_times_provider.dart';

final homepageProvider =
    StateNotifierProvider<HomePageNotifier, HomePageState>((ref) {
  return HomePageNotifier(ref);
});

class HomePageState {
  final AsyncValue<List<PrayerTime>> prayers;
  final AsyncValue<PrayerTime?> currentPrayer;
  final DateTime dateTime;

  HomePageState({
    this.prayers = const AsyncValue.loading(),
    this.currentPrayer = const AsyncValue.loading(),
    required this.dateTime,
  });

  HomePageState copyWith({
    AsyncValue<List<PrayerTime>>? prayers,
    AsyncValue<PrayerTime?>? currentPrayer,
    DateTime? dateTime,
  }) {
    return HomePageState(
      prayers: prayers ?? this.prayers,
      currentPrayer: currentPrayer ?? this.currentPrayer,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}

class HomePageNotifier extends StateNotifier<HomePageState> {
  final Ref ref;
  late final void Function() _settingsListener;

  HomePageNotifier(this.ref) : super(HomePageState(dateTime: DateTime.now())) {
    // Listen to settings changes
    // _settingsListener =
    //     ref.listen<SettingsState>(settingsProvider, (prev, next) {
    //   _updatePrayers(); // Re-fetch prayers whenever settings change
    // });

    _updatePrayers();
  }

  Future<void> _updatePrayers() async {
    // Set loading state
    state = state.copyWith(
      prayers: const AsyncValue.loading(),
      currentPrayer: const AsyncValue.loading(),
    );

    try {
      // Fetch the prayers and current prayer
      final prayersResult =
          await ref.read(prayerTimesProvider(state.dateTime).future);
      final currentPrayerResult =
          await ref.read(currentPrayerProvider(state.dateTime).future);

      // Update state with data
      state = state.copyWith(
        prayers: AsyncValue.data(prayersResult),
        currentPrayer: AsyncValue.data(currentPrayerResult),
      );
    } catch (e, st) {
      state = state.copyWith(
        prayers: AsyncValue.error(e, st),
        currentPrayer: AsyncValue.error(e, st),
      );
    }
  }

  void calculatePrayers() => _updatePrayers();

  void changeToPrevDate() {
    state = state.copyWith(
        dateTime: state.dateTime.subtract(const Duration(days: 1)));
    _updatePrayers();
  }

  void changeToNextDate() {
    state =
        state.copyWith(dateTime: state.dateTime.add(const Duration(days: 1)));
    _updatePrayers();
  }

  void changeToToday() {
    state = state.copyWith(dateTime: DateTime.now());
    _updatePrayers();
  }

  @override
  void dispose() {
    _settingsListener(); // Remove listener when disposed
    super.dispose();
  }
}
