import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taukeet/src/entities/address.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(
          const SettingsState(
            address: Address(),
          ),
        );

  void updateLocation(Address address) {
    emit(state.copyWith(address: address));
  }
}
