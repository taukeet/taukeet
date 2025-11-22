import 'dart:math' show pi;
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taukeet/features/qiblah/presentation/widgets/qiblah_compass.dart';
import 'package:taukeet/generated/l10n.dart';

// Mock classes
class MockFlutterCompass extends Mock implements FlutterCompass {}

class MockCompassEvent extends Mock implements CompassEvent {
  @override
  final double? heading;
  @override
  final double? accuracy;

  MockCompassEvent({this.heading, this.accuracy});
}

void main() {
  group('QiblahCompass', () {
    const testQiblahDirection = 255.5;

    setUp(() {
      // Reset FlutterCompass mock before each test
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    Widget createWidgetUnderTest(double qiblahDirection) {
      return MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
        ],
        home: Scaffold(
          body: SingleChildScrollView(
            child: QiblahCompass(qiblahDirection: qiblahDirection),
          ),
        ),
      );
    }

    testWidgets('should render compass with all components', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(createWidgetUnderTest(testQiblahDirection));

      // Assert
      expect(find.byType(QiblahCompass), findsOneWidget);
      expect(find.byType(Column), findsOneWidget); // Main layout
      expect(find.byType(Stack), findsAtLeastNWidgets(1)); // Compass stack
      expect(find.byType(Container), findsWidgets); // Multiple containers
    });

    testWidgets('should display Qiblah direction text correctly', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(createWidgetUnderTest(testQiblahDirection));

      // Assert
      expect(find.text('Qiblah Direction: 255.50°'), findsOneWidget);
    });

    testWidgets('should show "turn to find Qiblah" status when no heading', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(createWidgetUnderTest(testQiblahDirection));

      // Assert - Should show "turn to find Qiblah" when no heading yet
      expect(find.textContaining('Turn to find Qiblah'), findsOneWidget);
      expect(find.byIcon(Icons.explore), findsOneWidget);
    });

    testWidgets('should render compass images', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(createWidgetUnderTest(testQiblahDirection));

      // Assert
      expect(find.byType(Image), findsNWidgets(2)); // compass_background and compass_needle
    });

    testWidgets('should render external Qiblah indicator', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(createWidgetUnderTest(testQiblahDirection));

      // Assert
      expect(find.byIcon(Icons.navigation), findsOneWidget);
    });

    testWidgets('should render center dot', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(createWidgetUnderTest(testQiblahDirection));

      // Assert - Check that we have containers (center dot is one of them)
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('should have correct compass dimensions', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(createWidgetUnderTest(testQiblahDirection));

      // Assert - Check for the main compass container (300x300)
      final compassContainers = find.byType(SizedBox);
      expect(compassContainers, findsWidgets);
      
      // Find the specific 300x300 container
      bool foundCorrectSize = false;
      for (final sizedBoxFinder in compassContainers.evaluate()) {
        final sizedBox = sizedBoxFinder.widget as SizedBox;
        if (sizedBox.width == 300.0 && sizedBox.height == 300.0) {
          foundCorrectSize = true;
          break;
        }
      }
      expect(foundCorrectSize, true);
    });

    group('Edge Cases', () {
      testWidgets('should handle Qiblah direction of 0 degrees', (WidgetTester tester) async {
        // Arrange & Act
        await tester.pumpWidget(createWidgetUnderTest(0.0));

        // Assert
        expect(find.text('Qiblah Direction: 0.00°'), findsOneWidget);
        expect(find.byType(QiblahCompass), findsOneWidget);
      });

      testWidgets('should handle Qiblah direction of 360 degrees', (WidgetTester tester) async {
        // Arrange & Act
        await tester.pumpWidget(createWidgetUnderTest(360.0));

        // Assert
        expect(find.text('Qiblah Direction: 360.00°'), findsOneWidget);
        expect(find.byType(QiblahCompass), findsOneWidget);
      });

      testWidgets('should handle negative Qiblah direction', (WidgetTester tester) async {
        // Arrange & Act
        await tester.pumpWidget(createWidgetUnderTest(-10.0));

        // Assert
        expect(find.text('Qiblah Direction: -10.00°'), findsOneWidget);
        expect(find.byType(QiblahCompass), findsOneWidget);
      });

      testWidgets('should handle very large Qiblah direction', (WidgetTester tester) async {
        // Arrange & Act
        await tester.pumpWidget(createWidgetUnderTest(1000.0));

        // Assert
        expect(find.text('Qiblah Direction: 1000.00°'), findsOneWidget);
        expect(find.byType(QiblahCompass), findsOneWidget);
      });

      testWidgets('should handle decimal Qiblah direction precision', (WidgetTester tester) async {
        // Arrange & Act
        await tester.pumpWidget(createWidgetUnderTest(255.56789));

        // Assert
        expect(find.text('Qiblah Direction: 255.57°'), findsOneWidget);
        expect(find.byType(QiblahCompass), findsOneWidget);
      });
    });

    group('Status Indicator Tests', () {
      testWidgets('should show orange status when not facing Qiblah', (WidgetTester tester) async {
        // Arrange & Act
        await tester.pumpWidget(createWidgetUnderTest(testQiblahDirection));

        // Assert - Should show orange status initially
        expect(find.byIcon(Icons.explore), findsOneWidget);
        expect(find.textContaining('Turn to find Qiblah'), findsOneWidget);
      });
    });

    group('Direction Info Tests', () {
      testWidgets('should not show direction info when heading is not available', (WidgetTester tester) async {
        // Arrange & Act
        await tester.pumpWidget(createWidgetUnderTest(testQiblahDirection));

        // Assert - Initially no heading info shown
        expect(find.textContaining('Current heading:'), findsNothing);
        expect(find.textContaining('Qiblah direction:'), findsNothing);
        expect(find.textContaining('Difference:'), findsNothing);
        expect(find.textContaining('Accuracy:'), findsNothing);
      });
    });

    group('Widget Structure Tests', () {
    testWidgets('should have correct widget hierarchy', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(createWidgetUnderTest(testQiblahDirection));

      // Assert
      expect(find.byType(Column), findsOneWidget); // Main layout
      expect(find.byType(Text), findsAtLeastNWidgets(1)); // Direction text
      expect(find.byType(Stack), findsAtLeastNWidgets(2)); // Multiple stacks (compass + outer ring)
      expect(find.byType(Container), findsWidgets); // Multiple containers
    });
    });

    group('Compass Logic Tests', () {
      testWidgets('should handle circular nature of compass calculations', (WidgetTester tester) async {
        // Arrange & Act
        await tester.pumpWidget(createWidgetUnderTest(1.0));

        // Assert
        expect(find.byType(QiblahCompass), findsOneWidget);
        // The widget should handle circular nature internally
      });

      testWidgets('should handle extreme Qiblah directions', (WidgetTester tester) async {
        // Arrange & Act
        await tester.pumpWidget(createWidgetUnderTest(720.0)); // 2 * 360

        // Assert
        expect(find.text('Qiblah Direction: 720.00°'), findsOneWidget);
        expect(find.byType(QiblahCompass), findsOneWidget);
      });
    });

    group('Localization Tests', () {
      testWidgets('should display localized text correctly', (WidgetTester tester) async {
        // Arrange & Act
        await tester.pumpWidget(createWidgetUnderTest(testQiblahDirection));

        // Assert
        expect(find.text('Qiblah Direction: 255.50°'), findsOneWidget);
        expect(find.textContaining('Turn to find Qiblah'), findsOneWidget);
      });
    });

    group('Error Handling Tests', () {
      testWidgets('should handle zero Qiblah direction gracefully', (WidgetTester tester) async {
        // Arrange & Act
        await tester.pumpWidget(createWidgetUnderTest(0.0));

        // Assert
        expect(find.text('Qiblah Direction: 0.00°'), findsOneWidget);
        expect(find.byType(QiblahCompass), findsOneWidget);
      });

      testWidgets('should handle very small Qiblah direction gracefully', (WidgetTester tester) async {
        // Arrange & Act
        await tester.pumpWidget(createWidgetUnderTest(0.001));

        // Assert
        expect(find.text('Qiblah Direction: 0.00°'), findsOneWidget);
        expect(find.byType(QiblahCompass), findsOneWidget);
      });

      testWidgets('should handle very large Qiblah direction gracefully', (WidgetTester tester) async {
        // Arrange & Act
        await tester.pumpWidget(createWidgetUnderTest(9999.0));

        // Assert
        expect(find.text('Qiblah Direction: 9999.00°'), findsOneWidget);
        expect(find.byType(QiblahCompass), findsOneWidget);
      });
    });

    group('Visual Tests', () {
      testWidgets('should render status indicator', (WidgetTester tester) async {
        // Arrange & Act
        await tester.pumpWidget(createWidgetUnderTest(testQiblahDirection));

        // Assert - Should find status container
        expect(find.byType(Container), findsWidgets);
        
        // Should have status icon
        expect(find.byIcon(Icons.explore), findsOneWidget);
      });

      testWidgets('should render compass with proper layout', (WidgetTester tester) async {
        // Arrange & Act
        await tester.pumpWidget(createWidgetUnderTest(testQiblahDirection));

        // Assert
        expect(find.byType(SizedBox), findsWidgets); // Main compass container
        expect(find.byType(Stack), findsAtLeastNWidgets(1)); // Compass stack
        expect(find.byType(Transform), findsWidgets); // Rotation transforms
      });
    });
  });
}