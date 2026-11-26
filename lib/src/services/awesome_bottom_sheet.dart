import 'package:material_ui/material_ui.dart';

import '../enums/message_result.dart';
import '../enums/message_type.dart';
import '../models/message_config.dart';
import '../widgets/awesome_message_bottom_sheet.dart';

/// Shows animated feedback bottom sheets.
///
/// Every method returns an [AwesomeMessageResult] that tells you how the
/// sheet was closed, so you can `await` it instead of wiring callbacks:
///
/// ```dart
/// final result = await AwesomeBottomSheet.showError(
///   context: context,
///   title: 'Upload failed',
///   description: 'Check your connection and try again.',
///   primaryButtonText: 'Retry',
/// );
/// if (result.isPrimary) retryUpload();
/// ```
///
/// Use [show] to pick the type at runtime, or [showConfig] to reuse a
/// prebuilt [AwesomeMessageConfig].
abstract final class AwesomeBottomSheet {
  /// Shows a sheet of the given [type].
  ///
  /// See [AwesomeMessageConfig] for what each parameter does. The last three
  /// parameters are forwarded to [showModalBottomSheet].
  static Future<AwesomeMessageResult> show({
    required BuildContext context,
    required AwesomeMessageType type,
    required String title,
    String? description,
    Widget? content,
    Widget? icon,
    String? customLottieAsset,
    Color? accentColor,
    Color? backgroundColor,
    BorderRadiusGeometry? borderRadius,
    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
    String primaryButtonText = 'OK',
    String secondaryButtonText = 'Close',
    bool showSecondaryButton = true,
    Color? primaryButtonColor,
    Color? secondaryButtonColor,
    Color? primaryButtonTextColor,
    Color? secondaryButtonTextColor,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    bool barrierDismissible = true,
    Duration? autoDismissAfter,
    bool useRootNavigator = false,
    RouteSettings? routeSettings,
    Color? barrierColor,
  }) {
    return showConfig(
      context: context,
      config: AwesomeMessageConfig(
        title: title,
        type: type,
        description: description,
        content: content,
        icon: icon,
        customLottieAsset: customLottieAsset,
        accentColor: accentColor,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        titleStyle: titleStyle,
        descriptionStyle: descriptionStyle,
        primaryButtonText: primaryButtonText,
        secondaryButtonText: secondaryButtonText,
        showSecondaryButton: showSecondaryButton,
        primaryButtonColor: primaryButtonColor,
        secondaryButtonColor: secondaryButtonColor,
        primaryButtonTextColor: primaryButtonTextColor,
        secondaryButtonTextColor: secondaryButtonTextColor,
        onPrimaryPressed: onPrimaryPressed,
        onSecondaryPressed: onSecondaryPressed,
        barrierDismissible: barrierDismissible,
        autoDismissAfter: autoDismissAfter,
      ),
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      barrierColor: barrierColor,
    );
  }

  /// Shows a sheet described by [config].
  ///
  /// [useRootNavigator], [routeSettings] and [barrierColor] are forwarded to
  /// [showModalBottomSheet]. Resolves with [AwesomeMessageResult.dismissed]
  /// when the sheet is closed without tapping a button.
  static Future<AwesomeMessageResult> showConfig({
    required BuildContext context,
    required AwesomeMessageConfig config,
    bool useRootNavigator = false,
    RouteSettings? routeSettings,
    Color? barrierColor,
  }) async {
    final result = await showModalBottomSheet<AwesomeMessageResult>(
      context: context,
      isScrollControlled: true,
      isDismissible: config.barrierDismissible,
      enableDrag: config.barrierDismissible,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      barrierColor: barrierColor,
      backgroundColor: Colors.transparent,
      elevation: 0,
      clipBehavior: Clip.none,
      builder: (_) => AwesomeMessageBottomSheet(config: config),
    );
    return result ?? AwesomeMessageResult.dismissed;
  }

  /// Shows an [AwesomeMessageType.info] sheet. See [show].
  static Future<AwesomeMessageResult> showInfo({
    required BuildContext context,
    required String title,
    String? description,
    Widget? content,
    Widget? icon,
    String? customLottieAsset,
    Color? accentColor,
    Color? backgroundColor,
    BorderRadiusGeometry? borderRadius,
    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
    String primaryButtonText = 'OK',
    String secondaryButtonText = 'Close',
    bool showSecondaryButton = true,
    Color? primaryButtonColor,
    Color? secondaryButtonColor,
    Color? primaryButtonTextColor,
    Color? secondaryButtonTextColor,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    bool barrierDismissible = true,
    Duration? autoDismissAfter,
    bool useRootNavigator = false,
    RouteSettings? routeSettings,
    Color? barrierColor,
  }) {
    return show(
      context: context,
      type: AwesomeMessageType.info,
      title: title,
      description: description,
      content: content,
      icon: icon,
      customLottieAsset: customLottieAsset,
      accentColor: accentColor,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      titleStyle: titleStyle,
      descriptionStyle: descriptionStyle,
      primaryButtonText: primaryButtonText,
      secondaryButtonText: secondaryButtonText,
      showSecondaryButton: showSecondaryButton,
      primaryButtonColor: primaryButtonColor,
      secondaryButtonColor: secondaryButtonColor,
      primaryButtonTextColor: primaryButtonTextColor,
      secondaryButtonTextColor: secondaryButtonTextColor,
      onPrimaryPressed: onPrimaryPressed,
      onSecondaryPressed: onSecondaryPressed,
      barrierDismissible: barrierDismissible,
      autoDismissAfter: autoDismissAfter,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      barrierColor: barrierColor,
    );
  }

