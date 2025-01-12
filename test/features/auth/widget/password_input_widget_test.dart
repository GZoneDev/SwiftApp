import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:receptico/features/auth/widget/widget.dart';

void main() {
  group('PasswordInputWidget Tests', () {
    group('UI Tests', () {
      testWidgets('Displays placeholder text', (WidgetTester tester) async {
        // Arrange
        const placeholder = 'Enter your password';

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PasswordInputWidget(
                placeholder: placeholder,
              ),
            ),
          ),
        );

        // Assert
        expect(find.text(placeholder), findsOneWidget);
      });

      testWidgets('Toggles password visibility icon',
          (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PasswordInputWidget(),
            ),
          ),
        );

        // Assert initial state
        expect(find.byIcon(CupertinoIcons.eye_slash), findsOneWidget);

        // Act: tap the toggle visibility button
        await tester.tap(find.byIcon(CupertinoIcons.eye_slash));
        await tester.pump();

        // Assert state after toggle
        expect(find.byIcon(CupertinoIcons.eye), findsOneWidget);
      });

      testWidgets('Password swiched visibility text',
          (WidgetTester tester) async {
        // Arrange
        final controller = TextEditingController();
        final inputText = 'VisibilyText';
        controller.text = inputText;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PasswordInputWidget(controller: controller),
            ),
          ),
        );

        // Act
        final textField = tester.widget<TextField>(find.byType(TextField));

        // Assert: text is visible
        expect(textField.obscureText, isTrue);

        // Act
        await tester.tap(find.byIcon(CupertinoIcons.eye_slash));
        await tester.pump();

        // Assert: text isn't visible
        final updatedTextField =
            tester.widget<TextField>(find.byType(TextField));
        expect(updatedTextField.obscureText, isFalse);

        // Assert
        expect(find.text(inputText), findsOneWidget);

        // Act
        await tester.tap(find.byIcon(CupertinoIcons.eye));
        await tester.pump();

        // Assert: text is visible
        final revertedTextField =
            tester.widget<TextField>(find.byType(TextField));
        expect(revertedTextField.obscureText, isTrue);
      });

      testWidgets('Displays error text when provided',
          (WidgetTester tester) async {
        // Arrange
        const errorText = 'Password is required';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PasswordInputWidget(
                error: errorText,
              ),
            ),
          ),
        );

        // Assert
        expect(find.text(errorText), findsOneWidget);
      });

      testWidgets('Displays helpWidget text when provided',
          (WidgetTester tester) async {
        // Arrange
        const helpText = 'Help text';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PasswordInputWidget(
                helpWidget: Text(helpText),
              ),
            ),
          ),
        );

        // Assert
        expect(find.text(helpText), findsOneWidget);
      });
    });

    testWidgets('Displays help widget with error when provided',
        (WidgetTester tester) async {
      // Arrange
      const helpText = 'Help text';
      const errorText = 'Error occurred';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PasswordInputWidget(
              helpWidget: Text(helpText),
              error: errorText,
            ),
          ),
        ),
      );

      // Act
      final helpFinder = find.text(helpText);
      final errorFinder = find.text(errorText);

      // Assert
      expect(helpFinder, findsOneWidget);
      expect(errorFinder, findsOneWidget);
    });

    group('Callback Tests', () {
      testWidgets('Calls onChanged when text changes',
          (WidgetTester tester) async {
        // Arrange
        String? updatedValue;
        final controller = TextEditingController();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PasswordInputWidget(
                controller: controller,
                onChanged: (value) => updatedValue = value,
              ),
            ),
          ),
        );

        // Act
        await tester.enterText(find.byType(TextFormField), 'password123');
        await tester.pump(const Duration(milliseconds: 300));

        // Assert
        expect(updatedValue, 'password123');

        // Dispose
        controller.dispose();
      });
    });
  });
}
