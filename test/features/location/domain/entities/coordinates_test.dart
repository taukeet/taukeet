import 'package:flutter_test/flutter_test.dart';
import 'package:taukeet/features/location/domain/entities/coordinates.dart';

void main() {
  group('Coordinates', () {
    const coords = Coordinates(latitude: 24.8607, longitude: 67.0011);
    
    test('should have correct property values', () {
      expect(coords.latitude, 24.8607);
      expect(coords.longitude, 67.0011);
    });

    test('should support value equality', () {
      expect(
        coords,
        const Coordinates(latitude: 24.8607, longitude: 67.0011),
      );
    });

    test('should have correct props', () {
      expect(coords.props, [24.8607, 67.0011]);
    });

    test('should implement Equatable properly', () {
      expect(coords, equals(const Coordinates(latitude: 24.8607, longitude: 67.0011)));
      expect(coords, isNot(equals(const Coordinates(latitude: 25.0, longitude: 67.0011))));
    });
  });
}
