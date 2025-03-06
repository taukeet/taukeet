import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taukeet/src/entities/address.dart';
import 'package:taukeet/src/entities/adjustments.dart';
import 'package:taukeet/src/exceptions/location_disabled_exception.dart';
import 'package:taukeet/src/exceptions/location_permission_denied.dart';
import 'package:taukeet/src/services/geo_location_service.dart';
import 'package:get_it/get_it.dart';

// Provider
final settingsProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier();
});

final madhabProvider = Provider<String>((ref) {
  return ref.watch(settingsProvider).madhab;
});

// State
class SettingsState {
  final bool isFetchingLocation;
  final bool isLocationEnabled;
  final bool hasFetchedInitialLocation;
  final bool hasLocationPermission;
  final bool isTutorialCompleted;
  final Address address;
  final Adjustments adjustments;
  final String madhab;
  final String calculationMethod;
  final String higherLatitude;

  SettingsState({
    this.isFetchingLocation = false,
    this.isLocationEnabled = true,
    this.hasFetchedInitialLocation = false,
    this.hasLocationPermission = true,
    this.isTutorialCompleted = false,
    this.address = const Address(latitude: 0.0, longitude: 0.0, address: ""),
    this.adjustments = const Adjustments(
      fajr: 0,
      sunrise: 0,
      dhuhr: 0,
      asr: 0,
      maghrib: 0,
      isha: 0,
    ),
    this.madhab = "hanafi",
    this.calculationMethod = "Karachi",
    this.higherLatitude = "None",
  });

  String get madhabStr => madhab == "shafi" ? "Standard" : "Hanafi";

  SettingsState copyWith({
    bool? isFetchingLocation,
    bool? isLocationEnabled,
    bool? hasFetchedInitialLocation,
    bool? hasLocationPermission,
    bool? isTutorialCompleted,
    Address? address,
    Adjustments? adjustments,
    String? madhab,
    String? calculationMethod,
    String? higherLatitude,
  }) {
    return SettingsState(
      isFetchingLocation: isFetchingLocation ?? this.isFetchingLocation,
      isLocationEnabled: isLocationEnabled ?? this.isLocationEnabled,
      hasFetchedInitialLocation:
          hasFetchedInitialLocation ?? this.hasFetchedInitialLocation,
      hasLocationPermission: hasLocationPermission ?? this.hasLocationPermission,
      isTutorialCompleted: isTutorialCompleted ?? this.isTutorialCompleted,
      address: address ?? this.address,
      adjustments: adjustments ?? this.adjustments,
      madhab: madhab ?? this.madhab,
      calculationMethod: calculationMethod ?? this.calculationMethod,
      higherLatitude: higherLatitude ?? this.higherLatitude,
    );
  }
}

// Notifier
class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(SettingsState());

  Future<bool> fetchLocation() async {
    state = state.copyWith(isFetchingLocation: true);
    final geoService = GetIt.I<GeoLocationService>();
    try {
      final address = await geoService.fetch();
      state = state.copyWith(
        isFetchingLocation: false,
        address: address,
        isLocationEnabled: true,
        hasLocationPermission: true,
        hasFetchedInitialLocation: true,
      );
      return true;
    } on LocationDisabledException {
      state = state.copyWith(
        isFetchingLocation: false,
        isLocationEnabled: false,
        hasLocationPermission: true,
      );
      return false;
    } on LocationPermissionDenied {
      state = state.copyWith(
        isFetchingLocation: false,
        isLocationEnabled: true,
        hasLocationPermission: false,
      );
      return false;
    } catch (e) {
      state = state.copyWith(isFetchingLocation: false);

      return false;
    }
  }

  void completeTutorial() {
    state = state.copyWith(isTutorialCompleted: true);
  }

  void updateAdjustments({
    required int fajr,
    required int sunrise,
    required int dhuhr,
    required int asr,
    required int maghrib,
    required int isha,
  }) {
    state = state.copyWith(
      adjustments: Adjustments(
        fajr: fajr,
        sunrise: sunrise,
        dhuhr: dhuhr,
        asr: asr,
        maghrib: maghrib,
        isha: isha,
      ),
    );
  }

  void updateMadhab(String madhab) {
    state = state.copyWith(madhab: madhab);
  }

  void updateCalculationMethod(String method) {
    state = state.copyWith(calculationMethod: method);
  }

  void updateHigherLatitude(String value) {
    state = state.copyWith(higherLatitude: value);
  }
}