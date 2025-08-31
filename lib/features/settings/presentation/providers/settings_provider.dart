import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taukeet/core/usecases/usecase.dart';
import 'package:taukeet/features/location/domain/entities/address.dart';
import 'package:taukeet/features/prayer_times/domain/entities/adjustments.dart';
import 'package:taukeet/features/settings/domain/entities/settings.dart';
import 'package:taukeet/features/settings/domain/usecases/get_settings.dart';
import 'package:taukeet/features/settings/domain/usecases/update_settings.dart';
import 'package:taukeet/features/settings/domain/usecases/reset_settings.dart';
import 'package:taukeet/features/location/domain/usecases/get_current_location.dart';
import 'package:taukeet/features/location/domain/usecases/get_address_from_coordinates.dart';

// Use case providers (to be overridden with dependency injection)
final getSettingsUseCaseProvider = Provider<GetSettings>((ref) {
  throw UnimplementedError('getSettingsUseCaseProvider must be overridden with dependency injection');
});

final updateSettingsUseCaseProvider = Provider<UpdateSettings>((ref) {
  throw UnimplementedError('updateSettingsUseCaseProvider must be overridden with dependency injection');
});

final resetSettingsUseCaseProvider = Provider<ResetSettings>((ref) {
  throw UnimplementedError('resetSettingsUseCaseProvider must be overridden with dependency injection');
});

final getCurrentLocationUseCaseProvider = Provider<GetCurrentLocation>((ref) {
  throw UnimplementedError('getCurrentLocationUseCaseProvider must be overridden with dependency injection');
});

final getAddressFromCoordinatesUseCaseProvider = Provider<GetAddressFromCoordinates>((ref) {
  throw UnimplementedError('getAddressFromCoordinatesUseCaseProvider must be overridden with dependency injection');
});

// FutureProvider to load settings
final settingsFutureProvider = FutureProvider<Settings>((ref) async {
  final useCase = ref.watch(getSettingsUseCaseProvider);
  final result = await useCase(NoParams());
  
  return result.fold(
    (failure) => const Settings(
      address: Address(latitude: 0.0, longitude: 0.0, address: ""),
      adjustments: Adjustments(
        fajr: 0,
        sunrise: 0,
        dhuhr: 0,
        asr: 0,
        maghrib: 0,
        isha: 0,
      ),
      madhab: "hanafi",
      calculationMethod: "Karachi",
      higherLatitude: "None",
      hasFetchedInitialLocation: false,
      isTutorialCompleted: false,
    ),
    (settings) => settings,
  );
});

// Settings state with location-related states
class SettingsState {
  final bool isFetchingLocation;
  final bool isLocationEnabled;
  final bool hasLocationPermission;
  final Settings settings;

  const SettingsState({
    this.isFetchingLocation = false,
    this.isLocationEnabled = true,
    this.hasLocationPermission = true,
    required this.settings,
  });

  SettingsState copyWith({
    bool? isFetchingLocation,
    bool? isLocationEnabled,
    bool? hasLocationPermission,
    Settings? settings,
  }) {
    return SettingsState(
      isFetchingLocation: isFetchingLocation ?? this.isFetchingLocation,
      isLocationEnabled: isLocationEnabled ?? this.isLocationEnabled,
      hasLocationPermission: hasLocationPermission ?? this.hasLocationPermission,
      settings: settings ?? this.settings,
    );
  }
}

// Main settings provider
final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  final initialSettings = ref.watch(settingsFutureProvider).value ?? const Settings(
    address: Address(latitude: 0.0, longitude: 0.0, address: ""),
    adjustments: Adjustments(
      fajr: 0,
      sunrise: 0,
      dhuhr: 0,
      asr: 0,
      maghrib: 0,
      isha: 0,
    ),
    madhab: "hanafi",
    calculationMethod: "Karachi",
    higherLatitude: "None",
    hasFetchedInitialLocation: false,
    isTutorialCompleted: false,
  );
  
  return SettingsNotifier(ref, initialSettings);
});

// Provider for specific field (example)
final madhabProvider = Provider<String>((ref) {
  return ref.watch(settingsProvider).settings.madhab;
});

// Settings Notifier
class SettingsNotifier extends StateNotifier<SettingsState> {
  final Ref ref;

  SettingsNotifier(this.ref, Settings initialSettings) 
      : super(SettingsState(settings: initialSettings));

