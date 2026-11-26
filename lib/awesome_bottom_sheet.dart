/// Animated feedback bottom sheets for Flutter.
///
/// Show success, error, warning and info messages as a modal bottom sheet
/// with an animated Lottie icon, theme-aware styling and a typed result:
///
/// ```dart
/// final result = await AwesomeBottomSheet.showSuccess(
///   context: context,
///   title: 'Saved',
///   description: 'Your changes are safe.',
/// );
/// if (result.isPrimary) {
///   // The user tapped the primary button.
/// }
/// ```
///
/// Start with [AwesomeBottomSheet] for the one-line API, use
/// [AwesomeMessageConfig] to describe a sheet once and reuse it, and install
/// [AwesomeBottomSheetThemeData] in your [ThemeData] to restyle every sheet
/// in the app.
library;

import 'package:material_ui/material_ui.dart' show ThemeData;

import 'src/models/message_config.dart';
import 'src/services/awesome_bottom_sheet.dart';
import 'src/theme/awesome_bottom_sheet_theme.dart';

export 'src/constants/lottie_animations.dart';
export 'src/enums/message_result.dart';
export 'src/enums/message_type.dart';
export 'src/models/lottie_data.dart';
export 'src/models/message_config.dart';
export 'src/services/awesome_bottom_sheet.dart';
export 'src/theme/awesome_bottom_sheet_theme.dart';
export 'src/utils/theme_helper.dart';
export 'src/widgets/awesome_message_bottom_sheet.dart';
