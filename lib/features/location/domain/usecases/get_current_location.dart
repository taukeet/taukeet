import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taukeet/core/errors/failures.dart';
import 'package:taukeet/core/usecases/usecase.dart';
import 'package:taukeet/features/location/domain/entities/address.dart';
import 'package:taukeet/features/location/domain/repositories/location_repository.dart';

class GetCurrentLocation extends UseCase<Address, GetCurrentLocationParams> {
  final LocationRepository repository;

  GetCurrentLocation(this.repository);

  @override
  Future<Either<Failure, Address>> call(GetCurrentLocationParams params) async {
    try {
      final address = await repository.getCurrentLocation(params.locale);
      return Right(address);
    } catch (e) {
      return Left(LocationFailure());
    }
  }
}

class GetCurrentLocationParams extends Equatable {
  final String locale;

  const GetCurrentLocationParams({
    required this.locale,
  });

  @override
  List<Object> get props => [locale];
}
