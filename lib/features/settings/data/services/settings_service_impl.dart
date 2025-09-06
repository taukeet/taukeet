import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taukeet/features/settings/domain/entities/settings.dart';
import 'package:taukeet/features/settings/domain/services/settings_service.dart';

@LazySingleton(as: SettingsService)
class SettingsServiceImpl implements SettingsService {
  static const _settingsKey = 'taukeet_settings';
  final SharedPreferences prefs;

  SettingsServiceImpl(this.prefs);

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
