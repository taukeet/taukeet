import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taukeet/features/settings/domain/entities/settings.dart';
import 'package:taukeet/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  static const _settingsKey = 'taukeet_settings';
  final SharedPreferences prefs;

  SettingsRepositoryImpl(this.prefs);

  @override
  Future<Settings> getSettings() async {
    final settingsJson = prefs.getString(_settingsKey);
    if (settingsJson != null) {
      final map = jsonDecode(settingsJson) as Map<String, dynamic>;
      return Settings.fromMap(map);
    }
    return Settings(); // return default settings if none saved
  }

  @override
  Future<void> saveSettings(Settings settings) async {
    final json = jsonEncode(settings.toMap());
    await prefs.setString(_settingsKey, json);
  }

  @override
  Future<void> resetSettings() async {
    await prefs.remove(_settingsKey);
  }
}
