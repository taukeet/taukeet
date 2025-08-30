import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taukeet/core/errors/failures.dart';
import 'package:taukeet/core/usecases/usecase.dart';
import 'package:taukeet/features/location/domain/entities/address.dart';
import 'package:taukeet/features/prayer_times/domain/entities/adjustments.dart';
import 'package:taukeet/features/prayer_times/domain/entities/prayer_time.dart';
import 'package:taukeet/features/prayer_times/domain/repositories/prayer_repository.dart';

class GetPrayerTimes extends UseCase<List<PrayerTime>, GetPrayerTimesParams> {
  final PrayerRepository repository;

  GetPrayerTimes(this.repository);

  @override
  Future<Either<Failure, List<PrayerTime>>> call(
      GetPrayerTimesParams params) async {
    try {
      // Initialize the repository with the required parameters
      repository.init(
        params.location,
        params.adjustments,
        params.calculationMethod,
        params.madhab,
        params.higherLatitude,
      );
      
      // Get prayer times for the specified date
      final prayerTimes = repository.prayers(params.date);
      
      return Right(prayerTimes);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}

class GetPrayerTimesParams extends Equatable {
  final DateTime date;
  final Address location;
  final Adjustments adjustments;
  final String calculationMethod;
  final String madhab;
  final String higherLatitude;

  const GetPrayerTimesParams({
    required this.date,
    required this.location,
    required this.adjustments,
    required this.calculationMethod,
    required this.madhab,
    required this.higherLatitude,
  });

  @override
  List<Object> get props => [
        date,
        location,
        adjustments,
        calculationMethod,
        madhab,
        higherLatitude,
      ];
}
