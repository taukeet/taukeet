import 'package:injectable/injectable.dart';
import 'package:taukeet/features/settings/domain/entities/settings.dart';
import 'package:taukeet/features/settings/domain/repositories/settings_repository.dart';
import 'package:taukeet/features/settings/domain/services/settings_service.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsService settingsService;

  SettingsRepositoryImpl(this.settingsService);

  @override
  Future<Settings> getSettings() {
    return settingsService.getSettings();
  }

  @override
  Future<void> saveSettings(Settings settings) {
    return settingsService.saveSettings(settings);
  }

  @override
  Future<void> resetSettings() {
    return settingsService.resetSettings();
  }
}
