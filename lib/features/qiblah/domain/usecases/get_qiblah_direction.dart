import 'package:adhan/adhan.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taukeet/core/errors/failures.dart';
import 'package:taukeet/core/usecases/usecase.dart';

class GetQiblahDirection extends UseCase<double, GetQiblahDirectionParams> {
  @override
  Future<Either<Failure, double>> call(GetQiblahDirectionParams params) async {
    try {
      final coordinates = Coordinates(params.latitude, params.longitude);
      final qiblah = Qibla(coordinates);
      return Right(qiblah.direction);
    } catch (e) {
      return Left(LocationFailure());
    }
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
