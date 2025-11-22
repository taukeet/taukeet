import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taukeet/core/errors/failures.dart';
import 'package:taukeet/features/qiblah/domain/usecases/get_qiblah_direction.dart';

void main() {
  late GetQiblahDirection usecase;

  setUp(() {
    usecase = GetQiblahDirection();
  });

  group('GetQiblahDirection', () {
    // Test data - Mecca coordinates for reference
    const meccaLatitude = 21.4225;
    const meccaLongitude = 39.8262;

    // Test coordinates from different locations
    const delhiLatitude = 28.7041;
    const delhiLongitude = 77.1025;

    const londonLatitude = 51.5074;
    const londonLongitude = -0.1278;

    test('should return Qiblah direction for valid coordinates (Karachi)',
        () async {
      // arrange
      const params = GetQiblahDirectionParams(
        latitude: delhiLatitude,
        longitude: delhiLongitude,
      );

      // act
      final result = await usecase(params);

      // assert
      expect(result, isA<Right<Failure, double>>());
      result.fold(
        (failure) => fail('Expected success but got failure: $failure'),
        (direction) {
          expect(direction, isA<double>());
          expect(direction, isNotNull);
          // Karachi should face roughly West-Northwest to Mecca (around 255-265 degrees)
          expect(direction, inInclusiveRange(240.0, 270.0));
        },
      );
    });

    test('should return Qiblah direction for valid coordinates (London)',
        () async {
      // arrange
      const params = GetQiblahDirectionParams(
        latitude: londonLatitude,
        longitude: londonLongitude,
      );

      // act
      final result = await usecase(params);

      // assert
      expect(result, isA<Right<Failure, double>>());
      result.fold(
        (failure) => fail('Expected success but got failure: $failure'),
        (direction) {
          expect(direction, isA<double>());
          expect(direction, isNotNull);
          // London should face roughly South-Southeast to Mecca (around 115-125 degrees)
          expect(direction, inInclusiveRange(110.0, 130.0));
        },
      );
    });

    test('should return Qiblah direction for coordinates at equator', () async {
      // arrange
      const params = GetQiblahDirectionParams(
        latitude: 0.0,
        longitude: 0.0,
      );

      // act
      final result = await usecase(params);

      // assert
      expect(result, isA<Right<Failure, double>>());
      result.fold(
        (failure) => fail('Expected success but got failure: $failure'),
        (direction) {
          expect(direction, isA<double>());
          expect(direction, isNotNull);
          // From equator at 0° longitude, should face Northeast to Mecca
          expect(direction, inInclusiveRange(30.0, 60.0));
        },
      );
    });

    test('should return Qiblah direction for coordinates near North Pole',
        () async {
      // arrange
      const params = GetQiblahDirectionParams(
        latitude: 89.0,
        longitude: 0.0,
      );

      // act
      final result = await usecase(params);

      // assert
      expect(result, isA<Right<Failure, double>>());
      result.fold(
        (failure) => fail('Expected success but got failure: $failure'),
        (direction) {
          expect(direction, isA<double>());
          expect(direction, isNotNull);
        },
      );
    });

    test('should return Qiblah direction for coordinates near South Pole',
        () async {
      // arrange
      const params = GetQiblahDirectionParams(
        latitude: -89.0,
        longitude: 0.0,
      );

      // act
      final result = await usecase(params);

      // assert
      expect(result, isA<Right<Failure, double>>());
      result.fold(
        (failure) => fail('Expected success but got failure: $failure'),
        (direction) {
          expect(direction, isA<double>());
          expect(direction, isNotNull);
        },
      );
    });

    test('should return LocationFailure for invalid latitude (> 90)', () async {
      // arrange
      const params = GetQiblahDirectionParams(
        latitude: 91.0,
        longitude: 0.0,
      );

      // act
      final result = await usecase(params);

      // assert
      expect(result, isA<Left<Failure, double>>());
      result.fold(
        (failure) => expect(failure, isA<LocationFailure>()),
        (direction) => fail('Expected failure but got success: $direction'),
      );
    });

    test('should return LocationFailure for invalid latitude (< -90)',
        () async {
      // arrange
      const params = GetQiblahDirectionParams(
        latitude: -91.0,
        longitude: 0.0,
      );

      // act
      final result = await usecase(params);

      // assert
      expect(result, isA<Left<Failure, double>>());
      result.fold(
        (failure) => expect(failure, isA<LocationFailure>()),
        (direction) => fail('Expected failure but got success: $direction'),
      );
    });

    test('should return LocationFailure for invalid longitude (> 180)',
        () async {
      // arrange
      const params = GetQiblahDirectionParams(
        latitude: 0.0,
        longitude: 181.0,
      );

      // act
      final result = await usecase(params);

      // assert
      expect(result, isA<Left<Failure, double>>());
      result.fold(
        (failure) => expect(failure, isA<LocationFailure>()),
        (direction) => fail('Expected failure but got success: $direction'),
      );
    });

    test('should return LocationFailure for invalid longitude (< -180)',
        () async {
      // arrange
      const params = GetQiblahDirectionParams(
        latitude: 0.0,
        longitude: -181.0,
      );

      // act
      final result = await usecase(params);

      // assert
      expect(result, isA<Left<Failure, double>>());
      result.fold(
        (failure) => expect(failure, isA<LocationFailure>()),
        (direction) => fail('Expected failure but got success: $direction'),
      );
    });

    test('should return LocationFailure for NaN latitude', () async {
      // arrange
      const params = GetQiblahDirectionParams(
        latitude: double.nan,
        longitude: 0.0,
      );

      // act
      final result = await usecase(params);

      // assert
      expect(result, isA<Left<Failure, double>>());
      result.fold(
        (failure) => expect(failure, isA<LocationFailure>()),
        (direction) => fail('Expected failure but got success: $direction'),
      );
    });

    test('should return LocationFailure for NaN longitude', () async {
      // arrange
      const params = GetQiblahDirectionParams(
        latitude: 0.0,
        longitude: double.nan,
      );

      // act
      final result = await usecase(params);

      // assert
      expect(result, isA<Left<Failure, double>>());
      result.fold(
        (failure) => expect(failure, isA<LocationFailure>()),
        (direction) => fail('Expected failure but got success: $direction'),
      );
    });

    test('should return LocationFailure for infinity latitude', () async {
      // arrange
      const params = GetQiblahDirectionParams(
        latitude: double.infinity,
        longitude: 0.0,
      );

      // act
      final result = await usecase(params);

      // assert
      expect(result, isA<Left<Failure, double>>());
      result.fold(
        (failure) => expect(failure, isA<LocationFailure>()),
        (direction) => fail('Expected failure but got success: $direction'),
      );
    });

    test('should return LocationFailure for infinity longitude', () async {
      // arrange
      const params = GetQiblahDirectionParams(
        latitude: 0.0,
        longitude: double.infinity,
      );

      // act
      final result = await usecase(params);

      // assert
      expect(result, isA<Left<Failure, double>>());
      result.fold(
        (failure) => expect(failure, isA<LocationFailure>()),
        (direction) => fail('Expected failure but got success: $direction'),
      );
    });

    test('should handle Mecca coordinates (should return 0 or undefined)',
        () async {
      // arrange
      const params = GetQiblahDirectionParams(
        latitude: meccaLatitude,
        longitude: meccaLongitude,
      );

      // act
      final result = await usecase(params);

      // assert
      expect(result, isA<Right<Failure, double>>());
      result.fold(
        (failure) => fail('Expected success but got failure: $failure'),
        (direction) {
          expect(direction, isA<double>());
          expect(direction, isNotNull);
          // When at Mecca, direction might be 0 or undefined, but should not fail
        },
      );
    });

    test('should return consistent results for same coordinates', () async {
      // arrange
      const params = GetQiblahDirectionParams(
        latitude: delhiLatitude,
        longitude: delhiLongitude,
      );

      // act
      final result1 = await usecase(params);
      final result2 = await usecase(params);

      // assert
      expect(result1, isA<Right<Failure, double>>());
      expect(result2, isA<Right<Failure, double>>());

      result1.fold(
        (failure) =>
            fail('Expected success for first call but got failure: $failure'),
        (direction1) {
          result2.fold(
            (failure) => fail(
                'Expected success for second call but got failure: $failure'),
            (direction2) {
              expect(direction1, equals(direction2));
            },
          );
        },
      );
    });

    test('should return different results for different coordinates', () async {
      // arrange
      const params1 = GetQiblahDirectionParams(
        latitude: delhiLatitude,
        longitude: delhiLongitude,
      );
      const params2 = GetQiblahDirectionParams(
        latitude: londonLatitude,
        longitude: londonLongitude,
      );

      // act
      final result1 = await usecase(params1);
      final result2 = await usecase(params2);

      // assert
      expect(result1, isA<Right<Failure, double>>());
      expect(result2, isA<Right<Failure, double>>());

      result1.fold(
        (failure) =>
            fail('Expected success for first call but got failure: $failure'),
        (direction1) {
          result2.fold(
            (failure) => fail(
                'Expected success for second call but got failure: $failure'),
            (direction2) {
              expect(direction1, isNot(equals(direction2)));
            },
          );
        },
      );
    });
  });
}
