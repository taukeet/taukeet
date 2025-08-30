import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taukeet/src/entities/address.dart';
import 'package:taukeet/src/entities/adjustments.dart';
import 'package:taukeet/src/exceptions/location_disabled_exception.dart';
import 'package:taukeet/src/exceptions/location_permission_denied.dart';
import 'package:taukeet/src/providers/geo_location_provider.dart';

// FutureProvider to load settings from SharedPreferences
final settingsFutureProvider = FutureProvider<SettingsState>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  const settingsKey = SettingsNotifier._settingsKey;
  final settingsJson = prefs.getString(settingsKey);

  if (settingsJson != null) {
    final settingsMap = jsonDecode(settingsJson) as Map<String, dynamic>;
    return SettingsState.fromMap(settingsMap);
  }
  return SettingsState();
});

// Single settings provider, kept alive with initial state from settingsFutureProvider
final settingsProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  final initialState =
      ref.watch(settingsFutureProvider).value ?? SettingsState();
  return SettingsNotifier.withInitialState(ref, initialState);
});

// Provider for specific field (example)
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
      hasLocationPermission:
          hasLocationPermission ?? this.hasLocationPermission,
      isTutorialCompleted: isTutorialCompleted ?? this.isTutorialCompleted,
      address: address ?? this.address,
      adjustments: adjustments ?? this.adjustments,
      madhab: madhab ?? this.madhab,
      calculationMethod: calculationMethod ?? this.calculationMethod,
      higherLatitude: higherLatitude ?? this.higherLatitude,
    );
  }

  Map<String, dynamic> toMap() => {
        "address": address.toMap(),
        "adjustments": adjustments.toMap(),
        "madhab": madhab,
        "calculation_method": calculationMethod,
        "higher_latitude": higherLatitude,
        "has_fetched_initial_location": hasFetchedInitialLocation,
        "is_tutorial_completed": isTutorialCompleted,
      };

  factory SettingsState.fromMap(Map<String, dynamic> json) => SettingsState(
        address: json["address"] != null
            ? Address.fromMap(json["address"])
            : const Address(latitude: 0.0, longitude: 0.0, address: ""),
        adjustments: json["adjustments"] != null
            ? Adjustments.fromMap(json["adjustments"])
            : const Adjustments(
                fajr: 0,
                sunrise: 0,
                dhuhr: 0,
                asr: 0,
                maghrib: 0,
                isha: 0,
              ),
        madhab: json["madhab"] ?? "hanafi",
        calculationMethod: json["calculation_method"] ?? "Karachi",
        higherLatitude: json["higher_latitude"] ?? "None",
        hasFetchedInitialLocation:
            json["has_fetched_initial_location"] ?? false,
        isTutorialCompleted: json["is_tutorial_completed"] ?? false,
      );
}

// Notifier
class SettingsNotifier extends StateNotifier<SettingsState> {
  static const _settingsKey = 'taukeet_settings';
  late SharedPreferences _prefs;
  final Ref ref;

  SettingsNotifier(this.ref) : super(SettingsState()) {
    _initPrefs();
  }

  // ignore: use_super_parameters
  SettingsNotifier.withInitialState(this.ref, SettingsState initialState)
      : super(initialState) {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _saveSettings() async {
    final settingsJson = jsonEncode(state.toMap());

    await _prefs.setString(_settingsKey, settingsJson);
  }

  Future<bool> fetchLocation(String locale) async {
    state = state.copyWith(isFetchingLocation: true);
    final geoService = ref.read(geoLocationProvider);

    try {
      final address = await geoService.fetch(locale: locale);

      state = state.copyWith(
        isFetchingLocation: false,
        address: address,
        isLocationEnabled: true,
        hasLocationPermission: true,
        hasFetchedInitialLocation: true,
      );
      await _saveSettings();

      return true;
    } on LocationDisabledException {
      state = state.copyWith(
        isFetchingLocation: false,
        isLocationEnabled: false,
        hasLocationPermission: true,
      );
      await _saveSettings();

      return false;
    } on LocationPermissionDenied {
      state = state.copyWith(
        isFetchingLocation: false,
        isLocationEnabled: true,
        hasLocationPermission: false,
      );
      await _saveSettings();

      return false;
    } catch (e) {
      state = state.copyWith(isFetchingLocation: false);
      await _saveSettings();

      return false;
    }
  }

  void completeTutorial() {
    state = state.copyWith(isTutorialCompleted: true);
    _saveSettings();
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
    _saveSettings();
  }

  void updateMadhab(String madhab) {
    state = state.copyWith(madhab: madhab);
    _saveSettings();
  }

  void updateCalculationMethod(String method) {
    state = state.copyWith(calculationMethod: method);
    _saveSettings();
  }

  void updateHigherLatitude(String value) {
    state = state.copyWith(higherLatitude: value);
    _saveSettings();
  }
}
