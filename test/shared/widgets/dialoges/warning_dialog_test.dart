import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taukeet/shared/widgets/dialoges/warning_dialog.dart';

void main() {
  group('WarningDialog Widget Tests', () {
    testWidgets('should render dialog with required properties', (tester) async {
      // Arrange
      const testTitle = 'Warning Title';
      const testMessage = 'This is a warning message';
      final testActions = [
        TextButton(
          onPressed: () {},
          child: const Text('OK'),
        ),
      ];

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => WarningDialog(
                      title: testTitle,
                      message: testMessage,
                      actions: testActions,
                    ),
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      // Tap to show dialog
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text(testTitle), findsOneWidget);
      expect(find.text(testMessage), findsOneWidget);
      expect(find.byIcon(Icons.warning_rounded), findsOneWidget);
      expect(find.byType(Dialog), findsOneWidget);
    });

    testWidgets('should display actions correctly', (tester) async {
      // Arrange
      const testTitle = 'Action Test';
      const testMessage = 'Testing actions';
      final testActions = [
        TextButton(
          onPressed: () {},
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Confirm'),
        ),
      ];

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => WarningDialog(
                      title: testTitle,
                      message: testMessage,
                      actions: testActions,
                    ),
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Confirm'), findsOneWidget);
      expect(find.byType(Row), findsNWidgets(2)); // Main row with icon/title, and actions row
    });

    testWidgets('should handle action button taps', (tester) async {
      // Arrange
      bool cancelTapped = false;
      bool confirmTapped = false;
      const testTitle = 'Tap Test';
      const testMessage = 'Testing button taps';
      final testActions = [
        TextButton(
          onPressed: () => cancelTapped = true,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => confirmTapped = true,
          child: const Text('Confirm'),
        ),
      ];

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => WarningDialog(
                      title: testTitle,
                      message: testMessage,
                      actions: testActions,
                    ),
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Tap confirm button
      await tester.tap(find.text('Confirm'));
      await tester.pump();

      // Assert
      expect(confirmTapped, isTrue);
      expect(cancelTapped, isFalse);
    });

    testWidgets('should have correct layout structure', (tester) async {
      // Arrange
      const testTitle = 'Layout Test';
      const testMessage = 'Testing layout';
      final testActions = [
        TextButton(
          onPressed: () {},
          child: const Text('OK'),
        ),
      ];

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => WarningDialog(
                      title: testTitle,
                      message: testMessage,
                      actions: testActions,
                    ),
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Row), findsAtLeastNWidgets(2)); // Title row and actions row
      expect(find.byType(Container), findsAtLeastNWidgets(1));
      expect(find.byType(Icon), findsOneWidget); // Warning icon
    });

    testWidgets('should apply correct styling', (tester) async {
      // Arrange
      const testTitle = 'Style Test';
      const testMessage = 'Testing styles';
      final testActions = [
        TextButton(
          onPressed: () {},
          child: const Text('OK'),
        ),
      ];

      // Act
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: const ColorScheme.light(
              surface: Colors.white,
            ),
          ),
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => WarningDialog(
                      title: testTitle,
                      message: testMessage,
                      actions: testActions,
                    ),
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Assert
      final containerWidget = tester.widget<Container>(find.byType(Container).first);
      final decoration = containerWidget.decoration as BoxDecoration;
      expect(decoration.borderRadius, equals(const BorderRadius.all(Radius.circular(12.0))));

      final titleText = tester.widget<Text>(find.text(testTitle));
      expect(titleText.style?.fontSize, equals(20));
      expect(titleText.style?.fontWeight, equals(FontWeight.w500));

      final messageText = tester.widget<Text>(find.text(testMessage));
      expect(messageText.style?.fontSize, equals(16));
    });

    testWidgets('should handle text content properly', (tester) async {
      // Arrange
      const testTitle = 'Warning';
      const testMessage = 'This is a test message.';
      final testActions = [
        TextButton(
          onPressed: () {},
          child: const Text('OK'),
        ),
      ];

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WarningDialog(
              title: testTitle,
              message: testMessage,
              actions: testActions,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(testTitle), findsOneWidget);
      expect(find.text(testMessage), findsOneWidget);
      expect(find.byIcon(Icons.warning_rounded), findsOneWidget);
    });

    testWidgets('should handle empty actions list', (tester) async {
      // Arrange
      const testTitle = 'Empty Actions';
      const testMessage = 'No actions provided';
      final testActions = <Widget>[]; // Empty list

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => WarningDialog(
                      title: testTitle,
                      message: testMessage,
                      actions: testActions,
                    ),
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text(testTitle), findsOneWidget);
      expect(find.text(testMessage), findsOneWidget);
      // Should still render the dialog structure even with empty actions
      expect(find.byType(Dialog), findsOneWidget);
    });

    testWidgets('should handle multiple actions with proper spacing', (tester) async {
      // Arrange
      const testTitle = 'Multiple Actions';
      const testMessage = 'Testing multiple action buttons';
      final testActions = [
        TextButton(onPressed: () {}, child: const Text('Action 1')),
        TextButton(onPressed: () {}, child: const Text('Action 2')),
        ElevatedButton(onPressed: () {}, child: const Text('Action 3')),
      ];

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => WarningDialog(
                      title: testTitle,
                      message: testMessage,
                      actions: testActions,
                    ),
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Action 1'), findsOneWidget);
      expect(find.text('Action 2'), findsOneWidget);
      expect(find.text('Action 3'), findsOneWidget);

      // Check that actions are in a Row with MainAxisAlignment.end
      final actionsRow = tester.widget<Row>(find.byType(Row).last);
      expect(actionsRow.mainAxisAlignment, equals(MainAxisAlignment.end));
    });

    testWidgets('should maintain accessibility features', (tester) async {
      // Arrange
      const testTitle = 'Accessibility Test';
      const testMessage = 'Testing accessibility';
      final testActions = [
        TextButton(
          onPressed: () {},
          child: const Text('Close'),
        ),
      ];

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => WarningDialog(
                      title: testTitle,
                      message: testMessage,
                      actions: testActions,
                    ),
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byIcon(Icons.warning_rounded), findsOneWidget); // Visual warning indicator
      expect(find.byType(TextButton), findsOneWidget); // Accessible button
      expect(find.text(testTitle), findsOneWidget); // Screen reader text
      expect(find.text(testMessage), findsOneWidget); // Screen reader text
    });
  });
}