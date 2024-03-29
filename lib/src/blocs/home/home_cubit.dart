import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taukeet/main.dart';
import 'package:taukeet/src/entities/prayer_time.dart';
import 'package:taukeet/src/services/prayer_time_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(dateTime: DateTime.now()));

  void calculatePrayers() {
    emit(state.copyWith(
      prayers: getIt<PrayerTimeService>().prayers(state.dateTime),
      currentPrayer: getIt<PrayerTimeService>().currentPrayer(),
    ));
  }

  void changeToToday() {
    emit(state.copyWith(
      dateTime: DateTime.now(),
      prayers: getIt<PrayerTimeService>().prayers(DateTime.now()),
    ));
  }

  void changeToPrevDate() {
    DateTime dateTime = state.dateTime.subtract(const Duration(days: 1));
    emit(state.copyWith(
      dateTime: dateTime,
      prayers: getIt<PrayerTimeService>().prayers(dateTime),
    ));
  }

  void changeToNextDate() {
    DateTime dateTime = state.dateTime.add(const Duration(days: 1));
    emit(state.copyWith(
      dateTime: dateTime,
      prayers: getIt<PrayerTimeService>().prayers(dateTime),
    ));
  }
}
