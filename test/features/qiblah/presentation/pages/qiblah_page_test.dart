import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taukeet/features/location/domain/entities/address.dart';
import 'package:taukeet/features/qiblah/presentation/pages/qiblah_page.dart';
import 'package:taukeet/features/qiblah/presentation/providers/qiblah_provider.dart';
import 'package:taukeet/features/settings/presentation/providers/locale_provider.dart';
import 'package:taukeet/shared/widgets/primary_button.dart';
import 'package:taukeet/shared/widgets/secondary_button.dart';
import 'package:taukeet/features/qiblah/presentation/widgets/qiblah_compass.dart';
import 'package:taukeet/generated/l10n.dart';

// Mock classes
class MockQiblahNotifier extends StateNotifier<QiblahState>
    with Mock
    implements QiblahNotifier {
  MockQiblahNotifier(super.state);

  @override
  Future<void> init() async {}

  @override
  Future<bool> fetchLocation(String locale) async => false;

  QiblahState get currentState => state;
}

class MockLocaleNotifier extends StateNotifier<LocaleState>
    with Mock
    implements LocaleNotifier {
  MockLocaleNotifier(super.state);

  Locale get locale => state.locale;

  @override
  Future<void> setLocale(Locale locale) async {}
}

void main() {
  group('QiblahPage', () {
    late MockQiblahNotifier mockQiblahNotifier;
    late MockLocaleNotifier mockLocaleNotifier;
    late ProviderContainer container;

    setUp(() {
      mockQiblahNotifier = MockQiblahNotifier(QiblahState());
      mockLocaleNotifier = MockLocaleNotifier(LocaleState(
        locale: const Locale('en', ''),
        supportedLocales: const [Locale('en', ''), Locale('es', '')],
      ));

      container = ProviderContainer(
        overrides: [
          qiblahProvider.overrideWith((ref) => mockQiblahNotifier),
          localeProvider.overrideWith((ref) => mockLocaleNotifier),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    Widget createWidgetUnderTest() {
      return UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.supportedLocales,
          home: const Scaffold(
            body: QiblahPage(),
          ),
        ),
      );
    }

    group('Page Rendering Tests', () {
      testWidgets('should render page with all components',
          (WidgetTester tester) async {
        // Arrange & Act
        await tester.pumpWidget(createWidgetUnderTest());

        // Assert
        expect(find.byType(QiblahPage), findsOneWidget);
        expect(find.byType(SingleChildScrollView), findsOneWidget);
      });

      testWidgets('should show location not set when no address',
          (WidgetTester tester) async {
        // Arrange
        mockQiblahNotifier.state = QiblahState(
          address: null,
          qiblahDirection: null,
        );

        // Act
        await tester.pumpWidget(createWidgetUnderTest());

        // Assert
        expect(find.byType(PrimaryButton), findsOneWidget);
        expect(find.byType(SecondaryButton), findsNothing);
      });

      testWidgets('should show location info when address available',
          (WidgetTester tester) async {
        // Arrange
        const testAddress = Address(
          latitude: 28.7041,
          longitude: 77.1025,
          address: 'Delhi, India',
        );
        mockQiblahNotifier.state = QiblahState(
          address: testAddress,
          qiblahDirection: null,
        );

        // Act
        await tester.pumpWidget(createWidgetUnderTest());

        // Assert
        expect(find.text('Delhi, India'), findsOneWidget);
        expect(find.textContaining('28.7041'), findsOneWidget);
        expect(find.textContaining('77.1025'), findsOneWidget);
      });

      testWidgets('should show compass when Qiblah direction available',
          (WidgetTester tester) async {
        // Arrange
        mockQiblahNotifier.state = QiblahState(
          address: Address(
            latitude: 24.8607,
            longitude: 67.0011,
            address: 'Delhi, India',
          ),
          qiblahDirection: 255.5,
        );

        // Act
        await tester.pumpWidget(createWidgetUnderTest());

        // Assert
        expect(find.byType(QiblahCompass), findsOneWidget);
      });

      testWidgets('should show loader when calculating',
          (WidgetTester tester) async {
        // Arrange
        mockQiblahNotifier.state = QiblahState(
          address: Address(
            latitude: 24.8607,
            longitude: 67.0011,
            address: 'Delhi, India',
          ),
          qiblahDirection: null, // No direction yet = calculating
        );

        // Act
        await tester.pumpWidget(createWidgetUnderTest());

        // Assert
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.byType(QiblahCompass), findsNothing);
      });
    });

    group('Button Interaction Tests', () {
      testWidgets('should have primary button when no location',
          (WidgetTester tester) async {
        // Arrange
        mockQiblahNotifier.state = QiblahState(
          address: null,
          qiblahDirection: null,
        );

        // Act
        await tester.pumpWidget(createWidgetUnderTest());

        // Assert
        expect(find.byType(PrimaryButton), findsOneWidget);
        expect(find.byType(SecondaryButton), findsNothing);
      });

      testWidgets('should have secondary button when location available',
          (WidgetTester tester) async {
        // Arrange
        const testAddress = Address(
          latitude: 28.7041,
          longitude: 77.1025,
          address: 'Delhi, India',
        );
        mockQiblahNotifier.state = QiblahState(
          address: testAddress,
          qiblahDirection: 255.5,
        );

        // Act
        await tester.pumpWidget(createWidgetUnderTest());

        // Assert
        expect(find.byType(PrimaryButton), findsNothing);
        expect(find.byType(SecondaryButton), findsOneWidget);
      });

      testWidgets('should disable primary button when fetching',
          (WidgetTester tester) async {
        // Arrange
        mockQiblahNotifier.state = QiblahState(
          isFetchingLocation: true,
          address: null,
          qiblahDirection: null,
        );

        // Act
        await tester.pumpWidget(createWidgetUnderTest());

        // Assert
        final primaryButton =
            tester.widget<PrimaryButton>(find.byType(PrimaryButton));
        expect(primaryButton.onPressed, isNull);
      });

      testWidgets('should disable secondary button when fetching',
          (WidgetTester tester) async {
        // Arrange
        const testAddress = Address(
          latitude: 28.7041,
          longitude: 77.1025,
          address: 'Delhi, India',
        );
        mockQiblahNotifier.state = QiblahState(
          isFetchingLocation: true,
          address: testAddress,
          qiblahDirection: 255.5,
        );

        // Act
        await tester.pumpWidget(createWidgetUnderTest());

        // Assert
        final secondaryButton =
            tester.widget<SecondaryButton>(find.byType(SecondaryButton));
        expect(secondaryButton.onPressed, isNull);
      });
    });

    group('State Management Tests', () {
      testWidgets('should react to state changes', (WidgetTester tester) async {
        // Arrange - Initial state
        mockQiblahNotifier.state = QiblahState(
          address: null,
          qiblahDirection: null,
        );

        await tester.pumpWidget(createWidgetUnderTest());

        // Act - Change state
        const newAddress = Address(
          latitude: 28.7041,
          longitude: 77.1025,
          address: 'Delhi, India',
        );
        mockQiblahNotifier.state = QiblahState(
          address: newAddress,
          qiblahDirection: 255.5,
        );

        await tester.pumpWidget(createWidgetUnderTest());

        // Assert
        expect(find.text('Delhi, India'), findsOneWidget);
        expect(find.byType(QiblahCompass), findsOneWidget);
      });
    });

    group('Layout Tests', () {
      testWidgets('should have correct page structure',
          (WidgetTester tester) async {
        // Arrange & Act
        await tester.pumpWidget(createWidgetUnderTest());

        // Assert
        expect(find.byType(SingleChildScrollView), findsOneWidget);
        expect(find.byType(Column), findsOneWidget); // Main content column
      });

      testWidgets('should have correct padding', (WidgetTester tester) async {
        // Arrange & Act
        await tester.pumpWidget(createWidgetUnderTest());

        // Assert
        final scrollable = find.byType(SingleChildScrollView);
        expect(scrollable, findsOneWidget);

        final scrollableWidget =
            tester.widget<SingleChildScrollView>(scrollable);
        expect(scrollableWidget.padding,
            const EdgeInsets.symmetric(horizontal: 16, vertical: 24));
      });

      testWidgets('should center content', (WidgetTester tester) async {
        // Arrange & Act
        await tester.pumpWidget(createWidgetUnderTest());
        // Assert
        final centerWidget = find.byType(Center);
        expect(centerWidget, findsOneWidget);
      });
    });

    group('Integration Tests', () {
      testWidgets('should handle complete flow from no location to compass',
          (WidgetTester tester) async {
        // Arrange - Initial state
        mockQiblahNotifier.state = QiblahState(
          address: null,
          qiblahDirection: null,
        );

        await tester.pumpWidget(createWidgetUnderTest());

        // Assert - Should show location not set
        expect(find.byType(PrimaryButton), findsOneWidget);
        expect(find.byType(QiblahCompass), findsNothing);

        // Act - Simulate successful location fetch
        const testAddress = Address(
          latitude: 28.7041,
          longitude: 77.1025,
          address: 'Delhi, India',
        );
        mockQiblahNotifier.state = QiblahState(
          address: testAddress,
          qiblahDirection: 255.5,
        );

        await tester.pumpWidget(createWidgetUnderTest());

        // Assert - Should show compass
        expect(find.byType(PrimaryButton), findsNothing);
        expect(find.byType(SecondaryButton), findsOneWidget);
        expect(find.byType(QiblahCompass), findsOneWidget);
      });

      testWidgets('should handle loading states during fetch',
          (WidgetTester tester) async {
        // Arrange
        mockQiblahNotifier.state = QiblahState(
          isFetchingLocation: true,
          address: null,
          qiblahDirection: null,
        );

        // Act
        await tester.pumpWidget(createWidgetUnderTest());

        // Assert
        expect(find.byType(PrimaryButton), findsOneWidget);
        expect(find.byType(SecondaryButton), findsNothing);

        final primaryButton =
            tester.widget<PrimaryButton>(find.byType(PrimaryButton));
        expect(primaryButton.onPressed, isNull);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle empty address gracefully',
          (WidgetTester tester) async {
        // Arrange
        mockQiblahNotifier.state = QiblahState(
          address: Address(
            latitude: 0.0,
            longitude: 0.0,
            address: '',
          ),
          qiblahDirection: 255.5,
        );

        // Act
        await tester.pumpWidget(createWidgetUnderTest());

        // Assert
        expect(find.byType(QiblahCompass), findsOneWidget);
        expect(find.byType(SecondaryButton), findsOneWidget);
      });

      testWidgets('should handle very long address text',
          (WidgetTester tester) async {
        // Arrange
        const longAddress =
            'Very long location name that might wrap to multiple lines in the UI and should be handled gracefully by the text widget';
        mockQiblahNotifier.state = QiblahState(
          address: Address(
            latitude: 24.8607,
            longitude: 67.0011,
            address: longAddress,
          ),
          qiblahDirection: 255.5,
        );

        // Act
        await tester.pumpWidget(createWidgetUnderTest());

        // Assert
        expect(find.text(longAddress), findsOneWidget);
        expect(find.byType(QiblahCompass), findsOneWidget);
      });

      testWidgets('should handle extreme coordinates',
          (WidgetTester tester) async {
        // Arrange
        mockQiblahNotifier.state = QiblahState(
          address: Address(
            latitude: 90.0, // North Pole
            longitude: 0.0,
            address: 'North Pole',
          ),
          qiblahDirection: 180.0,
        );

        // Act
        await tester.pumpWidget(createWidgetUnderTest());

        // Assert
        expect(find.text('North Pole'), findsOneWidget);
        expect(find.byType(QiblahCompass), findsOneWidget);
      });
    });
  });
}
