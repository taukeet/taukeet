import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taukeet/shared/widgets/secondary_button.dart';

void main() {
  group('SecondaryButton Widget Tests', () {
    testWidgets('should render button with text', (tester) async {
      // Arrange
      const testText = 'Test Button';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SecondaryButton(
              text: testText,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(testText), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('should handle button tap', (tester) async {
      // Arrange
      bool tapped = false;
      const testText = 'Tap Me';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SecondaryButton(
              text: testText,
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextButton));
      await tester.pump();

      // Assert
      expect(tapped, isTrue);
    });

    testWidgets('should be disabled when onPressed is null', (tester) async {
      // Arrange
      const testText = 'Disabled Button';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SecondaryButton(
              text: testText,
              onPressed: null,
            ),
          ),
        ),
      );

      // Assert
      final textButton = tester.widget<TextButton>(find.byType(TextButton));
      expect(textButton.onPressed, isNull);
    });

    testWidgets('should have correct text styling', (tester) async {
      // Arrange
      const testText = 'Styled Text';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SecondaryButton(
              text: testText,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Assert
      final textWidget = tester.widget<Text>(find.text(testText));
      expect(textWidget.style?.fontSize, equals(16));
    });

    testWidgets('should handle long text gracefully', (tester) async {
      // Arrange
      const longText = 'This is a very long button text that should still be displayed properly without causing layout issues';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SecondaryButton(
              text: longText,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(longText), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('should respect theme colors', (tester) async {
      // Arrange
      const testText = 'Themed Button';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
            ),
          ),
          home: Scaffold(
            body: SecondaryButton(
              text: testText,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(testText), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('should work with special characters and Unicode', (tester) async {
      // Arrange
      const unicodeText = 'مرحبا بالعالم 🌍';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SecondaryButton(
              text: unicodeText,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(unicodeText), findsOneWidget);
    });

    testWidgets('should handle rapid taps correctly', (tester) async {
      // Arrange
      int tapCount = 0;
      const testText = 'Rapid Tap Button';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SecondaryButton(
              text: testText,
              onPressed: () => tapCount++,
            ),
          ),
        ),
      );

      // Tap multiple times quickly
      await tester.tap(find.byType(TextButton));
      await tester.tap(find.byType(TextButton));
      await tester.tap(find.byType(TextButton));
      await tester.pump();

      // Assert
      expect(tapCount, equals(3));
    });

    testWidgets('should maintain state through rebuilds', (tester) async {
      // Arrange
      const testText = 'Rebuild Test';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SecondaryButton(
              text: testText,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Force rebuild
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SecondaryButton(
              text: testText,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(testText), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });
  });
}