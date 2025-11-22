import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taukeet/core/errors/failures.dart';
import 'package:taukeet/features/prayer_times/domain/repositories/prayer_repository.dart';
import 'package:taukeet/features/prayer_times/domain/usecases/get_higher_latitudes.dart';
import 'package:taukeet/core/usecases/usecase.dart';

class MockPrayerRepository extends Mock implements PrayerRepository {}

void main() {
  group('GetHigherLatitudes', () {
    late MockPrayerRepository mockRepository;
    late GetHigherLatitudes useCase;

    setUp(() {
      mockRepository = MockPrayerRepository();
      useCase = GetHigherLatitudes(mockRepository);
    });

    group('success cases', () {
      test(
          'should return list of higher latitude options when repository call succeeds',
          () async {
        // Arrange
        final expectedLatitudes = [
          'MiddleOfTheNight',
          'SeventhOfTheNight',
          'TwilightAngle',
        ];

        when(() => mockRepository.higherLatitudes)
            .thenReturn(expectedLatitudes);

        // Act
        final result = await useCase(NoParams());

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (l) => fail('Expected Right but got Left: $l'),
          (r) => expect(r, equals(expectedLatitudes)),
        );
        verify(() => mockRepository.higherLatitudes).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test('should return latitudes in correct order', () async {
        // Arrange
        final expectedLatitudes = [
          'MiddleOfTheNight',
          'SeventhOfTheNight',
          'TwilightAngle',
        ];

        when(() => mockRepository.higherLatitudes)
            .thenReturn(expectedLatitudes);

        // Act
        final result = await useCase(NoParams());

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (l) => fail('Expected Right but got Left: $l'),
          (r) {
            expect(r, equals(expectedLatitudes));
            expect(r.length, equals(3));
            expect(r[0], equals('MiddleOfTheNight'));
            expect(r[1], equals('SeventhOfTheNight'));
            expect(r[2], equals('TwilightAngle'));
          },
        );
      });

      test('should handle empty latitudes list', () async {
        // Arrange
        when(() => mockRepository.higherLatitudes).thenReturn(<String>[]);

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
        when(() => mockRepository.higherLatitudes)
            .thenThrow(Exception('Repository error'));

        // Act
        final result = await useCase(NoParams());

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (l) => expect(l, isA<ServerFailure>()),
          (r) => fail('Expected Left but got Right: $r'),
        );
        verify(() => mockRepository.higherLatitudes).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test(
          'should return ServerFailure when repository throws generic Exception',
          () async {
        // Arrange
        when(() => mockRepository.higherLatitudes)
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
        when(() => mockRepository.higherLatitudes)
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
        final testLatitudes = [
          'MiddleOfTheNight',
          'SeventhOfTheNight',
          'TwilightAngle',
        ];

        when(() => mockRepository.higherLatitudes).thenReturn(testLatitudes);

        // Act
        final result = await useCase(NoParams());

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (l) => fail('Expected Right but got Left: $l'),
          (r) {
            expect(
                r,
                containsAll([
                  'MiddleOfTheNight',
                  'SeventhOfTheNight',
                  'TwilightAngle'
                ]));
            expect(r.length, equals(3));
          },
        );
      });

      test('should validate latitude option names', () async {
        // Arrange
        final expectedLatitudes = [
          'MiddleOfTheNight',
          'SeventhOfTheNight',
          'TwilightAngle',
        ];

        when(() => mockRepository.higherLatitudes)
            .thenReturn(expectedLatitudes);

        // Act
        final result = await useCase(NoParams());

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (l) => fail('Expected Right but got Left: $l'),
          (r) {
            expect(r, everyElement(isA<String>()));
            expect(r, everyElement(isNotEmpty));
          },
        );
      });
    });
  });
}
