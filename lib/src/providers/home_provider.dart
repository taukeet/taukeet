import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taukeet/main.dart';
import 'package:taukeet/src/entities/prayer_time.dart';
import 'package:taukeet/src/providers/settings_provider.dart';
import 'package:taukeet/src/services/prayer_time_service.dart';

// Provider
final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier(ref);
});

// State
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

// Notifier
class HomeNotifier extends StateNotifier<HomeState> {
  final Ref ref;

  HomeNotifier(this.ref) : super(HomeState(dateTime: DateTime.now())) {
    calculatePrayers();
  }

  void calculatePrayers() {
    final settings = ref.read(settingsProvider);
    final prayerService = getIt<PrayerTimeService>();
    
    prayerService.init(
      settings.address,
      settings.adjustments,
      settings.calculationMethod,
      settings.madhab,
      settings.higherLatitude,
    );

    final prayers = prayerService.prayers(state.dateTime);
    final currentPrayer = prayerService.currentPrayer();

    state = state.copyWith(
      prayers: prayers,
      currentPrayer: currentPrayer,
    );
  }

  void changeToPrevDate() {
    state = state.copyWith(
      dateTime: state.dateTime.subtract(const Duration(days: 1)),
    );

    calculatePrayers();
  }

  void changeToNextDate() {
    state = state.copyWith(
      dateTime: state.dateTime.add(const Duration(days: 1)),
    );

    calculatePrayers();
  }

  void changeToToday() {
    state = state.copyWith(dateTime: DateTime.now());
    
    calculatePrayers();
  }
}