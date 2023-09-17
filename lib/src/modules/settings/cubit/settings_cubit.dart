import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taukeet/src/entities/address.dart';
import 'package:taukeet/src/libraries/settings_library.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(SettingsState(
          address: SettingsLibrary.getSettings().address,
          madhab: SettingsLibrary.getSettings().madhab,
        ));

  void updateLocation(Address address) {
    emit(state.copyWith(address: address));
  }

  void updateMadhab(String madhab) {
    SettingsLibrary.updateMadhab(madhab);
    emit(state.copyWith(madhab: madhab));
  }
}
