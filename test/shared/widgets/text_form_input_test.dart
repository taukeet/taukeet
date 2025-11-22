import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:taukeet/shared/widgets/text_form_input.dart';

void main() {
  group('TextFormInput Widget Tests', () {
    testWidgets('should render text field with required properties',
        (tester) async {
      // Arrange
      const testName = 'testField';
      const testLabel = 'Test Label';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormBuilder(
              child: TextFormInput(
                name: testName,
                label: testLabel,
              ),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(testLabel), findsOneWidget);
      expect(find.byType(FormBuilderTextField), findsOneWidget);
    });

    testWidgets('should display initial value when provided', (tester) async {
      // Arrange
      const testName = 'initialValueField';
      const testLabel = 'Initial Value Field';
      const initialValue = 'Pre-filled text';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormBuilder(
              child: TextFormInput(
                name: testName,
                label: testLabel,
                initialValue: initialValue,
              ),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(testLabel), findsOneWidget);
      final textField = tester
          .widget<FormBuilderTextField>(find.byType(FormBuilderTextField));
      expect(textField.initialValue, equals(initialValue));
    });

    testWidgets('should apply correct keyboard type', (tester) async {
      // Arrange
      const testName = 'emailField';
      const testLabel = 'Email Field';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormBuilder(
              child: TextFormInput(
                name: testName,
                label: testLabel,
                textInputType: TextInputType.emailAddress,
              ),
            ),
          ),
        ),
      );

      // Assert
      final textField = tester
          .widget<FormBuilderTextField>(find.byType(FormBuilderTextField));
      expect(textField.keyboardType, equals(TextInputType.emailAddress));
    });

    testWidgets('should accept text input', (tester) async {
      // Arrange
      const testName = 'inputField';
      const testLabel = 'Input Field';
      const testValue = 'User input';
      final formKey = GlobalKey<FormBuilderState>();

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormBuilder(
              key: formKey,
              child: TextFormInput(
                name: testName,
                label: testLabel,
              ),
            ),
          ),
        ),
      );

      // Enter text
      await tester.enterText(find.byType(FormBuilderTextField), testValue);

      // Assert
      expect(formKey.currentState?.fields[testName]?.value, equals(testValue));
    });

    testWidgets('should have correct input decoration', (tester) async {
      // Arrange
      const testName = 'decoratedField';
      const testLabel = 'Decorated Field';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormBuilder(
              child: TextFormInput(
                name: testName,
                label: testLabel,
              ),
            ),
          ),
        ),
      );

      // Assert
      final textField = tester
          .widget<FormBuilderTextField>(find.byType(FormBuilderTextField));
      expect(textField.decoration.label, isA<Text>());
      expect((textField.decoration.label as Text).data, equals(testLabel));

      final border = textField.decoration.border as OutlineInputBorder;
      expect(border.borderRadius,
          equals(const BorderRadius.all(Radius.circular(10))));
    });

    testWidgets('should handle different text input types', (tester) async {
      // Arrange
      const testCases = [
        {'name': 'textField', 'type': TextInputType.text},
        {'name': 'numberField', 'type': TextInputType.number},
        {'name': 'phoneField', 'type': TextInputType.phone},
        {'name': 'urlField', 'type': TextInputType.url},
      ];

      for (final testCase in testCases) {
        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: FormBuilder(
                child: TextFormInput(
                  name: testCase['name'] as String,
                  label: 'Test Field',
                  textInputType: testCase['type'] as TextInputType,
                ),
              ),
            ),
          ),
        );

        // Assert
        final textField = tester
            .widget<FormBuilderTextField>(find.byType(FormBuilderTextField));
        expect(textField.keyboardType, equals(testCase['type']));

        // Clean up for next test
        await tester.pumpWidget(Container());
      }
    });

    testWidgets('should handle special characters and Unicode input',
        (tester) async {
      // Arrange
      const testName = 'unicodeField';
      const testLabel = 'Unicode Field';
      const unicodeText = 'مرحبا بالعالم 🌍 Hello World!';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormBuilder(
              child: TextFormInput(
                name: testName,
                label: testLabel,
              ),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(FormBuilderTextField), unicodeText);

      // Assert
      final formKey = tester.state<FormBuilderState>(find.byType(FormBuilder));
      expect(formKey.fields[testName]?.value, equals(unicodeText));
    });

    testWidgets('should maintain state through rebuilds', (tester) async {
      // Arrange
      const testName = 'rebuildField';
      const testLabel = 'Rebuild Field';
      const testValue = 'Persistent value';
      final formKey = GlobalKey<FormBuilderState>();

      // Act - Initial render
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormBuilder(
              key: formKey,
              child: TextFormInput(
                name: testName,
                label: testLabel,
              ),
            ),
          ),
        ),
      );

      // Enter text
      await tester.enterText(find.byType(FormBuilderTextField), testValue);

      // Force rebuild with same form key
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormBuilder(
              key: formKey,
              child: TextFormInput(
                name: testName,
                label: testLabel,
              ),
            ),
          ),
        ),
      );

      // Assert
      expect(formKey.currentState?.fields[testName]?.value, equals(testValue));
    });

    testWidgets('should handle different input configurations', (tester) async {
      // Test different configurations
      const testCases = [
        {
          'name': 'emailField',
          'label': 'Email',
          'type': TextInputType.emailAddress,
          'required': true
        },
        {
          'name': 'phoneField',
          'label': 'Phone',
          'type': TextInputType.phone,
          'required': false
        },
        {
          'name': 'textField',
          'label': 'Text',
          'type': TextInputType.text,
          'required': null
        },
      ];

      for (final testCase in testCases) {
        final formKey = GlobalKey<FormBuilderState>();

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: FormBuilder(
                key: formKey,
                child: TextFormInput(
                  name: testCase['name'] as String,
                  label: testCase['label'] as String,
                  textInputType: testCase['type'] as TextInputType,
                  required: testCase['required'] as bool?,
                ),
              ),
            ),
          ),
        );

        // Assert
        expect(find.text(testCase['label'] as String), findsOneWidget);
        expect(find.byType(FormBuilderTextField), findsOneWidget);

        final textField = tester
            .widget<FormBuilderTextField>(find.byType(FormBuilderTextField));
        expect(textField.keyboardType, equals(testCase['type']));

        // Clean up for next test
        await tester.pumpWidget(Container());
      }
    });
  });
}
