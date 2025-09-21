import 'package:flutter/material.dart';

import '../models/message_config.dart';
import '../enums/message_type.dart';
import '../widgets/awesome_message_bottom_sheet.dart';

/// Service class for showing awesome message bottom sheets
class AwesomeMessageService {
  /// Show info message
  static Future<T?> showInfo<T>({
    required BuildContext context,
    required String title,
    String? description,
    Color? primaryButtonColor,
    Color? secondaryButtonColor,
    String primaryButtonText = 'OK',
    String secondaryButtonText = 'Close',
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    Color? primaryButtonTextColor,
    Color? secondaryButtonTextColor,
    String? customLottieAsset,
    bool barrierDismissible = false,
  }) {
    return _showAwesomeMessage<T>(
      context: context,
      config: AwesomeMessageConfig(
        title: title,
        description: description,
        type: AwesomeMessageType.info,
        primaryButtonColor: primaryButtonColor,
        secondaryButtonColor: secondaryButtonColor,
        primaryButtonText: primaryButtonText,
        secondaryButtonText: secondaryButtonText,
        onPrimaryPressed: onPrimaryPressed,
        onSecondaryPressed: onSecondaryPressed,
        primaryButtonTextColor: primaryButtonTextColor,
        secondaryButtonTextColor: secondaryButtonTextColor,
        customLottieAsset: customLottieAsset,
        barrierDismissible: barrierDismissible,
      ),
    );
  }

  /// Show warning message
  static Future<T?> showWarning<T>({
    required BuildContext context,
    required String title,
    String? description,
    Color? primaryButtonColor,
    Color? secondaryButtonColor,
    String primaryButtonText = 'OK',
    String secondaryButtonText = 'Close',
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    Color? primaryButtonTextColor,
    Color? secondaryButtonTextColor,
    String? customLottieAsset,
    bool barrierDismissible = false,
  }) {
    return _showAwesomeMessage<T>(
      context: context,
      config: AwesomeMessageConfig(
        title: title,
        description: description,
        type: AwesomeMessageType.warning,
        primaryButtonColor: primaryButtonColor,
        secondaryButtonColor: secondaryButtonColor,
        primaryButtonText: primaryButtonText,
        secondaryButtonText: secondaryButtonText,
        onPrimaryPressed: onPrimaryPressed,
        onSecondaryPressed: onSecondaryPressed,
        primaryButtonTextColor: primaryButtonTextColor,
        secondaryButtonTextColor: secondaryButtonTextColor,
        customLottieAsset: customLottieAsset,
        barrierDismissible: barrierDismissible,
      ),
    );
  }

  /// Show error message
  static Future<T?> showError<T>({
    required BuildContext context,
    required String title,
    String? description,
    Color? primaryButtonColor,
    Color? secondaryButtonColor,
    String primaryButtonText = 'OK',
    String secondaryButtonText = 'Close',
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    Color? primaryButtonTextColor,
    Color? secondaryButtonTextColor,
    String? customLottieAsset,
    bool barrierDismissible = false,
  }) {
    return _showAwesomeMessage<T>(
      context: context,
      config: AwesomeMessageConfig(
        title: title,
        description: description,
        type: AwesomeMessageType.error,
        primaryButtonColor: primaryButtonColor,
        secondaryButtonColor: secondaryButtonColor,
        primaryButtonText: primaryButtonText,
        secondaryButtonText: secondaryButtonText,
        onPrimaryPressed: onPrimaryPressed,
        onSecondaryPressed: onSecondaryPressed,
        primaryButtonTextColor: primaryButtonTextColor,
        secondaryButtonTextColor: secondaryButtonTextColor,
        customLottieAsset: customLottieAsset,
        barrierDismissible: barrierDismissible,
      ),
    );
  }

  /// Show success message
  static Future<T?> showSuccess<T>({
    required BuildContext context,
    required String title,
    String? description,
    Color? primaryButtonColor,
    Color? secondaryButtonColor,
    String primaryButtonText = 'OK',
    String secondaryButtonText = 'Close',
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    Color? primaryButtonTextColor,
    Color? secondaryButtonTextColor,
    String? customLottieAsset,
    bool barrierDismissible = false,
  }) {
    return _showAwesomeMessage<T>(
      context: context,
      config: AwesomeMessageConfig(
        title: title,
        description: description,
        type: AwesomeMessageType.success,
        primaryButtonColor: primaryButtonColor,
        secondaryButtonColor: secondaryButtonColor,
        primaryButtonText: primaryButtonText,
        secondaryButtonText: secondaryButtonText,
        onPrimaryPressed: onPrimaryPressed,
        onSecondaryPressed: onSecondaryPressed,
        primaryButtonTextColor: primaryButtonTextColor,
        secondaryButtonTextColor: secondaryButtonTextColor,
        customLottieAsset: customLottieAsset,
        barrierDismissible: barrierDismissible,
      ),
    );
  }

  /// Internal method to show the awesome message
  static Future<T?> _showAwesomeMessage<T>({
    required BuildContext context,
    required AwesomeMessageConfig config,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      isDismissible: config.barrierDismissible,
      enableDrag: config.barrierDismissible,
      backgroundColor: Colors.transparent,
      builder: (context) => AwesomeMessageBottomSheet(config: config),
    );
  }
}
