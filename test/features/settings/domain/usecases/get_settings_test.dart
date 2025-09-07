import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taukeet/core/usecases/usecase.dart';
import 'package:taukeet/features/settings/domain/entities/settings.dart';
import 'package:taukeet/features/settings/domain/repositories/settings_repository.dart';
import 'package:taukeet/features/settings/domain/usecases/get_settings.dart';

class MockSettingsRepository extends Mock implements SettingsRepository {}

void main() {
  late GetSettings usecase;
  late MockSettingsRepository mockSettingsRepository;

  setUp(() {
    mockSettingsRepository = MockSettingsRepository();
    usecase = GetSettings(mockSettingsRepository);
  });

  final tSettings = Settings();

  test(
    'should get settings from the repository',
    () async {
      // arrange
      when(() => mockSettingsRepository.getSettings())
          .thenAnswer((_) async => tSettings);
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Right(tSettings));
      verify(() => mockSettingsRepository.getSettings());
      verifyNoMoreInteractions(mockSettingsRepository);
    },
  );
}
