part of 'prayer_cubit.dart';

class PrayerState extends Equatable {
  const PrayerState({
    this.prayerTimes = const [],
    this.currentPrayer,
  });

  final List<PrayerTime> prayerTimes;
  final PrayerTime? currentPrayer;

  PrayerState copyWith({
    List<PrayerTime>? prayerTimes,
    PrayerTime? currentPrayer,
  }) {
    return PrayerState(
      prayerTimes: prayerTimes ?? this.prayerTimes,
      currentPrayer: currentPrayer ?? this.currentPrayer,
    );
  }

  @override
  List<Object> get props => [];
}
