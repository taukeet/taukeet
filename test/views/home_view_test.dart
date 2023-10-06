import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taukeet/src/blocs/home/home_cubit.dart';
import 'package:taukeet/src/blocs/settings/settings_cubit.dart';
import 'package:taukeet/src/entities/prayer_name.dart';
import 'package:taukeet/src/entities/prayer_time.dart';
import 'package:taukeet/src/views/home_view.dart';

import '../helpers/hydrated_bloc.dart';

class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

class MockSettingsCubit extends MockCubit<SettingsState>
    implements SettingsCubit {}

void main() {
  initHydratedStorage();

  // Create mock Cubits
  late MockHomeCubit mockHomeCubit;
  late MockSettingsCubit mockSettingsCubit;
  late SettingsState mockSettingsState;
  late HomeState mockHomeState;

  // Set up the mock Cubits and other dependencies before each test
  setUp(() {
    mockHomeCubit = MockHomeCubit();
    mockSettingsCubit = MockSettingsCubit();
    mockSettingsState = const SettingsState();
    mockHomeState = HomeState(dateTime: DateTime.now());

    when(() => mockSettingsCubit.state)
        .thenReturn(mockSettingsState.copyWith(isTutorialCompleted: true));
    when(() => mockHomeCubit.state).thenReturn(
      HomeState(
        dateTime: DateTime.now(),
        currentPrayer: PrayerTime(
          name: PrayerName(english: "Fajr", arabic: "فجر"),
          startTime: DateTime.now(),
        ),
      ),
    );
    when(() => mockHomeCubit.changeToNextDate()).thenAnswer((_) {
      mockHomeCubit.emit(
        mockHomeState.copyWith(
          dateTime: mockHomeState.dateTime.add(
            const Duration(days: 1),
          ),
        ),
      );
    });
  });

  group("HomeView", () {
    testWidgets('renders HomeView', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<HomeCubit>(
                create: (context) => mockHomeCubit,
              ),
              BlocProvider<SettingsCubit>(
                create: (context) => mockSettingsCubit,
              ),
            ],
            child: const HomeView(),
          ),
        ),
      );

      // Verify that HomeView is rendered
      expect(find.byType(HomeView), findsOneWidget);

      // Verify the display of the current prayer's name
      expect(find.text("Fajr"), findsOneWidget); // English name
      expect(find.text("فجر"), findsOneWidget); // Arabic name
    });
  });
}
