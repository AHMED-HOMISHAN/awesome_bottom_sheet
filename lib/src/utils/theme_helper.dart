import 'package:material_ui/material_ui.dart';

import '../constants/lottie_animations.dart';
import '../enums/message_type.dart';
import '../models/lottie_data.dart';

/// Static helpers that map a message type to its built-in defaults.
///
/// Prefer `AwesomeMessageType.defaultColor` and
/// `LottieAnimations.forType` in new code; this class is kept for
/// compatibility with 0.x.
abstract final class ThemeHelper {
  /// The default accent color for [type].
  static Color getTypeColor(AwesomeMessageType type) => type.defaultColor;

  /// The built-in animation for [type].
  static LottieData getLottieAnimation(AwesomeMessageType type) =>
      LottieAnimations.forType(type);
}
