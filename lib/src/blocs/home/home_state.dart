part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.dateTime,
    this.prayers = const [],
    this.currentPrayer,
  });

  final DateTime dateTime;
  final List<PrayerTime> prayers;
  final PrayerTime? currentPrayer;

  HomeState copyWith({
    DateTime? dateTime,
    List<PrayerTime>? prayers,
    PrayerTime? currentPrayer,
  }) {
    return HomeState(
      dateTime: dateTime ?? this.dateTime,
      prayers: prayers ?? this.prayers,
      currentPrayer: currentPrayer ?? this.currentPrayer,
    );
  }

  @override
  List<Object?> get props => [dateTime, prayers, currentPrayer];
}
