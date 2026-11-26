// Renders the README and pub.dev screenshots from the real example app.
//
// Skipped by default. Opt in with:
//   flutter test test/screenshots_test.dart --dart-define=SCREENSHOTS=true
// then convert doc/screenshots/raw/*.png as described in CONTRIBUTING.md.
import 'dart:io';
import 'dart:ui' as ui;

import 'package:awesome_bottom_sheet_example/main.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

const bool _enabled = bool.fromEnvironment('SCREENSHOTS');
const String _outDir = '../doc/screenshots/raw';

/// Real fonts make the renders match a device; without them text draws in
/// the test-only Ahem font.
Future<void> _loadFonts() async {
  final root = Platform.environment['FLUTTER_ROOT'];
  final Directory fontsDir;
  if (root != null) {
    fontsDir = Directory('$root/bin/cache/artifacts/material_fonts');
  } else {
    // <flutter>/bin/cache/artifacts/engine/<platform>/flutter_tester
    final artifacts = File(Platform.resolvedExecutable).parent.parent.parent;
    fontsDir = Directory('${artifacts.path}/material_fonts');
  }
  if (!fontsDir.existsSync()) {
    debugPrint(
      'Material fonts not found at ${fontsDir.path}; '
      'text will render in the Ahem test font.',
    );
    return;
  }
  final roboto = FontLoader('Roboto');
  for (final name in [
    'Roboto-Regular.ttf',
    'Roboto-Medium.ttf',
    'Roboto-Bold.ttf',
  ]) {
    final file = File('${fontsDir.path}/$name');
    if (file.existsSync()) {
      roboto.addFont(
        Future.value(ByteData.sublistView(file.readAsBytesSync())),
      );
    }
  }
  await roboto.load();
  final icons = FontLoader('MaterialIcons');
  final iconFile = File('${fontsDir.path}/MaterialIcons-Regular.otf');
  if (iconFile.existsSync()) {
    icons.addFont(
      Future.value(ByteData.sublistView(iconFile.readAsBytesSync())),
    );
  }
  await icons.load();
}

Future<void> _pumpFrames(WidgetTester tester, int count) async {
  for (var i = 0; i < count; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

Future<void> _capture(WidgetTester tester, Key key, String name) async {
  await tester.runAsync(() async {
    final boundary = tester.renderObject<RenderRepaintBoundary>(
      find.byKey(key),
    );
    final image = await boundary.toImage(pixelRatio: 2);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    final file = File('$_outDir/$name.png')..createSync(recursive: true);
    file.writeAsBytesSync(bytes!.buffer.asUint8List());
    debugPrint('wrote ${file.path}');
  });
}

void main() {
  setUpAll(_loadFonts);

  const shots = <String, (Brightness, String)>{
    'info_light': (Brightness.light, 'Info'),
    'success_light': (Brightness.light, 'Success'),
    'warning_light': (Brightness.light, 'Warning'),
    'error_light': (Brightness.light, 'Error'),
    'success_dark': (Brightness.dark, 'Success'),
    'error_dark': (Brightness.dark, 'Error'),
    'styled_light': (Brightness.light, 'Custom colors and radius'),
    'content_light': (Brightness.light, 'Text field content'),
  };

  for (final entry in shots.entries) {
    testWidgets(entry.key, skip: !_enabled, (tester) async {
      // Real shadows instead of the test framework's solid outline.
      debugDisableShadows = false;
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      tester.view.padding = const FakeViewPadding(top: 47, bottom: 34);
      tester.platformDispatcher.platformBrightnessTestValue = entry.value.$1;
      addTearDown(tester.view.reset);
      addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);

      const key = Key('screenshot');
      await tester.pumpWidget(
        const RepaintBoundary(key: key, child: ExampleApp()),
      );
      await _pumpFrames(tester, 3);
      await tester.tap(find.text(entry.value.$2));
      await _pumpFrames(tester, 14);
      expect(tester.takeException(), isNull);
      await _capture(tester, key, entry.key);
      debugDisableShadows = true;
    });
  }
}
