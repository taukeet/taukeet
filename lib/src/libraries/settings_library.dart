import 'package:adhan_dart/adhan_dart.dart';
import 'package:hive/hive.dart';
import 'package:taukeet/src/entities/address.dart';
import 'package:taukeet/src/entities/settings.dart';

class SettingsLibrary {
  static const String settingsBoxName = 'settingsBox';
  static const String settingsKey = 'settingsKey';

  // Populate the default data to settings box if the data is not available
  Future<void> populateDefaultData() async {
    final settingsBox = await Hive.openBox<Settings>(settingsBoxName);
    final existingSettings = settingsBox.get(settingsKey);

    if (existingSettings == null) {
      final defaultAddress = Address(
        latitude: 24.524654,
        longitude: 39.569183,
        address: "Al-Madinah al-Munawwarah, Saudi Arabia",
      );
      final defaultSettings = Settings(
        address: defaultAddress,
        madhab: Madhab.Hanafi,
        calculationMethod: 'MuslimWorldLeague',
      );

      await settingsBox.put(settingsKey, defaultSettings);
    }
  }

  // Get the settings from the settings box
  Settings getSettings() {
    final settingsBox = Hive.box<Settings>(settingsBoxName);
    final storedSettings = settingsBox.get(settingsKey);

    if (storedSettings != null) {
      return storedSettings;
    } else {
      return Settings(
        address: Address(),
        madhab: Madhab.Hanafi,
        calculationMethod: 'MuslimWorldLeague',
      );
    }
  }

  // Update the address in the first Settings object found in the settings box
  Future<void> updateAddress(Address newAddress) async {
    final settingsBox = await Hive.openBox<Settings>(settingsBoxName);
    final Settings? settings = settingsBox.get(settingsKey);
    final updatedSettings = settings?.copyWith(address: newAddress);

    await settingsBox.put(settingsKey, updatedSettings!);
  }

  Future<void> updateMadhab(String madhab) async {
    final settingsBox = await Hive.openBox<Settings>(settingsBoxName);
    final Settings? settings = settingsBox.get(settingsKey);
    final updatedSettings = settings?.copyWith(madhab: madhab);

    await settingsBox.put(settingsKey, updatedSettings!);
  }

  Future<void> updateCalculationMethod(String method) async {
    final settingsBox = await Hive.openBox<Settings>(settingsBoxName);
    final Settings? settings = settingsBox.get(settingsKey);
    final updatedSettings = settings?.copyWith(calculationMethod: method);

    await settingsBox.put(settingsKey, updatedSettings!);
  }
}
