import 'package:flutter_test/flutter_test.dart';
import 'package:taukeet/core/errors/failures.dart';

void main() {
  group('LocationFailure', () {
    test('should support value equality', () {
      expect(LocationFailure(), LocationFailure());
    });

    test('should have correct props', () {
      expect(LocationFailure().props, isEmpty);
    });
  });
}
    test('should have correct string representation', () {
      expect(LocationFailure().toString(), 'LocationFailure');
    });
