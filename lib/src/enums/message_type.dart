import 'package:material_ui/material_ui.dart';

/// The semantic category of a message.
///
/// Each type comes with a default accent color and a built-in animated icon.
/// Both can be overridden per sheet through `AwesomeMessageConfig`, or for
/// the whole app through `AwesomeBottomSheetThemeData`.
enum AwesomeMessageType {
  /// Neutral information, tips and updates. Blue by default.
  info,

  /// Cautions and important notices. Orange by default.
  warning,

  /// Failures and critical problems. Red by default.
  error,

  /// Completed operations and confirmations. Green by default.
  success;

  /// The accent color used when neither the config nor the theme sets one.
  Color get defaultColor => switch (this) {
    AwesomeMessageType.info => Colors.blue,
    AwesomeMessageType.warning => Colors.orange,
    AwesomeMessageType.error => Colors.red,
    AwesomeMessageType.success => Colors.green,
  };

  /// A short, human readable label, useful for logging and semantics.
  String get label => switch (this) {
    AwesomeMessageType.info => 'Information',
    AwesomeMessageType.warning => 'Warning',
    AwesomeMessageType.error => 'Error',
    AwesomeMessageType.success => 'Success',
  };
}
