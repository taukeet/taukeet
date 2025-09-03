
import 'package:taukeet/features/settings/domain/entities/settings.dart';

abstract class SettingsService {
  Future<Settings> getSettings();
  Future<void> saveSettings(Settings settings);
  Future<void> resetSettings();
}
