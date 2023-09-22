import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taukeet/src/interfaces/geo_location.dart';
import 'package:taukeet/main.dart';
import 'package:taukeet/src/blocs/settings/settings_cubit.dart';
import 'package:taukeet/src/entities/address.dart';
import 'package:taukeet/src/libraries/settings_library.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit({required this.settingsCubit})
      : super(LocationState(
          isFetchingLocation: false,
          address: getIt<SettingsLibrary>().getSettings().address,
        ));

  final SettingsCubit settingsCubit;

  Future<void> fetchLocation() async {
    // emit location is fetching state
    emit(state.copyWith(isFetchingLocation: true));

    Address address = await getIt<GeoLocation>().fetch();
    await getIt<SettingsLibrary>().updateAddress(address);

    emit(state.copyWith(isFetchingLocation: false, address: address));
    settingsCubit.updateLocation(address);
  }
}
