import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taukeet/core/errors/failures.dart';
import 'package:taukeet/features/location/domain/entities/address.dart';
import 'package:taukeet/features/location/domain/repositories/location_repository.dart';
import 'package:taukeet/features/location/domain/usecases/get_address_from_coordinates.dart';

// Mock repository
class MockLocationRepository extends Mock implements LocationRepository {}

void main() {
  late GetAddressFromCoordinates usecase;
  late MockLocationRepository mockRepository;

  setUp(() {
    mockRepository = MockLocationRepository();
    usecase = GetAddressFromCoordinates(mockRepository);
  });

  const tLatitude = 17.3850;
  const tLongitude = 78.4867;
  const tLocale = 'en';
  final tParams = GetAddressFromCoordinatesParams(
    latitude: tLatitude,
    longitude: tLongitude,
    locale: tLocale,
  );

  final tAddress = Address(
    latitude: tLatitude,
    longitude: tLongitude,
    address: "Hyderabad, India",
  );

  group('GetAddressFromCoordinates', () {
    test('should return Address when repository call succeeds', () async {
      // arrange
      when(() => mockRepository.getAddressFromCoordinates(
            tLatitude,
            tLongitude,
            tLocale,
          )).thenAnswer((_) async => tAddress);

      // act
      final result = await usecase(tParams);

      // assert
      expect(result, Right(tAddress));
      verify(() => mockRepository.getAddressFromCoordinates(
            tLatitude,
            tLongitude,
            tLocale,
          )).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return LocationFailure when repository throws exception',
        () async {
      // arrange
      when(() => mockRepository.getAddressFromCoordinates(
            tLatitude,
            tLongitude,
            tLocale,
          )).thenThrow(Exception('Something went wrong'));

      // act
      final result = await usecase(tParams);

      // assert
      expect(result, Left(LocationFailure()));
      verify(() => mockRepository.getAddressFromCoordinates(
            tLatitude,
            tLongitude,
            tLocale,
          )).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
