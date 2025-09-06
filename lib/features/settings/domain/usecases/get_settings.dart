import 'package:dartz/dartz.dart';
import 'package:taukeet/core/errors/failures.dart';
import 'package:taukeet/core/usecases/usecase.dart';
import 'package:taukeet/features/settings/domain/entities/settings.dart';
import 'package:taukeet/features/settings/domain/repositories/settings_repository.dart';

class GetSettings extends UseCase<Settings, NoParams> {
  final SettingsRepository repository;

  GetSettings(this.repository);

  @override
  Future<Either<Failure, Settings>> call(NoParams params) async {
    try {
      final settings = await repository.getSettings();
      return Right(settings);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
