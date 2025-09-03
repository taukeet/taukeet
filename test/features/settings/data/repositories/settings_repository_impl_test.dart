
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taukeet/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:taukeet/features/settings/domain/entities/settings.dart';
import 'package:taukeet/features/settings/domain/services/settings_service.dart';

class MockSettingsService extends Mock implements SettingsService {}

void main() {
  late SettingsRepositoryImpl repository;
  late MockSettingsService mockSettingsService;

  setUp(() {
    mockSettingsService = MockSettingsService();
    repository = SettingsRepositoryImpl(mockSettingsService);
  });

  final tSettings = Settings();

  group('getSettings', () {
    test(
      'should return settings from the service',
      () async {
        // arrange
        when(() => mockSettingsService.getSettings())
            .thenAnswer((_) async => tSettings);
        // act
        final result = await repository.getSettings();
        // assert
        expect(result, tSettings);
        verify(() => mockSettingsService.getSettings());
        verifyNoMoreInteractions(mockSettingsService);
      },
    );
  });

  group('saveSettings', () {
    test(
      'should save settings to the service',
      () async {
        // arrange
        when(() => mockSettingsService.saveSettings(tSettings))
            .thenAnswer((_) async => {});
        // act
        await repository.saveSettings(tSettings);
        // assert
        verify(() => mockSettingsService.saveSettings(tSettings));
        verifyNoMoreInteractions(mockSettingsService);
      },
    );
  });

  group('resetSettings', () {
    test(
      'should reset settings in the service',
      () async {
        // arrange
        when(() => mockSettingsService.resetSettings())
            .thenAnswer((_) async => {});
        // act
        await repository.resetSettings();
        // assert
        verify(() => mockSettingsService.resetSettings());
        verifyNoMoreInteractions(mockSettingsService);
      },
    );
  });
}
