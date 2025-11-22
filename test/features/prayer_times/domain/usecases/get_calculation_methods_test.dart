import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taukeet/core/errors/failures.dart';
import 'package:taukeet/features/prayer_times/domain/repositories/prayer_repository.dart';
import 'package:taukeet/features/prayer_times/domain/usecases/get_calculation_methods.dart';
import 'package:taukeet/core/usecases/usecase.dart';

class MockPrayerRepository extends Mock implements PrayerRepository {}

void main() {
  group('GetCalculationMethods', () {
    late MockPrayerRepository mockRepository;
    late GetCalculationMethods useCase;

    setUp(() {
      mockRepository = MockPrayerRepository();
      useCase = GetCalculationMethods(mockRepository);
    });

    group('success cases', () {
      test(
          'should return list of calculation methods when repository call succeeds',
          () async {
        // Arrange
        final expectedMethods = [
          'Dubai',
          'Egyptian',
          'Delhi',
          'Kuwait',
          'MoonsightingCommittee',
          'MuslimWorldLeague',
          'NorthAmerica',
          'Qatar',
          'Singapore',
          'Tehran',
          'Turkey',
          'UmmAlQura',
        ];

        when(() => mockRepository.calculationMethods)
            .thenReturn(expectedMethods);

        // Act
        final result = await useCase(NoParams());

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (l) => fail('Expected Right but got Left: $l'),
          (r) => expect(r, equals(expectedMethods)),
        );
        verify(() => mockRepository.calculationMethods).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test('should return methods in correct order', () async {
        // Arrange
        final expectedMethods = [
          'Dubai',
          'Egyptian',
          'Delhi',
          'Kuwait',
          'MoonsightingCommittee',
          'MuslimWorldLeague',
          'NorthAmerica',
          'Qatar',
          'Singapore',
          'Tehran',
          'Turkey',
          'UmmAlQura',
        ];

        when(() => mockRepository.calculationMethods)
            .thenReturn(expectedMethods);

        // Act
        final result = await useCase(NoParams());

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (l) => fail('Expected Right but got Left: $l'),
          (r) {
            expect(r, equals(expectedMethods));
            expect(r.length, equals(12));
          },
        );
      });

      test('should handle empty methods list', () async {
        // Arrange
        when(() => mockRepository.calculationMethods).thenReturn(<String>[]);

        // Act
        final result = await useCase(NoParams());

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (l) => fail('Expected Right but got Left: $l'),
          (r) => expect(r, isEmpty),
        );
      });
    });

    group('failure cases', () {
      test('should return ServerFailure when repository throws exception',
          () async {
        // Arrange
        when(() => mockRepository.calculationMethods)
            .thenThrow(Exception('Repository error'));

        // Act
        final result = await useCase(NoParams());

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (l) => expect(l, isA<ServerFailure>()),
          (r) => fail('Expected Left but got Right: $r'),
        );
        verify(() => mockRepository.calculationMethods).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test(
          'should return ServerFailure when repository throws generic Exception',
          () async {
        // Arrange
        when(() => mockRepository.calculationMethods)
            .thenThrow(Exception('Unknown error'));

        // Act
        final result = await useCase(NoParams());

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (l) => expect(l, isA<ServerFailure>()),
          (r) => fail('Expected Left but got Right: $r'),
        );
      });

      test('should return ServerFailure when repository throws ArgumentError',
          () async {
        // Arrange
        when(() => mockRepository.calculationMethods)
            .thenThrow(ArgumentError('Invalid argument'));

        // Act
        final result = await useCase(NoParams());

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (l) => expect(l, isA<ServerFailure>()),
          (r) => fail('Expected Left but got Right: $r'),
        );
      });
    });

    group('integration tests', () {
      test('should work with real prayer data structure', () async {
        // Arrange
        final testMethods = [
          'Dubai',
          'Egyptian',
          'Delhi',
          'Kuwait',
          'MoonsightingCommittee',
          'MuslimWorldLeague',
          'NorthAmerica',
          'Qatar',
          'Singapore',
          'Tehran',
          'Turkey',
          'UmmAlQura',
        ];

        when(() => mockRepository.calculationMethods).thenReturn(testMethods);

        // Act
        final result = await useCase(NoParams());

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (l) => fail('Expected Right but got Left: $l'),
          (r) {
            expect(r, containsAll(['Dubai', 'Delhi', 'MuslimWorldLeague']));
            expect(r.length, equals(12));
          },
        );
      });
    });
  });
}
