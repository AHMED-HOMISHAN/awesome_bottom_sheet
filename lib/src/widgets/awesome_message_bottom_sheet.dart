import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../models/message_config.dart';
import '../models/lottie_data.dart';
import '../enums/message_type.dart';
import '../utils/theme_helper.dart';
import '../constants/lottie_animations.dart';

/// Main widget for displaying awesome messages in a bottom sheet
class AwesomeMessageBottomSheet extends StatefulWidget {
  /// Configuration for the message appearance and behavior
  final AwesomeMessageConfig config;

  const AwesomeMessageBottomSheet({
    super.key,
    required this.config,
  });

  @override
  State<AwesomeMessageBottomSheet> createState() =>
      _AwesomeMessageBottomSheetState();
}

class _AwesomeMessageBottomSheetState extends State<AwesomeMessageBottomSheet>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Get the default Lottie animation data for the message type
  LottieData _getDefaultLottieData() {
    switch (widget.config.type) {
      case AwesomeMessageType.info:
        return LottieAnimations.info;
      case AwesomeMessageType.success:
        return LottieAnimations.success;
      case AwesomeMessageType.warning:
        return LottieAnimations.warning;
      case AwesomeMessageType.error:
        return LottieAnimations.error;
    }
  }

  /// Build the animated icon widget
  Widget _buildIcon() {
    // Use custom Lottie asset if provided
    if (widget.config.customLottieAsset != null) {
      return SizedBox(
        width: 80,
        height: 80,
        child: Lottie.asset(
          widget.config.customLottieAsset!,
          repeat: true,
          animate: true,
        ),
      );
    }

    // Use default Lottie animations
    final lottieData = _getDefaultLottieData();
    return SizedBox(
      width: 80,
      height: 80,
      child: Lottie.memory(
        utf8.encode(lottieData.formattedJson),
        repeat: lottieData.repeat,
        animate: true,
        frameRate: FrameRate.max,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final typeColor = ThemeHelper.getTypeColor(widget.config.type);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon
                    _buildIcon(),
                    const SizedBox(height: 16),

                    // Title
                    Text(
                      widget.config.title,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: typeColor,
                              ),
                      textAlign: TextAlign.center,
                    ),

                    // Description (optional)
                    if (widget.config.description != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        widget.config.description!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],

                    const SizedBox(height: 24),

                    // Buttons
                    Row(
                      children: [
                        // Secondary button (Close)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              widget.config.onSecondaryPressed?.call();
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor:
                                  widget.config.secondaryButtonTextColor ??
                                      Colors.grey[600],
                              side: BorderSide(
                                color: widget.config.secondaryButtonColor ??
                                    Colors.grey[300]!,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(widget.config.secondaryButtonText),
                          ),
                        ),

                        const SizedBox(width: 12),

                        // Primary button (OK)
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              widget.config.onPrimaryPressed?.call();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  widget.config.primaryButtonColor ?? typeColor,
                              foregroundColor:
                                  widget.config.primaryButtonTextColor ??
                                      Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(widget.config.primaryButtonText),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
