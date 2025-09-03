import 'package:flutter_test/flutter_test.dart';
import 'package:taukeet/core/errors/location_permission_denied.dart';

void main() {
  group('LocationPermissionDenied', () {
    test('should have default message', () {
      expect(
        LocationPermissionDenied().toString(),
        'LocationPermissionDenied: Location permissions are denied',
      );
    });

    test('should accept custom message', () {
      expect(
        LocationPermissionDenied('Custom denial').toString(),
        'LocationPermissionDenied: Custom denial',
      );
    });
  });
}
