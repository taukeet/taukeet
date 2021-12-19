import 'package:adhan/adhan.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taukeet/contracts/prayer_service.dart';

part 'intro_state.dart';

class IntroCubit extends Cubit<IntroState> {
  IntroCubit({
    required PrayerService prayerService,
  })  : _prayerService = prayerService,
        super(const IntroState());

  final PrayerService _prayerService;

  void initialize() {
    emit(
      state.copyWith(
        calculationMethods: _prayerService.calculationMethods,
      ),
    );
  }

  void changeCalculationMethod(String method) => emit(
        state.copyWith(
          calculationMethod: method,
        ),
      );

  void changeMadhab(String madhab) => emit(
        state.copyWith(
          madhab: madhab,
        ),
      );
}
