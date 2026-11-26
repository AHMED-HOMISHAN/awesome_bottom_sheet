import 'dart:ui' show lerpDouble;

import 'package:material_ui/material_ui.dart';

import '../enums/message_type.dart';

/// App-wide defaults for every sheet shown by the package.
///
/// Install it as a [ThemeExtension] and all sheets pick it up automatically:
///
/// ```dart
/// MaterialApp(
///   theme: ThemeData(
///     extensions: const [
///       AwesomeBottomSheetThemeData(
///         borderRadius: BorderRadius.all(Radius.circular(28)),
///         successColor: Color(0xFF2E7D32),
///       ),
///     ],
///   ),
/// );
/// ```
///
/// Resolution order for every visual property is: the value passed to
/// `AwesomeMessageConfig`, then this extension, then the package default
/// derived from the app's [ColorScheme] and [TextTheme].
@immutable
class AwesomeBottomSheetThemeData
    extends ThemeExtension<AwesomeBottomSheetThemeData> {
  /// Creates sheet defaults. Every field is optional.
  const AwesomeBottomSheetThemeData({
    this.backgroundColor,
    this.borderRadius,
    this.margin,
    this.padding,
    this.maxWidth,
    this.iconSize,
    this.elevation,
    this.infoColor,
    this.successColor,
    this.warningColor,
    this.errorColor,
    this.titleStyle,
    this.descriptionStyle,
    this.primaryButtonStyle,
    this.secondaryButtonStyle,
  });

  /// Background color of the sheet card.
  final Color? backgroundColor;

  /// Corner radius of the sheet card.
  final BorderRadiusGeometry? borderRadius;

  /// Space between the card and the screen edges.
  final EdgeInsetsGeometry? margin;

  /// Space between the card edge and its content.
  final EdgeInsetsGeometry? padding;

  /// Maximum width of the card. Keeps sheets readable on tablets and desktop.
  final double? maxWidth;

  /// Width and height of the animated icon.
  final double? iconSize;

  /// Material elevation of the card.
  final double? elevation;

  /// Accent color for [AwesomeMessageType.info] sheets.
  final Color? infoColor;

  /// Accent color for [AwesomeMessageType.success] sheets.
  final Color? successColor;

  /// Accent color for [AwesomeMessageType.warning] sheets.
  final Color? warningColor;

  /// Accent color for [AwesomeMessageType.error] sheets.
  final Color? errorColor;

  /// Style merged over the default title style.
  final TextStyle? titleStyle;

  /// Style merged over the default description style.
  final TextStyle? descriptionStyle;

  /// Style merged over the default primary button style.
  final ButtonStyle? primaryButtonStyle;

  /// Style merged over the default secondary button style.
  final ButtonStyle? secondaryButtonStyle;

  /// The extension installed in the nearest [Theme], or an empty one.
  static AwesomeBottomSheetThemeData of(BuildContext context) {
    return Theme.of(context).extension<AwesomeBottomSheetThemeData>() ??
        const AwesomeBottomSheetThemeData();
  }

  /// The accent color configured for [type], if any.
  Color? colorFor(AwesomeMessageType type) => switch (type) {
    AwesomeMessageType.info => infoColor,
    AwesomeMessageType.success => successColor,
    AwesomeMessageType.warning => warningColor,
    AwesomeMessageType.error => errorColor,
  };

  @override
  AwesomeBottomSheetThemeData copyWith({
    Color? backgroundColor,
    BorderRadiusGeometry? borderRadius,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? maxWidth,
    double? iconSize,
    double? elevation,
    Color? infoColor,
    Color? successColor,
    Color? warningColor,
    Color? errorColor,
    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
    ButtonStyle? primaryButtonStyle,
    ButtonStyle? secondaryButtonStyle,
  }) {
    return AwesomeBottomSheetThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      maxWidth: maxWidth ?? this.maxWidth,
      iconSize: iconSize ?? this.iconSize,
      elevation: elevation ?? this.elevation,
      infoColor: infoColor ?? this.infoColor,
      successColor: successColor ?? this.successColor,
      warningColor: warningColor ?? this.warningColor,
      errorColor: errorColor ?? this.errorColor,
      titleStyle: titleStyle ?? this.titleStyle,
      descriptionStyle: descriptionStyle ?? this.descriptionStyle,
      primaryButtonStyle: primaryButtonStyle ?? this.primaryButtonStyle,
      secondaryButtonStyle: secondaryButtonStyle ?? this.secondaryButtonStyle,
    );
  }

  @override
  AwesomeBottomSheetThemeData lerp(
    covariant ThemeExtension<AwesomeBottomSheetThemeData>? other,
    double t,
  ) {
    if (other is! AwesomeBottomSheetThemeData) {
      return this;
    }
    return AwesomeBottomSheetThemeData(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      borderRadius: BorderRadiusGeometry.lerp(
        borderRadius,
        other.borderRadius,
        t,
      ),
      margin: EdgeInsetsGeometry.lerp(margin, other.margin, t),
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      maxWidth: lerpDouble(maxWidth, other.maxWidth, t),
      iconSize: lerpDouble(iconSize, other.iconSize, t),
      elevation: lerpDouble(elevation, other.elevation, t),
      infoColor: Color.lerp(infoColor, other.infoColor, t),
      successColor: Color.lerp(successColor, other.successColor, t),
      warningColor: Color.lerp(warningColor, other.warningColor, t),
      errorColor: Color.lerp(errorColor, other.errorColor, t),
      titleStyle: TextStyle.lerp(titleStyle, other.titleStyle, t),
      descriptionStyle: TextStyle.lerp(
        descriptionStyle,
        other.descriptionStyle,
        t,
      ),
      primaryButtonStyle: ButtonStyle.lerp(
        primaryButtonStyle,
        other.primaryButtonStyle,
        t,
      ),
      secondaryButtonStyle: ButtonStyle.lerp(
        secondaryButtonStyle,
        other.secondaryButtonStyle,
        t,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is AwesomeBottomSheetThemeData &&
        other.backgroundColor == backgroundColor &&
        other.borderRadius == borderRadius &&
        other.margin == margin &&
        other.padding == padding &&
        other.maxWidth == maxWidth &&
        other.iconSize == iconSize &&
        other.elevation == elevation &&
        other.infoColor == infoColor &&
        other.successColor == successColor &&
        other.warningColor == warningColor &&
        other.errorColor == errorColor &&
        other.titleStyle == titleStyle &&
        other.descriptionStyle == descriptionStyle &&
        other.primaryButtonStyle == primaryButtonStyle &&
        other.secondaryButtonStyle == secondaryButtonStyle;
  }

  @override
  int get hashCode => Object.hash(
    backgroundColor,
    borderRadius,
    margin,
    padding,
    maxWidth,
    iconSize,
    elevation,
    infoColor,
    successColor,
    warningColor,
    errorColor,
    titleStyle,
    descriptionStyle,
    primaryButtonStyle,
    secondaryButtonStyle,
  );
}
