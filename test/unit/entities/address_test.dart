import 'package:flutter_test/flutter_test.dart';
import 'package:taukeet/src/entities/address.dart';

void main() {
  group('Address Entity Tests', () {
    test('should create Address with all properties', () {
      // Arrange
      const latitude = 24.8607;
      const longitude = 67.0011;
      const addressText = "Hyderabad, India";

      // Act
      const address = Address(
        latitude: latitude,
        longitude: longitude,
        address: addressText,
      );

      // Assert
      expect(address.latitude, equals(latitude));
      expect(address.longitude, equals(longitude));
      expect(address.address, equals(addressText));
    });

    test('should create Address with default empty address', () {
      // Act
      const address = Address(
        latitude: 0.0,
        longitude: 0.0,
        address: "",
      );

      // Assert
      expect(address.latitude, equals(0.0));
      expect(address.longitude, equals(0.0));
      expect(address.address, isEmpty);
    });

    test('should serialize to JSON correctly', () {
      // Arrange
      const address = Address(
        latitude: 24.8607,
        longitude: 67.0011,
        address: "Hyderabad, India",
      );

      // Act
      final json = address.toJson();
      final decoded = Address.fromJson(json);

      // Assert
      expect(decoded.latitude, equals(address.latitude));
      expect(decoded.longitude, equals(address.longitude));
      expect(decoded.address, equals(address.address));
    });

    test('should create from Map correctly', () {
      // Arrange
      final map = {
        'latitude': 24.8607,
        'longitude': 67.0011,
        'address': 'Hyderabad, India',
      };

      // Act
      final address = Address.fromMap(map);

      // Assert
      expect(address.latitude, equals(24.8607));
      expect(address.longitude, equals(67.0011));
      expect(address.address, equals('Hyderabad, India'));
    });

    test('should convert to Map correctly', () {
      // Arrange
      const address = Address(
        latitude: 24.8607,
        longitude: 67.0011,
        address: "Hyderabad, India",
      );

      // Act
      final map = address.toMap();

      // Assert
      expect(map['latitude'], equals(24.8607));
      expect(map['longitude'], equals(67.0011));
      expect(map['address'], equals('Hyderabad, India'));
    });

    test('should handle copyWith correctly', () {
      // Arrange
      const originalAddress = Address(
        latitude: 24.8607,
        longitude: 67.0011,
        address: "Hyderabad, India",
      );

      // Act
      final copiedAddress = originalAddress.copyWith(
        address: "Delhi, India",
      );

      // Assert
      expect(copiedAddress.latitude, equals(originalAddress.latitude));
      expect(copiedAddress.longitude, equals(originalAddress.longitude));
      expect(copiedAddress.address, equals("Delhi, India"));
    });

    test('should handle copyWith with no changes', () {
      // Arrange
      const originalAddress = Address(
        latitude: 24.8607,
        longitude: 67.0011,
        address: "Hyderabad, India",
      );

      // Act
      final copiedAddress = originalAddress.copyWith();

      // Assert
      expect(copiedAddress.latitude, equals(originalAddress.latitude));
      expect(copiedAddress.longitude, equals(originalAddress.longitude));
      expect(copiedAddress.address, equals(originalAddress.address));
    });

    test('should handle equality correctly', () {
      // Arrange
      const address1 = Address(
        latitude: 24.8607,
        longitude: 67.0011,
        address: "Hyderabad, India",
      );

      const address2 = Address(
        latitude: 24.8607,
        longitude: 67.0011,
        address: "Hyderabad, India",
      );

      const address3 = Address(
        latitude: 25.0000,
        longitude: 67.0011,
        address: "Hyderabad, India",
      );

      // Assert
      expect(address1, equals(address2));
      expect(address1, isNot(equals(address3)));
    });
  });
}
