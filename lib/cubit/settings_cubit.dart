import 'package:adhan/adhan.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taukeet/contracts/location_service.dart';
import 'package:taukeet/contracts/prayer_service.dart';
import 'package:taukeet/contracts/storage_service.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({
    required PrayerService prayerService,
    required LocationService locationService,
    required StorageService storageService,
  })  : _prayerService = prayerService,
        _locationService = locationService,
        _storageService = storageService,
        super(const SettingsState());

  final PrayerService _prayerService;
  final LocationService _locationService;
  final StorageService _storageService;

  void initialize() {
    emit(
      state.copyWith(
        calculationMethods: _prayerService.calculationMethods,
      ),
    );
  }

  void locateUser() async {
    emit(state.copyWith(
      isAddressFetching: true,
    ));

    final result = await _locationService.currentPosition();
    final placemark = await _locationService.positionAddress(
      result.latitude,
      result.longitude,
    );

    String address = placemark.administrativeArea ?? "";
    address =
        placemark.country != null ? address + ", " + placemark.country! : "";
    address = address != ""
        ? address
        : result.latitude.toString() + ", " + result.longitude.toString();

    emit(state.copyWith(
      isAddressFetching: false,
      isAddressFetched: true,
      address: address,
      latitude: result.latitude,
      longitude: result.longitude,
    ));
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

  void removeHasValidationError() => emit(
        state.copyWith(
          hasValidationError: false,
        ),
      );

  void saveSettingsData() async {
    if (state.latitude == 0 && state.longitude == 0) {
      emit(state.copyWith(
        hasValidationError: true,
      ));
      return;
    }

    emit(state.copyWith(
      isDataSaving: true,
    ));

    await _storageService.setString("madhab", state.madhab);
    await _storageService.setString(
        "calculationMethod", state.calculationMethod);
    await _storageService.setString("address", state.address);
    await _storageService.setDouble("latitude", state.latitude);
    await _storageService.setDouble("longitude", state.longitude);

    emit(state.copyWith(
      isDataSaving: false,
      isDataSaved: true,
    ));
  }
}
