import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taukeet/src/blocs/settings/settings_cubit.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({
    required this.settingsCubit,
  }) : super(SplashState(
          showNextButton: settingsCubit.state.address.address.isNotEmpty,
        ));

  Future<void> fetchLocation() async {
    bool result = await settingsCubit.fetchLocation();

    if (result) {
      emit(state.copyWith(
        showNextButton: true,
      ));
    }
  }

  SettingsCubit settingsCubit;
}
