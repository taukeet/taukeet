import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taukeet/features/prayer_times/domain/entities/prayer_time.dart';
import 'package:taukeet/src/providers/prayer_time_provider.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier(ref);
});

class HomeState {
  final List<PrayerTime> prayers;
  final PrayerTime? currentPrayer;
  final DateTime dateTime;

  HomeState({
    this.prayers = const [],
    this.currentPrayer,
    required this.dateTime,
  });

  HomeState copyWith({
    List<PrayerTime>? prayers,
    PrayerTime? currentPrayer,
    DateTime? dateTime,
  }) {
    return HomeState(
      prayers: prayers ?? this.prayers,
      currentPrayer: currentPrayer ?? this.currentPrayer,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}

class HomeNotifier extends StateNotifier<HomeState> {
  final Ref ref;

  HomeNotifier(this.ref) : super(HomeState(dateTime: DateTime.now())) {
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