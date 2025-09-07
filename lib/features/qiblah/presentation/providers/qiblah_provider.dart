
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taukeet/core/errors/location_disabled_exception.dart';
import 'package:taukeet/core/errors/location_permission_denied.dart';
import 'package:taukeet/features/location/domain/entities/address.dart';
import 'package:taukeet/features/location/domain/usecases/get_current_location.dart';
import 'package:taukeet/features/settings/domain/usecases/get_settings.dart';
import 'package:taukeet/core/usecases/usecase.dart';
import 'package:taukeet/features/settings/presentation/providers/settings_provider.dart';

class QiblahState {
  final bool isFetchingLocation;
  final bool hasLocationPermission;
  final bool isLocationEnabled;
  final Address? address;

  QiblahState({
    this.isFetchingLocation = false,
    this.hasLocationPermission = true,
    this.isLocationEnabled = true,
    this.address,
  });

  QiblahState copyWith({
    bool? isFetchingLocation,
    bool? hasLocationPermission,
    bool? isLocationEnabled,
    Address? address,
  }) {
    return QiblahState(
      isFetchingLocation: isFetchingLocation ?? this.isFetchingLocation,
      hasLocationPermission: hasLocationPermission ?? this.hasLocationPermission,
      isLocationEnabled: isLocationEnabled ?? this.isLocationEnabled,
      address: address ?? this.address,
    );
  }
}

class QiblahNotifier extends StateNotifier<QiblahState> {
  final GetCurrentLocation _getCurrentLocation;
  final GetSettings _getSettings;

  QiblahNotifier(
    this._getCurrentLocation,
    this._getSettings,
  ) : super(QiblahState());

  Future<void> init() async {
    final settingsResult = await _getSettings(NoParams());
    settingsResult.fold(
      (failure) {
        // Handle error, maybe log it or set a default state
      },
      (settings) {
        state = state.copyWith(address: settings.address);
      },
    );
  }

  Future<bool> fetchLocation(String locale) async {
    state = state.copyWith(isFetchingLocation: true);
    final result = await _getCurrentLocation(GetCurrentLocationParams(locale: locale));
    return result.fold(
      (failure) {
        state = state.copyWith(isFetchingLocation: false);
        if (failure is LocationPermissionDenied) {
          state = state.copyWith(hasLocationPermission: false);
        } else if (failure is LocationDisabledException) {
          state = state.copyWith(isLocationEnabled: false);
        }
        return false;
      },
      (address) {
        state = state.copyWith(
          isFetchingLocation: false,
          hasLocationPermission: true,
          isLocationEnabled: true,
          address: address,
        );
        return true;
      },
    );
  }
}

final qiblahProvider = StateNotifierProvider<QiblahNotifier, QiblahState>((ref) {
  final getCurrentLocationUseCase = ref.read(getCurrentLocationUseCaseProvider);
  final getSettingsUseCase = ref.read(getSettingsUseCaseProvider);
  final notifier = QiblahNotifier(
    getCurrentLocationUseCase,
    getSettingsUseCase,
  );
  notifier.init(); // Call init here
  return notifier;
});
