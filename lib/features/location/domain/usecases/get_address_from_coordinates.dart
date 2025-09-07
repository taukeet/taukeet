import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taukeet/core/errors/failures.dart';
import 'package:taukeet/core/usecases/usecase.dart';
import 'package:taukeet/features/location/domain/entities/address.dart';
import 'package:taukeet/features/location/domain/repositories/location_repository.dart';

class GetAddressFromCoordinates
    extends UseCase<Address, GetAddressFromCoordinatesParams> {
  final LocationRepository repository;

  GetAddressFromCoordinates(this.repository);

  @override
  Future<Either<Failure, Address>> call(
      GetAddressFromCoordinatesParams params) async {
    try {
      final address = await repository.getAddressFromCoordinates(
        params.latitude,
        params.longitude,
        params.locale,
      );
      return Right(address);
    } catch (e) {
      return Left(LocationFailure());
    }
  }
}

class GetAddressFromCoordinatesParams extends Equatable {
  final double latitude;
  final double longitude;
  final String locale;

  const GetAddressFromCoordinatesParams({
    required this.latitude,
    required this.longitude,
    required this.locale,
  });

  @override
  List<Object> get props => [latitude, longitude, locale];
}
