import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taukeet/main.dart';
import 'package:taukeet/src/entities/address.dart';
import 'package:taukeet/src/libraries/settings_library.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(SettingsState(
          address: getIt<SettingsLibrary>().getSettings().address,
          madhab: getIt<SettingsLibrary>().getSettings().madhab,
          calculationMethod:
              getIt<SettingsLibrary>().getSettings().calculationMethod,
          higherLatitude: getIt<SettingsLibrary>().getSettings().higherLatitude,
        ));

  void updateLocation(Address address) {
    emit(state.copyWith(address: address));
  }

  void updateMadhab(String madhab) {
    getIt<SettingsLibrary>().updateMadhab(madhab);
    emit(state.copyWith(madhab: madhab));
  }

  void updateCalculationMethod(String method) {
    getIt<SettingsLibrary>().updateCalculationMethod(method);
    emit(state.copyWith(calculationMethod: method));
  }

  void updateHigherLatitude(String value) {
    getIt<SettingsLibrary>().updateHigherLatitude(value);
    emit(state.copyWith(higherLatitude: value));
  }
}
