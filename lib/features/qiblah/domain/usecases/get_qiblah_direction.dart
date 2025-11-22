import 'package:adhan/adhan.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taukeet/core/errors/failures.dart';
import 'package:taukeet/core/usecases/usecase.dart';

class GetQiblahDirection extends UseCase<double, GetQiblahDirectionParams> {
  @override
  Future<Either<Failure, double>> call(GetQiblahDirectionParams params) async {
    try {
      // Validate coordinates
      if (!_isValidCoordinates(params.latitude, params.longitude)) {
        return Left(LocationFailure());
      }
      
      final coordinates = Coordinates(params.latitude, params.longitude);
      final qiblah = Qibla(coordinates);
      final direction = qiblah.direction;
      
      // Check if result is valid
      if (direction.isNaN) {
        return Left(LocationFailure());
      }
      
      return Right(direction);
    } catch (e) {
      return Left(LocationFailure());
    }
  }
  
  bool _isValidCoordinates(double latitude, double longitude) {
    // Check for NaN or infinity
    if (latitude.isNaN || latitude.isInfinite || 
        longitude.isNaN || longitude.isInfinite) {
      return false;
    }
    
    // Check valid ranges
    if (latitude < -90.0 || latitude > 90.0 ||
        longitude < -180.0 || longitude > 180.0) {
      return false;
    }
    
    return true;
  }
}

class GetQiblahDirectionParams extends Equatable {
  final double latitude;
  final double longitude;

  const GetQiblahDirectionParams({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object> get props => [latitude, longitude];
}
