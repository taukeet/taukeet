import 'package:flutter_test/flutter_test.dart';
import 'package:taukeet/features/location/domain/entities/coordinates.dart';

void main() {
  group('Coordinates', () {
    const coords = Coordinates(latitude: 28.7041, longitude: 77.1025);

    test('should have correct property values', () {
      expect(coords.latitude, 28.7041);
      expect(coords.longitude, 77.1025);
    });

    test('should support value equality', () {
      expect(
        coords,
        const Coordinates(latitude: 28.7041, longitude: 77.1025),
      );
    });

    test('should have correct props', () {
      expect(coords.props, [28.7041, 77.1025]);
    });

    test('should implement Equatable properly', () {
      expect(coords,
          equals(const Coordinates(latitude: 28.7041, longitude: 77.1025)));
      expect(coords,
          isNot(equals(const Coordinates(latitude: 25.0, longitude: 67.0011))));
    });
  });
}
