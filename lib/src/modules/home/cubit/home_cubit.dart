import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(dateTime: DateTime.now()));

  void changeToToday() {
    emit(state.copyWith(dateTime: DateTime.now()));
  }

  void changeToPrevDate() {
    emit(state.copyWith(
      dateTime: state.dateTime.subtract(const Duration(days: 1)),
    ));
  }

  void changeToNextDate() {
    emit(state.copyWith(
      dateTime: state.dateTime.add(const Duration(days: 1)),
    ));
  }
}
