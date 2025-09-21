import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:awesome_bottom_sheet/awesome_bottom_sheet.dart';

void main() {
  group('AwesomeMessageBottomSheet Tests', () {
    testWidgets('AwesomeMessageService should display info message',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    AwesomeMessageService.showInfo(
                      context: context,
                      title: 'Information',
                      description: 'This is an info message',
                    );
                  },
                  child: const Text('Show Info'),
                );
              },
            ),
          ),
        ),
      );

      // Tap the button to show bottom sheet
      await tester.tap(find.text('Show Info'));
      await tester.pumpAndSettle();

      // Verify the bottom sheet content
      expect(find.text('Information'), findsOneWidget);
      expect(find.text('This is an info message'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
      expect(find.text('Close'), findsOneWidget);
    });

    testWidgets('AwesomeMessageService should display success message',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    AwesomeMessageService.showSuccess(
                      context: context,
                      title: 'Success!',
                      description: 'Operation completed successfully',
                      primaryButtonText: 'Continue',
                      secondaryButtonText: 'Cancel',
                    );
                  },
                  child: const Text('Show Success'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Success'));
      await tester.pumpAndSettle();

      expect(find.text('Success!'), findsOneWidget);
      expect(find.text('Operation completed successfully'), findsOneWidget);
      expect(find.text('Continue'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('AwesomeMessageService should display warning message',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    AwesomeMessageService.showWarning(
                      context: context,
                      title: 'Warning',
                      description: 'Please proceed with caution',
                    );
                  },
                  child: const Text('Show Warning'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Warning'));
      await tester.pumpAndSettle();

      expect(find.text('Warning'), findsOneWidget);
      expect(find.text('Please proceed with caution'), findsOneWidget);
    });

    testWidgets('AwesomeMessageService should display error message',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    AwesomeMessageService.showError(
                      context: context,
                      title: 'Error',
                      description: 'Something went wrong',
                    );
                  },
                  child: const Text('Show Error'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Error'));
      await tester.pumpAndSettle();

      expect(find.text('Error'), findsOneWidget);
      expect(find.text('Something went wrong'), findsOneWidget);
    });

    testWidgets('AwesomeMessageService should handle custom button actions',
        (WidgetTester tester) async {
      bool primaryPressed = false;
      bool secondaryPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    AwesomeMessageService.showInfo(
                      context: context,
                      title: 'Custom Actions',
                      onPrimaryPressed: () => primaryPressed = true,
                      onSecondaryPressed: () => secondaryPressed = true,
                    );
                  },
                  child: const Text('Show Custom'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Custom'));
      await tester.pumpAndSettle();

      // Test primary button
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      expect(primaryPressed, true);

      // Show again for secondary button test
      await tester.tap(find.text('Show Custom'));
      await tester.pumpAndSettle();

      // Test secondary button
      await tester.tap(find.text('Close'));
      await tester.pumpAndSettle();
      expect(secondaryPressed, true);
    });

    testWidgets('AwesomeMessageService should support custom colors',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    AwesomeMessageService.showInfo(
                      context: context,
                      title: 'Custom Colors',
                      primaryButtonColor: Colors.purple,
                      secondaryButtonColor: Colors.grey,
                      primaryButtonTextColor: Colors.white,
                      secondaryButtonTextColor: Colors.black,
                    );
                  },
                  child: const Text('Show Custom Colors'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Custom Colors'));
      await tester.pumpAndSettle();

      expect(find.text('Custom Colors'), findsOneWidget);
      // Color testing would require widget inspection
    });
  });
}
