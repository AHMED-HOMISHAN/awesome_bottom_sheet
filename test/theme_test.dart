import 'package:awesome_bottom_sheet/awesome_bottom_sheet.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  const a = AwesomeBottomSheetThemeData(
    backgroundColor: Color(0xFF000000),
    maxWidth: 400,
    iconSize: 40,
    elevation: 2,
    infoColor: Color(0xFF0000FF),
    borderRadius: BorderRadius.all(Radius.circular(8)),
    margin: EdgeInsets.all(8),
  );
  const b = AwesomeBottomSheetThemeData(
    backgroundColor: Color(0xFFFFFFFF),
    maxWidth: 600,
    iconSize: 80,
    elevation: 10,
    infoColor: Color(0xFF00FF00),
    borderRadius: BorderRadius.all(Radius.circular(24)),
    margin: EdgeInsets.all(24),
  );

  test('colorFor maps each type to its field', () {
    const theme = AwesomeBottomSheetThemeData(
      infoColor: Color(0xFF000001),
      successColor: Color(0xFF000002),
      warningColor: Color(0xFF000003),
      errorColor: Color(0xFF000004),
    );
    expect(theme.colorFor(AwesomeMessageType.info), const Color(0xFF000001));
    expect(theme.colorFor(AwesomeMessageType.success), const Color(0xFF000002));
    expect(theme.colorFor(AwesomeMessageType.warning), const Color(0xFF000003));
    expect(theme.colorFor(AwesomeMessageType.error), const Color(0xFF000004));
    expect(a.colorFor(AwesomeMessageType.error), isNull);
  });

  test('copyWith replaces only the given fields', () {
    final copy = a.copyWith(
      maxWidth: 500,
      successColor: const Color(0xFF0F0F0F),
    );
    expect(copy.maxWidth, 500);
    expect(copy.successColor, const Color(0xFF0F0F0F));
    expect(copy.backgroundColor, a.backgroundColor);
    expect(copy.iconSize, a.iconSize);
  });

  test('lerp interpolates between two themes', () {
    expect(a.lerp(b, 0), a);
    expect(a.lerp(b, 1), b);
    final mid = a.lerp(b, 0.5);
    expect(mid.maxWidth, 500);
    expect(mid.iconSize, 60);
    expect(mid.elevation, 6);
    expect(mid.margin, const EdgeInsets.all(16));
    expect(a.lerp(null, 0.5), a);
  });

  test('implements value equality', () {
    expect(a, a.copyWith());
    expect(a.hashCode, a.copyWith().hashCode);
    expect(a == b, isFalse);
  });

  testWidgets('of(context) returns an empty theme when none is installed', (
    tester,
  ) async {
    late AwesomeBottomSheetThemeData resolved;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            resolved = AwesomeBottomSheetThemeData.of(context);
            return const SizedBox();
          },
        ),
      ),
    );
    expect(resolved, const AwesomeBottomSheetThemeData());
  });

  testWidgets('of(context) returns the installed extension', (tester) async {
    late AwesomeBottomSheetThemeData resolved;
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(extensions: const [a]),
        home: Builder(
          builder: (context) {
            resolved = AwesomeBottomSheetThemeData.of(context);
            return const SizedBox();
          },
        ),
      ),
    );
    expect(resolved, a);
  });
}
