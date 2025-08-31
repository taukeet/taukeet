import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taukeet/features/prayer_times/domain/entities/prayer_time.dart';
import 'package:taukeet/src/providers/prayer_time_provider.dart';

final homepageProvider =
    StateNotifierProvider<HomePageNotifier, HomePageState>((ref) {
  return HomePageNotifier(ref);
});

class HomePageState {
  final List<PrayerTime> prayers;
  final PrayerTime? currentPrayer;
  final DateTime dateTime;

  HomePageState({
    this.prayers = const [],
    this.currentPrayer,
    required this.dateTime,
  });

  HomePageState copyWith({
    List<PrayerTime>? prayers,
    PrayerTime? currentPrayer,
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

  HomePageNotifier(this.ref) : super(HomePageState(dateTime: DateTime.now())) {
    // Watch prayer providers instead of listening manually
    _updatePrayers();
  }

  void _updatePrayers() {
    final prayers = ref.watch(prayerTimesProvider(state.dateTime));
    final currentPrayer = ref.watch(currentPrayerProvider(state.dateTime));

    state = state.copyWith(
      prayers: prayers,
      currentPrayer: currentPrayer,
    );
  }

  void calculatePrayers() {
    _updatePrayers();
  }

  void changeToPrevDate() {
    state = state.copyWith(
      dateTime: state.dateTime.subtract(const Duration(days: 1)),
    );
    _updatePrayers();
  }

  void changeToNextDate() {
    state = state.copyWith(
      dateTime: state.dateTime.add(const Duration(days: 1)),
    );
    _updatePrayers();
  }

  void changeToToday() {
    state = state.copyWith(dateTime: DateTime.now());
    _updatePrayers();
  }
}
