import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taukeet/core/errors/failures.dart';
import 'package:taukeet/core/usecases/usecase.dart';
import 'package:taukeet/features/location/domain/entities/address.dart';
import 'package:taukeet/features/prayer_times/domain/entities/adjustments.dart';
import 'package:taukeet/features/prayer_times/domain/entities/prayer_time.dart';
import 'package:taukeet/features/prayer_times/domain/repositories/prayer_repository.dart';

class GetCurrentPrayer extends UseCase<PrayerTime, GetCurrentPrayerParams> {
  final PrayerRepository repository;

  GetCurrentPrayer(this.repository);

  @override
  Future<Either<Failure, PrayerTime>> call(
      GetCurrentPrayerParams params) async {
    try {
      // Initialize the repository with the required parameters
      repository.init(
        params.location,
        params.adjustments,
        params.calculationMethod,
        params.madhab,
        params.higherLatitude,
      );

      // Get the current prayer
      final currentPrayer = repository.currentPrayer();

      return Right(currentPrayer);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}

class GetCurrentPrayerParams extends Equatable {
  final Address location;
  final Adjustments adjustments;
  final String calculationMethod;
  final String madhab;
  final String higherLatitude;

  const GetCurrentPrayerParams({
    required this.location,
    required this.adjustments,
    required this.calculationMethod,
    required this.madhab,
    required this.higherLatitude,
  });

  @override
  List<Object> get props => [
        location,
        adjustments,
        calculationMethod,
        madhab,
        higherLatitude,
      ];
}
