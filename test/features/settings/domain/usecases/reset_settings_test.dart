
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taukeet/core/usecases/usecase.dart';
import 'package:taukeet/features/settings/domain/repositories/settings_repository.dart';
import 'package:taukeet/features/settings/domain/usecases/reset_settings.dart';

class MockSettingsRepository extends Mock implements SettingsRepository {}

void main() {
  late ResetSettings usecase;
  late MockSettingsRepository mockSettingsRepository;

  setUp(() {
    mockSettingsRepository = MockSettingsRepository();
    usecase = ResetSettings(mockSettingsRepository);
  });

  test(
    'should reset settings in the repository',
    () async {
      // arrange
      when(() => mockSettingsRepository.resetSettings())
          .thenAnswer((_) async => const Right(null));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, const Right(null));
      verify(() => mockSettingsRepository.resetSettings());
      verifyNoMoreInteractions(mockSettingsRepository);
    },
  );
}
