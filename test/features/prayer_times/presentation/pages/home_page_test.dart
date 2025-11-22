import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:taukeet/features/location/domain/entities/address.dart';
import 'package:taukeet/features/prayer_times/domain/entities/adjustments.dart';
import 'package:taukeet/features/prayer_times/domain/entities/prayer_name.dart';
import 'package:taukeet/features/prayer_times/domain/entities/prayer_time.dart';
import 'package:taukeet/features/prayer_times/domain/usecases/get_prayer_times.dart';
import 'package:taukeet/features/prayer_times/domain/usecases/get_current_prayer.dart';
import 'package:taukeet/features/prayer_times/presentation/providers/prayer_times_provider.dart';
import 'package:taukeet/features/prayer_times/presentation/pages/home_page.dart';
import 'package:taukeet/features/settings/presentation/providers/settings_provider.dart';
import 'package:taukeet/features/settings/domain/entities/settings.dart';
import 'package:taukeet/core/usecases/usecase.dart';
import 'package:taukeet/core/errors/failures.dart';
import 'package:taukeet/generated/l10n.dart';

// Mock classes
class MockGetPrayerTimes extends Mock implements GetPrayerTimes {}

class MockGetCurrentPrayer extends Mock implements GetCurrentPrayer {}

// Mock Ref for SettingsNotifier
class MockRef extends Mock implements Ref {}

