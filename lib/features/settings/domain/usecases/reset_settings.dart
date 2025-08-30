import 'package:dartz/dartz.dart';
import 'package:taukeet/core/errors/failures.dart';
import 'package:taukeet/core/usecases/usecase.dart';
import 'package:taukeet/features/settings/domain/repositories/settings_repository.dart';

class ResetSettings extends UseCase<void, NoParams> {
  final SettingsRepository repository;

  ResetSettings(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    try {
      await repository.resetSettings();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
