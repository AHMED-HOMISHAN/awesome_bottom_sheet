import 'package:flutter/material.dart';
import '../enums/message_type.dart';

/// Helper class for theme-related utilities
class ThemeHelper {
  /// Get the appropriate color for each message type
  static Color getTypeColor(AwesomeMessageType type) {
    switch (type) {
      case AwesomeMessageType.info:
        return Colors.blue;
      case AwesomeMessageType.warning:
        return Colors.orange;
      case AwesomeMessageType.error:
        return Colors.red;
      case AwesomeMessageType.success:
        return Colors.green;
    }
  }

  /// Get the appropriate Lottie animation for each message type
  static String getLottieAnimation(AwesomeMessageType type) {
    // This will be implemented in the widget file
    switch (type) {
      case AwesomeMessageType.info:
        return 'info';
      case AwesomeMessageType.warning:
        return 'warning';
      case AwesomeMessageType.error:
        return 'error';
      case AwesomeMessageType.success:
        return 'success';
    }
  }
}