void main() {
  setUpAll(() {
    registerFallbackValue(GetPrayerTimesParams(
      date: DateTime.now(),
      location: const Address(
          latitude: 28.7041, longitude: 77.1025, address: "Delhi, India"),
      adjustments: const Adjustments(
          fajr: 0, sunrise: 0, dhuhr: 0, asr: 0, maghrib: 0, isha: 0),
      calculationMethod: 'Delhi',
      madhab: 'hanafi',
      higherLatitude: 'None',
    ));
    registerFallbackValue(GetCurrentPrayerParams(
      location: const Address(
          latitude: 28.7041, longitude: 77.1025, address: "Delhi, India"),
      adjustments: const Adjustments(
          fajr: 0, sunrise: 0, dhuhr: 0, asr: 0, maghrib: 0, isha: 0),
      calculationMethod: 'Delhi',
      madhab: 'hanafi',
      higherLatitude: 'None',
    ));
    registerFallbackValue(NoParams());
  });

  group('HomePage Widget Tests', () {
    late ProviderContainer container;
    late MockGetPrayerTimes mockGetPrayerTimes;
    late MockGetCurrentPrayer mockGetCurrentPrayer;

    setUp(() {
      mockGetPrayerTimes = MockGetPrayerTimes();
      mockGetCurrentPrayer = MockGetCurrentPrayer();

      container = ProviderContainer(
        overrides: [
          getPrayerTimesUseCaseProvider.overrideWithValue(mockGetPrayerTimes),
          getCurrentPrayerUseCaseProvider
              .overrideWithValue(mockGetCurrentPrayer),
          settingsProvider.overrideWith((ref) {
            final mockRef = MockRef();
            final defaultSettings = const Settings(
              address: Address(
                  latitude: 28.7041,
                  longitude: 77.1025,
                  address: "Delhi, India"),
              adjustments: Adjustments(
                  fajr: 0, sunrise: 0, dhuhr: 0, asr: 0, maghrib: 0, isha: 0),
              madhab: "hanafi",
              calculationMethod: "Delhi",
              higherLatitude: "None",
              hasFetchedInitialLocation: true,
              isTutorialCompleted: true,
            );
            return SettingsNotifier(mockRef, defaultSettings);
          }),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    Widget createTestApp() {
      return UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          localizationsDelegates: const [
            S.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
          ],
          home: const HomePage(),
        ),
      );
    }

    testWidgets('should render page with basic structure', (tester) async {
      // Arrange
      when(() => mockGetPrayerTimes(any())).thenAnswer((_) async => Right([]));
      when(() => mockGetCurrentPrayer(any())).thenAnswer((_) async => Right(
            PrayerTime(
              name: PrayerName(english: "Dhuhr", arabic: "ظهر"),
              startTime: DateTime.now(),
              isCurrentPrayer: false,
            ),
          ));

      // Act
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('should show prayer cards when data available', (tester) async {
      // Arrange
      final testPrayers = [
        PrayerTime(
          name: PrayerName(english: "Fajr", arabic: "فجر"),
          startTime: DateTime(2023, 12, 1, 5, 30),
          isCurrentPrayer: false,
        ),
        PrayerTime(
          name: PrayerName(english: "Dhuhr", arabic: "ظهر"),
          startTime: DateTime(2023, 12, 1, 12, 15),
          isCurrentPrayer: true,
        ),
      ];

      when(() => mockGetPrayerTimes(any()))
          .thenAnswer((_) async => Right(testPrayers));
      when(() => mockGetCurrentPrayer(any()))
          .thenAnswer((_) async => Right(testPrayers[1]));

      // Act
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Fajr'), findsOneWidget);
      expect(find.text('05:30'), findsOneWidget);
      expect(find.text('Dhuhr'), findsOneWidget);
      expect(find.text('12:15'), findsOneWidget);
    });

    testWidgets('should display location information', (tester) async {
      // Arrange
      when(() => mockGetPrayerTimes(any())).thenAnswer((_) async => Right([]));
      when(() => mockGetCurrentPrayer(any())).thenAnswer((_) async => Right(
            PrayerTime(
              name: PrayerName(english: "Dhuhr", arabic: "ظهر"),
              startTime: DateTime.now(),
              isCurrentPrayer: false,
            ),
          ));

      // Act
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Delhi, India'), findsOneWidget);
      expect(find.byIcon(Icons.location_pin), findsOneWidget);
    });

    testWidgets('should display current time', (tester) async {
      // Arrange
      when(() => mockGetPrayerTimes(any())).thenAnswer((_) async => Right([]));
      when(() => mockGetCurrentPrayer(any())).thenAnswer((_) async => Right(
            PrayerTime(
              name: PrayerName(english: "Dhuhr", arabic: "ظهر"),
              startTime: DateTime.now(),
              isCurrentPrayer: false,
            ),
          ));

      // Act
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Assert
      final currentTime = DateFormat('hh:mm a').format(DateTime.now());
      expect(find.text(currentTime), findsOneWidget);
    });

    testWidgets('should handle date navigation buttons', (tester) async {
      // Arrange
      when(() => mockGetPrayerTimes(any())).thenAnswer((_) async => Right([]));
      when(() => mockGetCurrentPrayer(any())).thenAnswer((_) async => Right(
            PrayerTime(
              name: PrayerName(english: "Dhuhr", arabic: "ظهر"),
              startTime: DateTime.now(),
              isCurrentPrayer: false,
            ),
          ));

      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Find date navigation buttons
      final prevDateButton = find.text(DateFormat('dd MMM')
          .format(DateTime.now().subtract(const Duration(days: 1))));
      final todayButton =
          find.text(DateFormat('dd MMM yyyy').format(DateTime.now()));
      final nextDateButton = find.text(DateFormat('dd MMM')
          .format(DateTime.now().add(const Duration(days: 1))));

      // Assert buttons exist
      expect(prevDateButton, findsOneWidget);
      expect(todayButton, findsOneWidget);
      expect(nextDateButton, findsOneWidget);
    });

    testWidgets('should handle error state', (tester) async {
      // Arrange
      when(() => mockGetPrayerTimes(any())).thenThrow(ServerFailure());
      when(() => mockGetCurrentPrayer(any())).thenThrow(ServerFailure());

      // Act
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Assert
      expect(find.textContaining('Error:'), findsOneWidget);
    });
  });
}
