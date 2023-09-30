import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:taukeet/main.dart';
import 'package:taukeet/src/entities/address.dart';
import 'package:taukeet/src/entities/adjustments.dart';
import 'package:taukeet/src/exceptions/location_disabled_exception.dart';
import 'package:taukeet/src/exceptions/location_permission_denied.dart';
import 'package:taukeet/src/services/geo_location_service.dart';

part 'settings_state.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  Future<void> completeTutorial() async {
    if (!state.hasFetchedInitialLocation) {
      await fetchLocation();
    }

    emit(state.copyWith(
      isTutorialCompleted: true,
      hasFetchedInitialLocation: true,
    ));
  }

  Future<void> fetchLocation() async {
    emit(
      state.copyWith(
        isFetchingLocation: true,
      ),
    );

    try {
      Address address = await getIt<GeoLocationService>().fetch();
      emit(state.copyWith(
        isFetchingLocation: false,
        address: address,
        isLocationEnabled: true,
        hasLocationPermission: true,
      ));
    } on LocationDisabledException {
      emit(state.copyWith(
        isLocationEnabled: false,
        isFetchingLocation: false,
        hasLocationPermission: true,
      ));
    } on LocationPermissionDenied {
      emit(state.copyWith(
        isLocationEnabled: true,
        isFetchingLocation: false,
        hasLocationPermission: false,
      ));
    } catch (e) {
      rethrow;
    }
  }

  void updateAdjustments({
    required int fajr,
    required int sunrise,
    required int dhuhr,
    required int asr,
    required int maghrib,
    required int isha,
  }) {
    emit(state.copyWith(
      adjustments: Adjustments(
        fajr: fajr,
        sunrise: sunrise,
        dhuhr: dhuhr,
        asr: asr,
        maghrib: maghrib,
        isha: isha,
      ),
    ));
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
