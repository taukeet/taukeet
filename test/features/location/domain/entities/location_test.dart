
import 'package:flutter_test/flutter_test.dart';
import 'package:taukeet/features/location/domain/entities/coordinates.dart';
import 'package:taukeet/features/location/domain/entities/location.dart';

void main() {
  group('Location', () {
    test('should create a Location object with the given coordinates', () {
      // arrange
      const coordinates = Coordinates(latitude: 34.0, longitude: -118.0);

      // act
      final location = Location(coordinates: coordinates);

      // assert
      expect(location.coordinates, coordinates);
    });
  });
}
