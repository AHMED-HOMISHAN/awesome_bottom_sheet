import 'dart:convert';

import 'package:awesome_bottom_sheet/awesome_bottom_sheet.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  group('AwesomeMessageType', () {
    test('has a distinct default color per type', () {
      final colors = AwesomeMessageType.values.map((t) => t.defaultColor);
      expect(colors.toSet().length, AwesomeMessageType.values.length);
      expect(AwesomeMessageType.info.defaultColor, Colors.blue);
      expect(AwesomeMessageType.success.defaultColor, Colors.green);
      expect(AwesomeMessageType.warning.defaultColor, Colors.orange);
      expect(AwesomeMessageType.error.defaultColor, Colors.red);
    });

    test('exposes a readable label', () {
      expect(AwesomeMessageType.error.label, 'Error');
      expect(AwesomeMessageType.info.label, 'Information');
    });

    test('ThemeHelper delegates to the type defaults', () {
      for (final type in AwesomeMessageType.values) {
        expect(ThemeHelper.getTypeColor(type), type.defaultColor);
        expect(
          ThemeHelper.getLottieAnimation(type),
          same(LottieAnimations.forType(type)),
        );
      }
    });
  });

  group('AwesomeMessageResult', () {
    test('classifies results', () {
      expect(AwesomeMessageResult.primary.isPrimary, isTrue);
      expect(AwesomeMessageResult.primary.isDismissed, isFalse);
      expect(AwesomeMessageResult.secondary.isSecondary, isTrue);
      expect(AwesomeMessageResult.dismissed.isDismissed, isTrue);
      expect(AwesomeMessageResult.autoDismissed.isDismissed, isTrue);
      expect(AwesomeMessageResult.autoDismissed.isPrimary, isFalse);
    });
  });

  group('AwesomeMessageConfig', () {
    test('has safe defaults', () {
      const config = AwesomeMessageConfig(
        title: 't',
        type: AwesomeMessageType.info,
      );
      expect(config.barrierDismissible, isTrue);
      expect(config.showSecondaryButton, isTrue);
      expect(config.primaryButtonText, 'OK');
      expect(config.secondaryButtonText, 'Close');
      expect(config.autoDismissAfter, isNull);
      expect(config.description, isNull);
    });

    test('copyWith replaces only the given fields', () {
      const base = AwesomeMessageConfig(
        title: 't',
        type: AwesomeMessageType.info,
        description: 'd',
        primaryButtonText: 'Yes',
      );
      final copy = base.copyWith(
        type: AwesomeMessageType.error,
        barrierDismissible: false,
      );
      expect(copy.title, 't');
      expect(copy.description, 'd');
      expect(copy.primaryButtonText, 'Yes');
      expect(copy.type, AwesomeMessageType.error);
      expect(copy.barrierDismissible, isFalse);
      expect(base.type, AwesomeMessageType.info);
    });
  });

  group('LottieData', () {
    const sample = LottieData(
      name: 'sample',
      duration: 1,
      jsonData: {
        'v': '5.5.7',
        'nm': 'He said "hi"\\n',
        'layers': [1, 2.5, true, null],
      },
    );

    test('bytes are valid JSON that round-trips the document', () {
      final decoded = jsonDecode(utf8.decode(sample.bytes));
      expect(decoded, sample.jsonData);
    });

    test('bytes are computed once and cached per instance', () {
      expect(identical(sample.bytes, sample.bytes), isTrue);
      expect(
        identical(LottieAnimations.info.bytes, LottieAnimations.info.bytes),
        isTrue,
      );
    });

    test('deprecated string encoders now produce valid JSON', () {
      // ignore: deprecated_member_use_from_same_package
      expect(jsonDecode(sample.toJsonString()), sample.jsonData);
      // ignore: deprecated_member_use_from_same_package
      expect(jsonDecode(sample.formattedJson), sample.jsonData);
    });
  });

  group('LottieAnimations', () {
    test('maps every type to an animation', () {
      expect(
        LottieAnimations.forType(AwesomeMessageType.info),
        same(LottieAnimations.info),
      );
      expect(
        LottieAnimations.forType(AwesomeMessageType.success),
        same(LottieAnimations.success),
      );
      expect(
        LottieAnimations.forType(AwesomeMessageType.warning),
        same(LottieAnimations.warning),
      );
      expect(
        LottieAnimations.forType(AwesomeMessageType.error),
        same(LottieAnimations.error),
      );
      expect(LottieAnimations.values, hasLength(4));
    });

    for (final animation in LottieAnimations.values) {
      test('${animation.name} parses as a Lottie composition', () async {
        final composition = await LottieComposition.fromBytes(animation.bytes);
        expect(composition.duration, greaterThan(Duration.zero));
        expect(composition.bounds.width, greaterThan(0));
      });
    }
  });
}
