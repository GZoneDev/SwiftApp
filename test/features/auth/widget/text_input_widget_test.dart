import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:receptico/features/auth/widget/widget.dart';

void main() {
  group('TextInputWidget Tests', () {
    group('UI Tests', () {
      testWidgets('Renders correctly with placeholder',
          (WidgetTester tester) async {
        // Arrange
        const placeholderText = 'Enter text';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: TextInputWidget(
                placeholder: placeholderText,
              ),
            ),
          ),
        );

        // Act
        final placeholderFinder = find.text(placeholderText);

        // Assert
        expect(placeholderFinder, findsOneWidget);
      });

      testWidgets('Displays error text when error is set',
          (WidgetTester tester) async {
        // Arrange
        const errorText = 'Error occurred';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: TextInputWidget(
                error: errorText,
              ),
            ),
          ),
        );

        // Act
        final errorFinder = find.text(errorText);

        // Assert
        expect(errorFinder, findsOneWidget);
      });

      testWidgets('Calls onChanged with debounce', (WidgetTester tester) async {
        // Arrange
        String? changedText;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: TextInputWidget(onChanged: (value) => changedText = value),
            ),
          ),
        );

        // Act
        await tester.enterText(find.byType(TextFormField), 'test');

        // Assert
        expect(changedText, isNull); // Initial state before debounce

        // Wait for debounce timer
        await tester.pump(const Duration(milliseconds: 300));
        expect(changedText, 'test'); // Value after debounce
      });

      testWidgets('Respects input formatters', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: TextInputWidget(),
            ),
          ),
        );

        // Act
        await tester.enterText(find.byType(TextFormField), 'invalid input!#');
        final inputFinder = find.text('invalid input!#');

        // Assert
        expect(inputFinder, findsNothing);
      });

      testWidgets('Displays help widget when provided',
          (WidgetTester tester) async {
        // Arrange
        const helpText = 'Help text';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: TextInputWidget(
                helpWidget: Text(helpText),
              ),
            ),
          ),
        );

        // Act
        final helpFinder = find.text(helpText);

        // Assert
        expect(helpFinder, findsOneWidget);
      });

      testWidgets('Displays help widget with error when provided',
          (WidgetTester tester) async {
        // Arrange
        const helpText = 'Help text';
        const errorText = 'Error occurred';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: TextInputWidget(
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

      testWidgets('Applies margin with error correctly',
          (WidgetTester tester) async {
        // Arrange
        const errorText = 'Error occurred';
        const marginWithError = EdgeInsets.all(10);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: TextInputWidget(
                error: errorText,
                marginWithError: marginWithError,
              ),
            ),
          ),
        );

        // Act
        final container =
            tester.widget<Container>(find.byType(Container).first);

        // Assert
        expect(container.margin, marginWithError);
      });
    });
  });
}
