import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taukeet/core/errors/failures.dart';
import 'package:taukeet/core/usecases/usecase.dart';
import 'package:taukeet/features/settings/domain/entities/settings.dart';
import 'package:taukeet/features/settings/domain/repositories/settings_repository.dart';

class UpdateSettings extends UseCase<void, UpdateSettingsParams> {
  final SettingsRepository repository;

  UpdateSettings(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateSettingsParams params) async {
    try {
      await repository.saveSettings(params.settings);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}

class UpdateSettingsParams extends Equatable {
  final Settings settings;

  const UpdateSettingsParams({
    required this.settings,
  });

  @override
  List<Object> get props => [settings];
}
