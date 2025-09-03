import 'package:flutter_test/flutter_test.dart';
import 'package:taukeet/core/errors/location_disabled_exception.dart';

void main() {
  group('LocationDisabledException', () {
    test('should have default message', () {
      expect(
        LocationDisabledException().toString(),
        'LocationDisabledException: Location services are disabled',
      );
    });

    test('should accept custom message', () {
      expect(
        LocationDisabledException('Custom message').toString(),
        'LocationDisabledException: Custom message',
      );
    });
  });
}
