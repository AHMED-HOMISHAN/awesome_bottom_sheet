import 'package:flutter/material.dart';
import '../enums/message_type.dart';

/// Configuration class for awesome message appearance and behavior
class AwesomeMessageConfig {
  /// The main title text (required)
  final String title;

  /// Optional description text
  final String? description;

  /// The type of message (info, warning, error, success)
  final AwesomeMessageType type;

  /// Custom color for the primary button
  final Color? primaryButtonColor;

  /// Custom color for the secondary button
  final Color? secondaryButtonColor;

  /// Text for the primary button (default: 'OK')
  final String primaryButtonText;

  /// Text for the secondary button (default: 'Close')
  final String secondaryButtonText;

  /// Callback function for primary button press
  final VoidCallback? onPrimaryPressed;

  /// Callback function for secondary button press
  final VoidCallback? onSecondaryPressed;

  /// Custom text color for primary button
  final Color? primaryButtonTextColor;

  /// Custom text color for secondary button
  final Color? secondaryButtonTextColor;

  /// Path to custom Lottie animation asset
  final String? customLottieAsset;

  /// Whether the bottom sheet can be dismissed by tapping outside
  final bool barrierDismissible;

  const AwesomeMessageConfig({
    required this.title,
    this.description,
    required this.type,
    this.primaryButtonColor,
    this.secondaryButtonColor,
    this.primaryButtonText = 'OK',
    this.secondaryButtonText = 'Close',
    this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.primaryButtonTextColor,
    this.secondaryButtonTextColor,
    this.customLottieAsset,
    this.barrierDismissible = true,
  });
}
