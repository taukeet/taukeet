import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taukeet/core/errors/location_disabled_exception.dart';
import 'package:taukeet/core/errors/location_permission_denied.dart';
import 'package:taukeet/features/location/domain/entities/address.dart';
import 'package:taukeet/features/location/domain/usecases/get_current_location.dart';
import 'package:taukeet/features/settings/domain/usecases/get_settings.dart';
import 'package:taukeet/core/usecases/usecase.dart';
import 'package:taukeet/features/qiblah/domain/usecases/get_qiblah_direction.dart';
import 'package:taukeet/features/settings/presentation/providers/settings_provider.dart';

class QiblahState {
  final bool isFetchingLocation;
  final bool hasLocationPermission;
  final bool isLocationEnabled;
  final Address? address;
  final double? qiblahDirection;

  QiblahState({
    this.isFetchingLocation = false,
    this.hasLocationPermission = true,
    this.isLocationEnabled = true,
    this.address,
    this.qiblahDirection,
  });

  QiblahState copyWith({
    bool? isFetchingLocation,
    bool? hasLocationPermission,
    bool? isLocationEnabled,
    Address? address,
    double? qiblahDirection,
  }) {
    return QiblahState(
      isFetchingLocation: isFetchingLocation ?? this.isFetchingLocation,
      hasLocationPermission:
          hasLocationPermission ?? this.hasLocationPermission,
      isLocationEnabled: isLocationEnabled ?? this.isLocationEnabled,
      address: address ?? this.address,
      qiblahDirection: qiblahDirection ?? this.qiblahDirection,
    );
  }
}

class QiblahNotifier extends StateNotifier<QiblahState> {
  final GetCurrentLocation _getCurrentLocation;
  final GetSettings _getSettings;
  final GetQiblahDirection _getQiblahDirection;

  QiblahNotifier(
    this._getCurrentLocation,
    this._getSettings,
    this._getQiblahDirection,
  ) : super(QiblahState());

  Future<void> init() async {
    final settingsResult = await _getSettings(NoParams());
    await settingsResult.fold(
      (failure) async {
        // Handle error if needed
      },
      (settings) async {
        final address = settings.address;
        if (address != null) {
          // Update address first
          state = state.copyWith(address: address);

          // Calculate Qiblah direction
          final qiblahResult =
              await _getQiblahDirection(GetQiblahDirectionParams(
            latitude: address.latitude,
            longitude: address.longitude,
          ));

          qiblahResult.fold(
            (failure) {
              state = state.copyWith(qiblahDirection: null);
            },
            (qiblahDirection) {
              state = state.copyWith(qiblahDirection: qiblahDirection);
            },
          );
        }
      },
    );
  }

  Future<bool> fetchLocation(String locale) async {
    state = state.copyWith(isFetchingLocation: true);
    final result =
        await _getCurrentLocation(GetCurrentLocationParams(locale: locale));
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
      (address) async {
        final qiblahResult = await _getQiblahDirection(GetQiblahDirectionParams(
          latitude: address.latitude,
          longitude: address.longitude,
        ));
        qiblahResult.fold(
          (failure) {
            // Handle Qiblah calculation error, maybe log it
            state = state.copyWith(
              isFetchingLocation: false,
              hasLocationPermission: true,
              isLocationEnabled: true,
              address: address,
              qiblahDirection: null, // Set to null on error
            );
          },
          (qiblahDirection) {
            state = state.copyWith(
              isFetchingLocation: false,
              hasLocationPermission: true,
              isLocationEnabled: true,
              address: address,
              qiblahDirection: qiblahDirection,
            );
          },
        );
        return true;
      },
    );
  }
}

final getQiblahDirectionUseCaseProvider = Provider<GetQiblahDirection>((ref) {
  return GetQiblahDirection();
});

final qiblahProvider =
    StateNotifierProvider<QiblahNotifier, QiblahState>((ref) {
  final getCurrentLocationUseCase = ref.read(getCurrentLocationUseCaseProvider);
  final getSettingsUseCase = ref.read(getSettingsUseCaseProvider);
  final getQiblahDirectionUseCase = ref.read(getQiblahDirectionUseCaseProvider);
  final notifier = QiblahNotifier(
    getCurrentLocationUseCase,
    getSettingsUseCase,
    getQiblahDirectionUseCase,
  );
  notifier.init(); // Call init here
  return notifier;
});
