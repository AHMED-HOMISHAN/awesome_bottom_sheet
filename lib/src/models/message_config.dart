import 'package:material_ui/material_ui.dart';

import '../enums/message_type.dart';

/// Describes the content, appearance and behavior of one message sheet.
///
/// Create a config once and show it with `AwesomeBottomSheet.showConfig`, or
/// let the `AwesomeBottomSheet.show*` methods build one for you from named
/// parameters.
///
/// Values left `null` fall back to `AwesomeBottomSheetThemeData` from the
/// nearest `Theme`, and then to the package defaults derived from the app's
/// `ColorScheme`, so sheets look right in both light and dark mode.
@immutable
class AwesomeMessageConfig {
  /// Creates a message configuration.
  const AwesomeMessageConfig({
    required this.title,
    required this.type,
    this.description,
    this.content,
    this.icon,
    this.customLottieAsset,
    this.accentColor,
    this.backgroundColor,
    this.borderRadius,
    this.titleStyle,
    this.descriptionStyle,
    this.primaryButtonText = 'OK',
    this.secondaryButtonText = 'Close',
    this.showSecondaryButton = true,
    this.primaryButtonColor,
    this.secondaryButtonColor,
    this.primaryButtonTextColor,
    this.secondaryButtonTextColor,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.barrierDismissible = true,
    this.autoDismissAfter,
  });

  /// The headline of the message.
  final String title;

  /// The category of the message. Drives the default color and icon.
  final AwesomeMessageType type;

  /// Optional supporting text shown under the title.
  final String? description;

  /// Optional widget shown under the description, for example a text field,
  /// a list of details or a progress indicator.
  ///
  /// The content scrolls together with the description when the sheet would
  /// otherwise exceed the available height.
  final Widget? content;

  /// A widget that replaces the animated icon entirely.
  ///
  /// Takes precedence over [customLottieAsset] and the built-in animation.
  final Widget? icon;

  /// Asset path of a Lottie JSON file that replaces the built-in animation.
  ///
  /// Ignored when [icon] is set.
  final String? customLottieAsset;

  /// Color of the title and, unless [primaryButtonColor] is set, of the
  /// primary button. Defaults to the color configured for [type].
  final Color? accentColor;

  /// Background color of the sheet. Defaults to the theme's bottom sheet
  /// color, then to `ColorScheme.surface`.
  final Color? backgroundColor;

  /// Corner radius of the sheet.
  final BorderRadiusGeometry? borderRadius;

  /// Style merged over the default title style.
  final TextStyle? titleStyle;

  /// Style merged over the default description style.
  final TextStyle? descriptionStyle;

  /// Label of the primary button.
  final String primaryButtonText;

  /// Label of the secondary button.
  final String secondaryButtonText;

  /// Whether to show the secondary button. Set to `false` for a single
  /// acknowledgement button that spans the full width.
  final bool showSecondaryButton;

  /// Background color of the primary button. Defaults to [accentColor].
  final Color? primaryButtonColor;

  /// Outline color of the secondary button.
  final Color? secondaryButtonColor;

  /// Text color of the primary button. Defaults to a readable color for
  /// [primaryButtonColor].
  final Color? primaryButtonTextColor;

  /// Text color of the secondary button.
  final Color? secondaryButtonTextColor;

  /// Called after the sheet closes because the primary button was tapped.
  final VoidCallback? onPrimaryPressed;

  /// Called after the sheet closes because the secondary button was tapped.
  final VoidCallback? onSecondaryPressed;

  /// Whether the sheet can be closed by tapping the barrier, dragging it
  /// down or navigating back. When `false`, only the buttons close it.
  final bool barrierDismissible;

  /// Closes the sheet automatically after this duration with
  /// `AwesomeMessageResult.autoDismissed`.
  final Duration? autoDismissAfter;

  /// Returns a copy of this config with the given fields replaced.
  AwesomeMessageConfig copyWith({
    String? title,
    AwesomeMessageType? type,
    String? description,
    Widget? content,
    Widget? icon,
    String? customLottieAsset,
    Color? accentColor,
    Color? backgroundColor,
    BorderRadiusGeometry? borderRadius,
    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
    String? primaryButtonText,
    String? secondaryButtonText,
    bool? showSecondaryButton,
    Color? primaryButtonColor,
    Color? secondaryButtonColor,
    Color? primaryButtonTextColor,
    Color? secondaryButtonTextColor,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    bool? barrierDismissible,
    Duration? autoDismissAfter,
  }) {
    return AwesomeMessageConfig(
      title: title ?? this.title,
      type: type ?? this.type,
      description: description ?? this.description,
      content: content ?? this.content,
      icon: icon ?? this.icon,
      customLottieAsset: customLottieAsset ?? this.customLottieAsset,
      accentColor: accentColor ?? this.accentColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      titleStyle: titleStyle ?? this.titleStyle,
      descriptionStyle: descriptionStyle ?? this.descriptionStyle,
      primaryButtonText: primaryButtonText ?? this.primaryButtonText,
      secondaryButtonText: secondaryButtonText ?? this.secondaryButtonText,
      showSecondaryButton: showSecondaryButton ?? this.showSecondaryButton,
      primaryButtonColor: primaryButtonColor ?? this.primaryButtonColor,
      secondaryButtonColor: secondaryButtonColor ?? this.secondaryButtonColor,
      primaryButtonTextColor:
          primaryButtonTextColor ?? this.primaryButtonTextColor,
      secondaryButtonTextColor:
          secondaryButtonTextColor ?? this.secondaryButtonTextColor,
      onPrimaryPressed: onPrimaryPressed ?? this.onPrimaryPressed,
      onSecondaryPressed: onSecondaryPressed ?? this.onSecondaryPressed,
      barrierDismissible: barrierDismissible ?? this.barrierDismissible,
      autoDismissAfter: autoDismissAfter ?? this.autoDismissAfter,
    );
  }
}
