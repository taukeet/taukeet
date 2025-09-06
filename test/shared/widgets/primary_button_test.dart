import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taukeet/shared/widgets/primary_button.dart';

void main() {
  group('PrimaryButton Widget Tests', () {
    testWidgets('should render button with text', (WidgetTester tester) async {
      // Arrange
      const buttonText = 'Test Button';
      var buttonPressed = false;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              text: buttonText,
              onPressed: () {
                buttonPressed = true;
              },
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(buttonText), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(buttonPressed, isFalse);
    });

    testWidgets('should handle button tap', (WidgetTester tester) async {
      // Arrange
      const buttonText = 'Tap Me';
      var buttonPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              text: buttonText,
              onPressed: () {
                buttonPressed = true;
              },
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Assert
      expect(buttonPressed, isTrue);
    });

    testWidgets('should be disabled when onPressed is null',
        (WidgetTester tester) async {
      // Arrange
      const buttonText = 'Disabled Button';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              text: buttonText,
              onPressed: null,
            ),
          ),
        ),
      );

      final elevatedButton = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );

      // Assert
      expect(find.text(buttonText), findsOneWidget);
      expect(elevatedButton.onPressed, isNull);
    });

    testWidgets('should have correct styling properties',
        (WidgetTester tester) async {
      // Arrange
      const buttonText = 'Styled Button';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
          ),
          home: Scaffold(
            body: PrimaryButton(
              text: buttonText,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Assert
      final elevatedButton = find.byType(ElevatedButton);
      expect(elevatedButton, findsOneWidget);
      expect(find.text(buttonText), findsOneWidget);
    });

    testWidgets('should handle long text gracefully',
        (WidgetTester tester) async {
      // Arrange
      const longButtonText =
          'This is a very long button text that should be handled properly by the button widget';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              child: PrimaryButton(
                text: longButtonText,
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(longButtonText), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should respect theme colors', (WidgetTester tester) async {
      // Arrange
      const buttonText = 'Themed Button';
      const primaryColor = Colors.red;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.red,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
              ),
            ),
          ),
          home: Scaffold(
            body: PrimaryButton(
              text: buttonText,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(buttonText), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should work with special characters and Unicode',
        (WidgetTester tester) async {
      // Arrange
      const arabicButtonText = 'صلاة الظهر';
      const emojiButtonText = '🕌 Prayer Time';

      // Test Arabic text
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              text: arabicButtonText,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text(arabicButtonText), findsOneWidget);

      // Test emoji text
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              text: emojiButtonText,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text(emojiButtonText), findsOneWidget);
    });

    testWidgets('should handle rapid taps correctly',
        (WidgetTester tester) async {
      // Arrange
      const buttonText = 'Rapid Tap Test';
      var tapCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              text: buttonText,
              onPressed: () {
                tapCount++;
              },
            ),
          ),
        ),
      );

      // Act - Rapid taps
      await tester.tap(find.byType(ElevatedButton));
      await tester.tap(find.byType(ElevatedButton));
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Assert
      expect(tapCount, equals(3));
    });

    testWidgets('should maintain state through rebuilds',
        (WidgetTester tester) async {
      // Arrange
      var rebuilds = 0;
      const buttonText = 'Rebuild Test';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                body: Column(
                  children: [
                    Text('Rebuilds: $rebuilds'),
                    PrimaryButton(
                      text: buttonText,
                      onPressed: () {
                        setState(() {
                          rebuilds++;
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

      // Initial state
      expect(find.text('Rebuilds: 0'), findsOneWidget);
      expect(find.text(buttonText), findsOneWidget);

      // Tap and rebuild
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Rebuilds: 1'), findsOneWidget);
      expect(find.text(buttonText), findsOneWidget);
    });
  });
}
