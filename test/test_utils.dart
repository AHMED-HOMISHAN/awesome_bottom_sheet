import 'package:awesome_bottom_sheet/awesome_bottom_sheet.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

/// Builds an app with an "open" button that runs [open] and appends the
/// awaited result to [results].
Widget buildApp({
  required Future<AwesomeMessageResult> Function(BuildContext context) open,
  required List<AwesomeMessageResult> results,
  ThemeData? theme,
  ThemeData? darkTheme,
  ThemeMode themeMode = ThemeMode.light,
}) {
  return MaterialApp(
    theme: theme,
    darkTheme: darkTheme,
    themeMode: themeMode,
    home: Scaffold(
      body: Center(
        child: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () async => results.add(await open(context)),
            child: const Text('open'),
          ),
        ),
      ),
    ),
  );
}

/// Advances time in fixed steps.
///
/// The built-in Lottie icons loop forever, so `pumpAndSettle` would never
/// return; pumping a known duration is the reliable alternative.
Future<void> pumpFrames(
  WidgetTester tester, {
  int count = 8,
  Duration step = const Duration(milliseconds: 100),
}) async {
  for (var i = 0; i < count; i++) {
    await tester.pump(step);
  }
}

/// Taps the "open" button and waits for the sheet to finish animating in.
Future<void> openSheet(WidgetTester tester) async {
  await tester.tap(find.text('open'));
  await pumpFrames(tester);
}

/// Finds the card [Material] of the sheet.
Finder sheetCard() => find
    .descendant(
      of: find.byType(AwesomeMessageBottomSheet),
      matching: find.byType(Material),
    )
    .first;

/// Simulates the platform back gesture / hardware back button.
Future<void> systemBack(WidgetTester tester) async {
  final message = const JSONMethodCodec().encodeMethodCall(
    const MethodCall('popRoute'),
  );
  await tester.binding.defaultBinaryMessenger.handlePlatformMessage(
    'flutter/navigation',
    message,
    (_) {},
  );
  await pumpFrames(tester);
}
