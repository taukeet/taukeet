import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:taukeet/main.dart';
import 'package:taukeet/src/entities/address.dart';
import 'package:taukeet/src/services/geo_location_service.dart';

part 'settings_state.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  Future<void> fetchLocation() async {
    emit(state.copyWith(isFetchingLocation: true));

    Address address = await getIt<GeoLocationService>().fetch();

    emit(state.copyWith(isFetchingLocation: false, address: address));
  }

  void updateMadhab(String madhab) {
    emit(state.copyWith(madhab: madhab));
  }

  void updateCalculationMethod(String method) {
    emit(state.copyWith(calculationMethod: method));
  }

  void updateHigherLatitude(String value) {
    emit(state.copyWith(higherLatitude: value));
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    return SettingsState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    return state.toMap();
  }
}
