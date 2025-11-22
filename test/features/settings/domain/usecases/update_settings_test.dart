import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taukeet/features/settings/domain/entities/settings.dart';
import 'package:taukeet/features/settings/domain/repositories/settings_repository.dart';
import 'package:taukeet/features/settings/domain/usecases/update_settings.dart';

class MockSettingsRepository extends Mock implements SettingsRepository {}

void main() {
  late UpdateSettings usecase;
  late MockSettingsRepository mockSettingsRepository;

  setUp(() {
    mockSettingsRepository = MockSettingsRepository();
    usecase = UpdateSettings(mockSettingsRepository);
  });

  final tSettings = Settings();

  test(
    'should update settings in the repository',
    () async {
      // arrange
      when(() => mockSettingsRepository.saveSettings(tSettings))
          .thenAnswer((_) async => const Right(null));
      // act
      final result = await usecase(UpdateSettingsParams(settings: tSettings));
      // assert
      expect(result, const Right(null));
      verify(() => mockSettingsRepository.saveSettings(tSettings));
      verifyNoMoreInteractions(mockSettingsRepository);
    },
  );
}
