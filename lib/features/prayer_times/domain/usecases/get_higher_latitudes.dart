import 'package:dartz/dartz.dart';
import 'package:taukeet/core/errors/failures.dart';
import 'package:taukeet/core/usecases/usecase.dart';
import 'package:taukeet/features/prayer_times/domain/repositories/prayer_repository.dart';

class GetHigherLatitudes extends UseCase<List<String>, NoParams> {
  final PrayerRepository repository;

  GetHigherLatitudes(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(NoParams params) async {
    try {
      final latitudes = repository.higherLatitudes;
      return Right(latitudes);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
