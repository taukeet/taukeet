import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taukeet/shared/widgets/setting_tile.dart';

void main() {
  group('SettingTile Widget Tests', () {
    testWidgets('should render tile with required properties', (tester) async {
      // Arrange
      const testText = 'Test Setting';
      const testIcon = Icons.settings;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingTile(
              text: testText,
              icon: testIcon,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(testText), findsOneWidget);
      expect(find.byIcon(testIcon), findsOneWidget);
      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('should handle tap when onPressed is provided', (tester) async {
      // Arrange
      bool tapped = false;
      const testText = 'Tappable Setting';
      const testIcon = Icons.touch_app;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingTile(
              text: testText,
              icon: testIcon,
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(InkWell));
      await tester.pump();

      // Assert
      expect(tapped, isTrue);
    });

    testWidgets('should display secondary text when provided', (tester) async {
      // Arrange
      const testText = 'Main Setting';
      const secondaryText = 'Additional info';
      const testIcon = Icons.info;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingTile(
              text: testText,
              icon: testIcon,
              secodaryText: secondaryText,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(testText), findsOneWidget);
      expect(find.text(secondaryText), findsOneWidget);
      expect(find.byIcon(testIcon), findsOneWidget);
    });

    testWidgets('should not display secondary text when null', (tester) async {
      // Arrange
      const testText = 'Main Setting Only';
      const testIcon = Icons.settings;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingTile(
              text: testText,
              icon: testIcon,
              secodaryText: null,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(testText), findsOneWidget);
      expect(find.byIcon(testIcon), findsOneWidget);
      // Should not find any secondary text
      expect(find.byType(Container), findsNWidgets(2)); // One for the main container, one for the empty secondary
    });

    testWidgets('should have correct layout structure', (tester) async {
      // Arrange
      const testText = 'Layout Test';
      const testIcon = Icons.grid_on;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingTile(
              text: testText,
              icon: testIcon,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(Column), findsNWidgets(2)); // Main column and expanded column
      expect(find.byType(Expanded), findsOneWidget);
    });

    testWidgets('should apply correct styling', (tester) async {
      // Arrange
      const testText = 'Styled Setting';
      const testIcon = Icons.palette;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
            ),
          ),
          home: Scaffold(
            body: SettingTile(
              text: testText,
              icon: testIcon,
            ),
          ),
        ),
      );

      // Assert
      final iconWidget = tester.widget<Icon>(find.byIcon(testIcon));
      expect(iconWidget.color, equals(Colors.blue));
      expect(iconWidget.size, equals(24));
    });

    testWidgets('should have correct padding and border', (tester) async {
      // Arrange
      const testText = 'Padding Test';
      const testIcon = Icons.border_all;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingTile(
              text: testText,
              icon: testIcon,
            ),
          ),
        ),
      );

      // Assert
      final containerWidget = tester.widget<Container>(find.byType(Container).first);
      final padding = containerWidget.padding as EdgeInsets;
      expect(padding.top, equals(14.0));
      expect(padding.bottom, equals(14.0));
      expect(padding.left, equals(4.0));
      expect(padding.right, equals(4.0));

      final decoration = containerWidget.decoration as BoxDecoration;
      final border = decoration.border as Border;
      expect(border.bottom.color, equals(Colors.black12));
    });

    testWidgets('should handle long text gracefully', (tester) async {
      // Arrange
      const longText = 'This is a very long setting title that should wrap properly within the available space';
      const testIcon = Icons.text_fields;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 300,
              child: SettingTile(
                text: longText,
                icon: testIcon,
              ),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(longText), findsOneWidget);
      expect(find.byIcon(testIcon), findsOneWidget);
    });

    testWidgets('should apply secondary text styling correctly', (tester) async {
      // Arrange
      const testText = 'Main Text';
      const secondaryText = 'Secondary description';
      const testIcon = Icons.description;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: Colors.green,
            ),
          ),
          home: Scaffold(
            body: SettingTile(
              text: testText,
              icon: testIcon,
              secodaryText: secondaryText,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(testText), findsOneWidget);
      expect(find.text(secondaryText), findsOneWidget);

      // Find the secondary text widget
      final textWidgets = tester.widgetList<Text>(find.byType(Text));
      final secondaryTextWidget = textWidgets.last; // Should be the secondary text
      expect(secondaryTextWidget.style?.fontSize, equals(12));
      expect(secondaryTextWidget.style?.color?.opacity, equals(0.6));
    });

    testWidgets('should maintain accessibility', (tester) async {
      // Arrange
      const testText = 'Accessible Setting';
      const testIcon = Icons.accessibility;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingTile(
              text: testText,
              icon: testIcon,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(InkWell), findsOneWidget); // InkWell provides accessibility
      expect(find.byIcon(testIcon), findsOneWidget);
      expect(find.text(testText), findsOneWidget);
    });
  });
}