part of 'prayer_cubit.dart';

class PrayerState extends Equatable {
  const PrayerState({
    this.prayerTimes = const [],
    this.nextPrayer,
    this.currentPrayer,
  });

  final List<PrayerTime> prayerTimes;
  final PrayerTime? currentPrayer;
  final PrayerTime? nextPrayer;

  PrayerState copyWith({
    List<PrayerTime>? prayerTimes,
    PrayerTime? nextPrayer,
    PrayerTime? currentPrayer,
  }) {
    return PrayerState(
      prayerTimes: prayerTimes ?? this.prayerTimes,
      nextPrayer: nextPrayer ?? this.nextPrayer,
      currentPrayer: currentPrayer ?? this.currentPrayer,
    );
  }

  @override
  List<Object> get props => [];
}
