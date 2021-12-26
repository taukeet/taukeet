import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taukeet/contracts/prayer_service.dart';
import 'package:taukeet/cubit/settings_cubit.dart';
import 'package:taukeet/services/adhan_prayer_service.dart';

part 'prayer_state.dart';

class PrayerCubit extends Cubit<PrayerState> {
  PrayerCubit({
    required PrayerService prayerService,
    required SettingsCubit settingsCubit,
  })  : _prayerService = prayerService,
        super(
          const PrayerState(),
        ) {
    settingsCubit.stream.listen((state) {
      if (state.isAddressFetching) {
        print("object");
      }
    });
  }

  final PrayerService _prayerService;

  void initialize() {
    emit(
      state.copyWith(
        nextPrayer: _prayerService.getNextPrayer(),
        prayerTimes: _prayerService.getPrayerTimes(),
        currentPrayer: _prayerService.getCurrentPrayer(),
      ),
    );
  }
}
