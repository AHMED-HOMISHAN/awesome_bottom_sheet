import 'package:awesome_bottom_sheet/awesome_bottom_sheet.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:material_ui/material_ui.dart';

import 'test_utils.dart';

void main() {
  group('content', () {
    for (final type in AwesomeMessageType.values) {
      testWidgets('renders title, description and buttons for $type', (
        tester,
      ) async {
        final results = <AwesomeMessageResult>[];
        await tester.pumpWidget(
          buildApp(
            results: results,
            open: (context) => AwesomeBottomSheet.show(
              context: context,
              type: type,
              title: 'Title ${type.name}',
              description: 'Description ${type.name}',
              primaryButtonText: 'Go',
              secondaryButtonText: 'Back',
            ),
          ),
        );
        await openSheet(tester);

        expect(find.text('Title ${type.name}'), findsOneWidget);
        expect(find.text('Description ${type.name}'), findsOneWidget);
        expect(find.widgetWithText(FilledButton, 'Go'), findsOneWidget);
        expect(find.widgetWithText(OutlinedButton, 'Back'), findsOneWidget);
        expect(find.byType(LottieBuilder), findsOneWidget);
        expect(tester.takeException(), isNull);

        final title = tester.widget<Text>(find.text('Title ${type.name}'));
        expect(title.style?.color, type.defaultColor);
      });
    }

    testWidgets('omits the description when none is given', (tester) async {
      await tester.pumpWidget(
        buildApp(
          results: [],
          open: (context) => AwesomeBottomSheet.showInfo(
            context: context,
            title: 'Only title',
          ),
        ),
      );
      await openSheet(tester);

      expect(find.text('Only title'), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(4)); // open, title, 2 buttons
    });

    testWidgets('renders a custom icon instead of the animation', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildApp(
          results: [],
          open: (context) => AwesomeBottomSheet.showSuccess(
            context: context,
            title: 'Custom icon',
            icon: const Icon(Icons.star, key: Key('star')),
          ),
        ),
      );
      await openSheet(tester);

      expect(find.byKey(const Key('star')), findsOneWidget);
      expect(find.byType(LottieBuilder), findsNothing);
    });

    testWidgets('renders custom content below the description', (tester) async {
      await tester.pumpWidget(
        buildApp(
          results: [],
          open: (context) => AwesomeBottomSheet.showInfo(
            context: context,
            title: 'With content',
            content: const TextField(key: Key('field')),
          ),
        ),
      );
      await openSheet(tester);

      expect(find.byKey(const Key('field')), findsOneWidget);
    });

    testWidgets('hides the secondary button on request', (tester) async {
      await tester.pumpWidget(
        buildApp(
          results: [],
          open: (context) => AwesomeBottomSheet.showError(
            context: context,
            title: 'Single action',
            showSecondaryButton: false,
          ),
        ),
      );
      await openSheet(tester);

      expect(find.byType(OutlinedButton), findsNothing);
      expect(find.byType(FilledButton), findsOneWidget);
      final buttonWidth = tester.getSize(find.byType(FilledButton)).width;
      final cardWidth = tester.getSize(sheetCard()).width;
      expect(buttonWidth, cardWidth - 48);
    });
  });

  group('results and callbacks', () {
    testWidgets('primary button resolves with primary and fires the callback', (
      tester,
    ) async {
      final results = <AwesomeMessageResult>[];
      var callbackSawSheetClosed = false;
      await tester.pumpWidget(
        buildApp(
          results: results,
          open: (context) => AwesomeBottomSheet.showInfo(
            context: context,
            title: 'Primary',
            onPrimaryPressed: () {
              callbackSawSheetClosed =
                  ModalRoute.of(context)?.isCurrent ?? false;
            },
          ),
        ),
      );
      await openSheet(tester);

      await tester.tap(find.text('OK'));
      await pumpFrames(tester);

      expect(results, [AwesomeMessageResult.primary]);
      expect(results.single.isPrimary, isTrue);
      expect(callbackSawSheetClosed, isTrue);
      expect(find.text('Primary'), findsNothing);
    });

    testWidgets('secondary button resolves with secondary', (tester) async {
      final results = <AwesomeMessageResult>[];
      var secondaryCalls = 0;
      var primaryCalls = 0;
      await tester.pumpWidget(
        buildApp(
          results: results,
          open: (context) => AwesomeBottomSheet.showWarning(
            context: context,
            title: 'Secondary',
            onPrimaryPressed: () => primaryCalls++,
            onSecondaryPressed: () => secondaryCalls++,
          ),
        ),
      );
      await openSheet(tester);

      await tester.tap(find.text('Close'));
      await pumpFrames(tester);

      expect(results, [AwesomeMessageResult.secondary]);
      expect(secondaryCalls, 1);
      expect(primaryCalls, 0);
    });

    testWidgets('tapping the barrier resolves with dismissed', (tester) async {
      final results = <AwesomeMessageResult>[];
      await tester.pumpWidget(
        buildApp(
          results: results,
          open: (context) =>
              AwesomeBottomSheet.showInfo(context: context, title: 'Barrier'),
        ),
      );
      await openSheet(tester);

      await tester.tapAt(const Offset(10, 10));
      await pumpFrames(tester);

      expect(results, [AwesomeMessageResult.dismissed]);
      expect(results.single.isDismissed, isTrue);
      expect(find.text('Barrier'), findsNothing);
    });

    testWidgets('dragging the sheet down resolves with dismissed', (
      tester,
    ) async {
      final results = <AwesomeMessageResult>[];
      await tester.pumpWidget(
        buildApp(
          results: results,
          open: (context) =>
              AwesomeBottomSheet.showInfo(context: context, title: 'Drag'),
        ),
      );
      await openSheet(tester);

      await tester.drag(find.text('Drag'), const Offset(0, 200));
      await pumpFrames(tester);

      expect(results, [AwesomeMessageResult.dismissed]);
    });

    testWidgets('auto dismiss resolves with autoDismissed', (tester) async {
      final results = <AwesomeMessageResult>[];
      await tester.pumpWidget(
        buildApp(
          results: results,
          open: (context) => AwesomeBottomSheet.showSuccess(
            context: context,
            title: 'Auto',
            autoDismissAfter: const Duration(seconds: 2),
          ),
        ),
      );
      await openSheet(tester);
      expect(find.text('Auto'), findsOneWidget);

      await pumpFrames(tester, count: 20);

      expect(results, [AwesomeMessageResult.autoDismissed]);
      expect(find.text('Auto'), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('a button tap cancels the pending auto dismiss', (
      tester,
    ) async {
      final results = <AwesomeMessageResult>[];
      await tester.pumpWidget(
        buildApp(
          results: results,
          open: (context) => AwesomeBottomSheet.showSuccess(
            context: context,
            title: 'Auto',
            autoDismissAfter: const Duration(seconds: 2),
          ),
        ),
      );
      await openSheet(tester);
      await tester.tap(find.text('OK'));
      await pumpFrames(tester, count: 20);

      expect(results, [AwesomeMessageResult.primary]);
      expect(tester.takeException(), isNull);
    });

    testWidgets('showConfig reuses a prebuilt config', (tester) async {
      final results = <AwesomeMessageResult>[];
      const config = AwesomeMessageConfig(
        title: 'Prebuilt',
        type: AwesomeMessageType.error,
        primaryButtonText: 'Retry',
      );
      await tester.pumpWidget(
        buildApp(
          results: results,
          open: (context) =>
              AwesomeBottomSheet.showConfig(context: context, config: config),
        ),
      );
      await openSheet(tester);

      expect(find.text('Prebuilt'), findsOneWidget);
      await tester.tap(find.text('Retry'));
      await pumpFrames(tester);
      expect(results, [AwesomeMessageResult.primary]);
    });

    testWidgets('the 0.x AwesomeMessageService alias still works', (
      tester,
    ) async {
      final results = <AwesomeMessageResult>[];
      await tester.pumpWidget(
        buildApp(
          results: results,
          // ignore: deprecated_member_use_from_same_package
          open: (context) =>
              AwesomeMessageService.showInfo(context: context, title: 'Legacy'),
        ),
      );
      await openSheet(tester);

      expect(find.text('Legacy'), findsOneWidget);
      await tester.tap(find.text('OK'));
      await pumpFrames(tester);
      expect(results, [AwesomeMessageResult.primary]);
    });
  });

  group('dismissal control', () {
    testWidgets('non-dismissible sheets ignore barrier taps, drags and back', (
      tester,
    ) async {
      final results = <AwesomeMessageResult>[];
      await tester.pumpWidget(
        buildApp(
          results: results,
          open: (context) => AwesomeBottomSheet.showWarning(
            context: context,
            title: 'Locked',
            barrierDismissible: false,
          ),
        ),
      );
      await openSheet(tester);

      await tester.tapAt(const Offset(10, 10));
      await pumpFrames(tester);
      expect(find.text('Locked'), findsOneWidget);

      await tester.drag(find.text('Locked'), const Offset(0, 600));
      await pumpFrames(tester);
      expect(find.text('Locked'), findsOneWidget);

      await systemBack(tester);
      expect(find.text('Locked'), findsOneWidget);
      expect(results, isEmpty);

      await tester.tap(find.text('OK'));
      await pumpFrames(tester);
      expect(results, [AwesomeMessageResult.primary]);
    });

    testWidgets('dismissible sheets close on system back', (tester) async {
      final results = <AwesomeMessageResult>[];
      await tester.pumpWidget(
        buildApp(
          results: results,
          open: (context) =>
              AwesomeBottomSheet.showInfo(context: context, title: 'Back'),
        ),
      );
      await openSheet(tester);

      await systemBack(tester);

      expect(find.text('Back'), findsNothing);
      expect(results, [AwesomeMessageResult.dismissed]);
    });
  });

  group('theming', () {
    testWidgets('uses the dark color scheme surface in dark mode', (
      tester,
    ) async {
      final dark = ThemeData.dark();
      await tester.pumpWidget(
        buildApp(
          results: [],
          theme: ThemeData.light(),
          darkTheme: dark,
          themeMode: ThemeMode.dark,
          open: (context) =>
              AwesomeBottomSheet.showInfo(context: context, title: 'Dark'),
        ),
      );
      await openSheet(tester);

      final card = tester.widget<Material>(sheetCard());
      expect(card.color, dark.colorScheme.surface);
    });

    testWidgets('honors AwesomeBottomSheetThemeData from the theme', (
      tester,
    ) async {
      const sheetTheme = AwesomeBottomSheetThemeData(
        backgroundColor: Color(0xFF112233),
        successColor: Color(0xFF00AA00),
        iconSize: 40,
        maxWidth: 300,
      );
      await tester.pumpWidget(
        buildApp(
          results: [],
          theme: ThemeData(extensions: const [sheetTheme]),
          open: (context) =>
              AwesomeBottomSheet.showSuccess(context: context, title: 'Themed'),
        ),
      );
      await openSheet(tester);

      final card = tester.widget<Material>(sheetCard());
      expect(card.color, const Color(0xFF112233));
      expect(tester.getSize(sheetCard()).width, 300 - 32);
      final title = tester.widget<Text>(find.text('Themed'));
      expect(title.style?.color, const Color(0xFF00AA00));
      expect(tester.getSize(find.byType(LottieBuilder)), const Size(40, 40));
    });

    testWidgets('config values override the theme extension', (tester) async {
      const sheetTheme = AwesomeBottomSheetThemeData(
        backgroundColor: Color(0xFF112233),
        infoColor: Color(0xFF00AA00),
      );
      await tester.pumpWidget(
        buildApp(
          results: [],
          theme: ThemeData(extensions: const [sheetTheme]),
          open: (context) => AwesomeBottomSheet.showInfo(
            context: context,
            title: 'Override',
            accentColor: const Color(0xFFAA0000),
            backgroundColor: const Color(0xFF445566),
            primaryButtonColor: const Color(0xFF123456),
            primaryButtonTextColor: const Color(0xFFFEDCBA),
          ),
        ),
      );
      await openSheet(tester);

      expect(
        tester.widget<Material>(sheetCard()).color,
        const Color(0xFF445566),
      );
      final title = tester.widget<Text>(find.text('Override'));
      expect(title.style?.color, const Color(0xFFAA0000));

      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(
        button.style?.backgroundColor?.resolve({}),
        const Color(0xFF123456),
      );
      expect(
        button.style?.foregroundColor?.resolve({}),
        const Color(0xFFFEDCBA),
      );
    });

    testWidgets('picks a readable text color for the primary button', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildApp(
          results: [],
          open: (context) => AwesomeBottomSheet.showInfo(
            context: context,
            title: 'Contrast',
            primaryButtonColor: const Color(0xFFFFFF00),
          ),
        ),
      );
      await openSheet(tester);

      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(button.style?.foregroundColor?.resolve({}), Colors.black87);
    });
  });

  group('layout and accessibility', () {
    testWidgets('the route child is only as tall as the card', (tester) async {
      await tester.pumpWidget(
        buildApp(
          results: [],
          open: (context) =>
              AwesomeBottomSheet.showInfo(context: context, title: 'Short'),
        ),
      );
      await openSheet(tester);

      final sheetHeight = tester
          .getSize(find.byType(AwesomeMessageBottomSheet))
          .height;
      final cardHeight = tester.getSize(sheetCard()).height;
      expect(sheetHeight, cardHeight + 32);
      expect(sheetHeight, lessThan(300));
    });

    testWidgets('caps the card width on wide screens', (tester) async {
      tester.view.physicalSize = const Size(1400, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        buildApp(
          results: [],
          open: (context) =>
              AwesomeBottomSheet.showInfo(context: context, title: 'Wide'),
        ),
      );
      await openSheet(tester);

      final rect = tester.getRect(sheetCard());
      expect(rect.width, AwesomeMessageBottomSheet.defaultMaxWidth - 32);
      expect(rect.center.dx, closeTo(700, 1));
    });

    testWidgets('keeps the buttons reachable with a very long description', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(320, 480);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        buildApp(
          results: [],
          open: (context) => AwesomeBottomSheet.showInfo(
            context: context,
            title: 'Long',
            description: List.filled(
              80,
              'Lorem ipsum dolor sit amet.',
            ).join(' '),
          ),
        ),
      );
      await openSheet(tester);

      expect(tester.takeException(), isNull);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      final okRect = tester.getRect(find.text('OK'));
      expect(okRect.bottom, lessThanOrEqualTo(480));
      expect(tester.getRect(sheetCard()).top, greaterThanOrEqualTo(0));
    });

    testWidgets('moves above the keyboard', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      tester.view.viewInsets = const FakeViewPadding(bottom: 300);
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        buildApp(
          results: [],
          open: (context) =>
              AwesomeBottomSheet.showInfo(context: context, title: 'Keyboard'),
        ),
      );
      await openSheet(tester);

      final screenHeight =
          tester.view.physicalSize.height / tester.view.devicePixelRatio;
      expect(
        tester.getRect(sheetCard()).bottom,
        lessThanOrEqualTo(screenHeight - 300),
      );
    });

    testWidgets('respects the bottom safe area', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      tester.view.padding = const FakeViewPadding(bottom: 34);
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        buildApp(
          results: [],
          open: (context) =>
              AwesomeBottomSheet.showInfo(context: context, title: 'Safe'),
        ),
      );
      await openSheet(tester);

      final screenHeight =
          tester.view.physicalSize.height / tester.view.devicePixelRatio;
      expect(
        tester.getRect(sheetCard()).bottom,
        lessThanOrEqualTo(screenHeight - 34 - 16),
      );
    });

    testWidgets('skips the entrance animation when animations are disabled', (
      tester,
    ) async {
      tester.platformDispatcher.accessibilityFeaturesTestValue =
          const FakeAccessibilityFeatures(disableAnimations: true);
      addTearDown(
        tester.platformDispatcher.clearAccessibilityFeaturesTestValue,
      );

      await tester.pumpWidget(
        buildApp(
          results: [],
          open: (context) =>
              AwesomeBottomSheet.showInfo(context: context, title: 'Still'),
        ),
      );
      await tester.tap(find.text('open'));
      await tester.pump();

      final fade = tester.widget<FadeTransition>(
        find.descendant(
          of: find.byType(AwesomeMessageBottomSheet),
          matching: find.byType(FadeTransition),
        ),
      );
      expect(fade.opacity.value, 1.0);
    });

    testWidgets('animates the content in by default', (tester) async {
      await tester.pumpWidget(
        buildApp(
          results: [],
          open: (context) =>
              AwesomeBottomSheet.showInfo(context: context, title: 'Fade'),
        ),
      );
      await tester.tap(find.text('open'));
      await tester.pump();

      final fade = tester.widget<FadeTransition>(
        find.descendant(
          of: find.byType(AwesomeMessageBottomSheet),
          matching: find.byType(FadeTransition),
        ),
      );
      expect(fade.opacity.value, 0.0);

      await pumpFrames(tester);
      final settled = tester.widget<FadeTransition>(
        find.descendant(
          of: find.byType(AwesomeMessageBottomSheet),
          matching: find.byType(FadeTransition),
        ),
      );
      expect(settled.opacity.value, 1.0);
    });

    testWidgets('marks the title as a header and hides the icon from a11y', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        buildApp(
          results: [],
          open: (context) =>
              AwesomeBottomSheet.showInfo(context: context, title: 'Header'),
        ),
      );
      await openSheet(tester);

      expect(
        tester.getSemantics(find.text('Header')),
        matchesSemantics(isHeader: true, label: 'Header'),
      );
      handle.dispose();
    });

    testWidgets('works when used directly with showModalBottomSheet', (
      tester,
    ) async {
      AwesomeMessageResult? result;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () async {
                  result = await showModalBottomSheet<AwesomeMessageResult>(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => const AwesomeMessageBottomSheet(
                      config: AwesomeMessageConfig(
                        title: 'Direct',
                        type: AwesomeMessageType.info,
                      ),
                    ),
                  );
                },
                child: const Text('open'),
              ),
            ),
          ),
        ),
      );
      await openSheet(tester);
      await tester.tap(find.text('Close'));
      await pumpFrames(tester);

      expect(result, AwesomeMessageResult.secondary);
    });
  });
}
