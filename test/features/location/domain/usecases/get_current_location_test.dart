import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taukeet/core/errors/failures.dart';
import 'package:taukeet/core/errors/location_disabled_exception.dart';
import 'package:taukeet/features/location/domain/entities/address.dart';
import 'package:taukeet/features/location/domain/repositories/location_repository.dart';
import 'package:taukeet/features/location/domain/usecases/get_current_location.dart';

// Mock repository
class MockLocationRepository extends Mock implements LocationRepository {}

void main() {
  late GetCurrentLocation usecase;
  late MockLocationRepository mockRepository;

  setUp(() {
    mockRepository = MockLocationRepository();
    usecase = GetCurrentLocation(mockRepository);
  });

  const tLocale = 'en';
  final tParams = GetCurrentLocationParams(locale: tLocale);
  final tAddress = Address(
    latitude: 24.8607,
    longitude: 67.0011,
    address: "Hyderabad, India",
  );

  group('GetCurrentLocation', () {
    test('should return Address when repository call succeeds', () async {
      // arrange
      when(() => mockRepository.getCurrentLocation(tLocale))
          .thenAnswer((_) async => tAddress);

      // act
      final result = await usecase(tParams);

      // assert
      expect(result, Right(tAddress));
      verify(() => mockRepository.getCurrentLocation(tLocale)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return LocationFailure when repository throws exception',
        () async {
      // arrange
      when(() => mockRepository.getCurrentLocation(tLocale))
          .thenThrow(LocationDisabledException('Location services disabled'));

      // act
      final result = await usecase(tParams);

      // assert
      expect(result, Left(LocationFailure()));
      verify(() => mockRepository.getCurrentLocation(tLocale)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