  Future<void> _saveSettings(Settings settings) async {
    final useCase = ref.read(updateSettingsUseCaseProvider);
    final params = UpdateSettingsParams(settings: settings);
    await useCase(params);
  }

  Future<bool> fetchLocation(String locale) async {
    print('SettingsNotifier: fetchLocation called');
    state = state.copyWith(isFetchingLocation: true);
    final useCase = ref.read(getCurrentLocationUseCaseProvider);
    final params = GetCurrentLocationParams(locale: locale);

    try {
      final result = await useCase(params);
      
      return result.fold(
        (failure) {
          // Handle different types of failures
          state = state.copyWith(
            isFetchingLocation: false,
            isLocationEnabled: false,
            hasLocationPermission: false,
          );
          return false;
        },
        (address) async {
          final updatedSettings = state.settings.copyWith(
            address: address,
            hasFetchedInitialLocation: true,
          );
          
          state = state.copyWith(
            isFetchingLocation: false,
            isLocationEnabled: true,
            hasLocationPermission: true,
            settings: updatedSettings,
          );
          
          await _saveSettings(updatedSettings);
          return true;
        },
      );
    } catch (e) {
      state = state.copyWith(isFetchingLocation: false);
      return false;
    }
  }

  Future<void> translateAddress(String locale) async {
    print('SettingsNotifier: translateAddress called');
    // Only translate if we have valid coordinates
    if (state.settings.address.latitude == 0.0 && 
        state.settings.address.longitude == 0.0) {
      return;
    }

    try {
      final useCase = ref.read(getAddressFromCoordinatesUseCaseProvider);
      final params = GetAddressFromCoordinatesParams(
        latitude: state.settings.address.latitude,
        longitude: state.settings.address.longitude,
        locale: locale,
      );

      final result = await useCase(params);
      
      result.fold(
        (failure) {
          // If translation fails, keep the current address
        },
        (translatedAddress) async {
          final updatedSettings = state.settings.copyWith(address: translatedAddress);
          state = state.copyWith(settings: updatedSettings);
          await _saveSettings(updatedSettings);
        },
      );
    } catch (e) {
      // If translation fails, keep the current address
    }
  }

  void completeTutorial() {
    final updatedSettings = state.settings.copyWith(isTutorialCompleted: true);
    state = state.copyWith(settings: updatedSettings);
    _saveSettings(updatedSettings);
  }

  void updateAdjustments({
    required int fajr,
    required int sunrise,
    required int dhuhr,
    required int asr,
    required int maghrib,
    required int isha,
  }) {
    final newAdjustments = Adjustments(
      fajr: fajr,
      sunrise: sunrise,
      dhuhr: dhuhr,
      asr: asr,
      maghrib: maghrib,
      isha: isha,
    );
    
    final updatedSettings = state.settings.copyWith(adjustments: newAdjustments);
    state = state.copyWith(settings: updatedSettings);
    _saveSettings(updatedSettings);
  }

  void updateMadhab(String madhab) {
    final updatedSettings = state.settings.copyWith(madhab: madhab);
    state = state.copyWith(settings: updatedSettings);
    _saveSettings(updatedSettings);
  }

  void updateCalculationMethod(String method) {
    final updatedSettings = state.settings.copyWith(calculationMethod: method);
    state = state.copyWith(settings: updatedSettings);
    _saveSettings(updatedSettings);
  }

  void updateHigherLatitude(String value) {
    final updatedSettings = state.settings.copyWith(higherLatitude: value);
    state = state.copyWith(settings: updatedSettings);
    _saveSettings(updatedSettings);
  }

  Future<void> resetToDefaults() async {
    final useCase = ref.read(resetSettingsUseCaseProvider);
    await useCase(NoParams());
    
    // Reset to default settings
    const defaultSettings = Settings(
      address: Address(latitude: 0.0, longitude: 0.0, address: ""),
      adjustments: Adjustments(
        fajr: 0,
        sunrise: 0,
        dhuhr: 0,
        asr: 0,
        maghrib: 0,
        isha: 0,
      ),
      madhab: "hanafi",
      calculationMethod: "Karachi",
      higherLatitude: "None",
      hasFetchedInitialLocation: false,
      isTutorialCompleted: false,
    );
    
    state = state.copyWith(settings: defaultSettings);
  }
}