  /// Shows an [AwesomeMessageType.success] sheet. See [show].
  static Future<AwesomeMessageResult> showSuccess({
    required BuildContext context,
    required String title,
    String? description,
    Widget? content,
    Widget? icon,
    String? customLottieAsset,
    Color? accentColor,
    Color? backgroundColor,
    BorderRadiusGeometry? borderRadius,
    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
    String primaryButtonText = 'OK',
    String secondaryButtonText = 'Close',
    bool showSecondaryButton = true,
    Color? primaryButtonColor,
    Color? secondaryButtonColor,
    Color? primaryButtonTextColor,
    Color? secondaryButtonTextColor,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    bool barrierDismissible = true,
    Duration? autoDismissAfter,
    bool useRootNavigator = false,
    RouteSettings? routeSettings,
    Color? barrierColor,
  }) {
    return show(
      context: context,
      type: AwesomeMessageType.success,
      title: title,
      description: description,
      content: content,
      icon: icon,
      customLottieAsset: customLottieAsset,
      accentColor: accentColor,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      titleStyle: titleStyle,
      descriptionStyle: descriptionStyle,
      primaryButtonText: primaryButtonText,
      secondaryButtonText: secondaryButtonText,
      showSecondaryButton: showSecondaryButton,
      primaryButtonColor: primaryButtonColor,
      secondaryButtonColor: secondaryButtonColor,
      primaryButtonTextColor: primaryButtonTextColor,
      secondaryButtonTextColor: secondaryButtonTextColor,
      onPrimaryPressed: onPrimaryPressed,
      onSecondaryPressed: onSecondaryPressed,
      barrierDismissible: barrierDismissible,
      autoDismissAfter: autoDismissAfter,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      barrierColor: barrierColor,
    );
  }

  /// Shows an [AwesomeMessageType.warning] sheet. See [show].
  static Future<AwesomeMessageResult> showWarning({
    required BuildContext context,
    required String title,
    String? description,
    Widget? content,
    Widget? icon,
    String? customLottieAsset,
    Color? accentColor,
    Color? backgroundColor,
    BorderRadiusGeometry? borderRadius,
    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
    String primaryButtonText = 'OK',
    String secondaryButtonText = 'Close',
    bool showSecondaryButton = true,
    Color? primaryButtonColor,
    Color? secondaryButtonColor,
    Color? primaryButtonTextColor,
    Color? secondaryButtonTextColor,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    bool barrierDismissible = true,
    Duration? autoDismissAfter,
    bool useRootNavigator = false,
    RouteSettings? routeSettings,
    Color? barrierColor,
  }) {
    return show(
      context: context,
      type: AwesomeMessageType.warning,
      title: title,
      description: description,
      content: content,
      icon: icon,
      customLottieAsset: customLottieAsset,
      accentColor: accentColor,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      titleStyle: titleStyle,
      descriptionStyle: descriptionStyle,
      primaryButtonText: primaryButtonText,
      secondaryButtonText: secondaryButtonText,
      showSecondaryButton: showSecondaryButton,
      primaryButtonColor: primaryButtonColor,
      secondaryButtonColor: secondaryButtonColor,
      primaryButtonTextColor: primaryButtonTextColor,
      secondaryButtonTextColor: secondaryButtonTextColor,
      onPrimaryPressed: onPrimaryPressed,
      onSecondaryPressed: onSecondaryPressed,
      barrierDismissible: barrierDismissible,
      autoDismissAfter: autoDismissAfter,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      barrierColor: barrierColor,
    );
  }

  /// Shows an [AwesomeMessageType.error] sheet. See [show].
  static Future<AwesomeMessageResult> showError({
    required BuildContext context,
    required String title,
    String? description,
    Widget? content,
    Widget? icon,
    String? customLottieAsset,
    Color? accentColor,
    Color? backgroundColor,
    BorderRadiusGeometry? borderRadius,
    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
    String primaryButtonText = 'OK',
    String secondaryButtonText = 'Close',
    bool showSecondaryButton = true,
    Color? primaryButtonColor,
    Color? secondaryButtonColor,
    Color? primaryButtonTextColor,
    Color? secondaryButtonTextColor,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    bool barrierDismissible = true,
    Duration? autoDismissAfter,
    bool useRootNavigator = false,
    RouteSettings? routeSettings,
    Color? barrierColor,
  }) {
    return show(
      context: context,
      type: AwesomeMessageType.error,
      title: title,
      description: description,
      content: content,
      icon: icon,
      customLottieAsset: customLottieAsset,
      accentColor: accentColor,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      titleStyle: titleStyle,
      descriptionStyle: descriptionStyle,
      primaryButtonText: primaryButtonText,
      secondaryButtonText: secondaryButtonText,
      showSecondaryButton: showSecondaryButton,
      primaryButtonColor: primaryButtonColor,
      secondaryButtonColor: secondaryButtonColor,
      primaryButtonTextColor: primaryButtonTextColor,
      secondaryButtonTextColor: secondaryButtonTextColor,
      onPrimaryPressed: onPrimaryPressed,
      onSecondaryPressed: onSecondaryPressed,
      barrierDismissible: barrierDismissible,
      autoDismissAfter: autoDismissAfter,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      barrierColor: barrierColor,
    );
  }
}

/// The 0.x name of [AwesomeBottomSheet].
///
/// Existing calls such as `AwesomeMessageService.showInfo(...)` keep working.
/// Migrate to [AwesomeBottomSheet]; this alias will be removed in 2.0.0.
@Deprecated('Use AwesomeBottomSheet instead. Will be removed in 2.0.0.')
typedef AwesomeMessageService = AwesomeBottomSheet;
