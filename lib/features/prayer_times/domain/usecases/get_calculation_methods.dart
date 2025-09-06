import 'package:dartz/dartz.dart';
import 'package:taukeet/core/usecases/usecase.dart';
import 'package:taukeet/features/prayer_times/domain/repositories/prayer_repository.dart';
import 'package:taukeet/core/errors/failures.dart';

class GetCalculationMethods extends UseCase<List<String>, NoParams> {
  final PrayerRepository repository;

  GetCalculationMethods(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(NoParams params) async {
    try {
      final methods = repository.calculationMethods;
      return Right(methods);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
