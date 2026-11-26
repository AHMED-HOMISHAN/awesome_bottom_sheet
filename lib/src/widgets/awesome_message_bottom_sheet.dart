import 'dart:async';

import 'package:lottie/lottie.dart';
import 'package:material_ui/material_ui.dart';

import '../constants/lottie_animations.dart';
import '../enums/message_result.dart';
import '../models/message_config.dart';
import '../theme/awesome_bottom_sheet_theme.dart';

/// The card rendered inside the modal route opened by `AwesomeBottomSheet`.
///
/// You normally do not build this widget yourself. Use it directly only when
/// you need full control over the route, for example with a custom
/// [showModalBottomSheet] call or a declarative router:
///
/// ```dart
/// showModalBottomSheet<AwesomeMessageResult>(
///   context: context,
///   isScrollControlled: true,
///   backgroundColor: Colors.transparent,
///   builder: (_) => AwesomeMessageBottomSheet(config: config),
/// );
/// ```
///
/// The widget pops the enclosing route with an [AwesomeMessageResult] when a
/// button is tapped or `autoDismissAfter` elapses.
class AwesomeMessageBottomSheet extends StatefulWidget {
  /// Creates the sheet card for [config].
  const AwesomeMessageBottomSheet({super.key, required this.config});

  /// What to show and how to behave.
  final AwesomeMessageConfig config;

  /// Default icon size when neither the config nor the theme sets one.
  static const double defaultIconSize = 80;

  /// Default maximum card width.
  static const double defaultMaxWidth = 560;

  /// Default space between the card and the screen edges.
  static const EdgeInsets defaultMargin = EdgeInsets.all(16);

  /// Default space between the card edge and its content.
  static const EdgeInsets defaultPadding = EdgeInsets.all(24);

  /// Default corner radius of the card.
  static const BorderRadius defaultBorderRadius = BorderRadius.all(
    Radius.circular(20),
  );

  /// Default elevation of the card.
  static const double defaultElevation = 8;

  /// Length of the entrance animation of the card content.
  static const Duration entranceDuration = Duration(milliseconds: 350);

  @override
  State<AwesomeMessageBottomSheet> createState() =>
      _AwesomeMessageBottomSheetState();
}

class _AwesomeMessageBottomSheetState extends State<AwesomeMessageBottomSheet>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _iconScale;
  Timer? _autoDismissTimer;
  bool _started = false;
  bool _closed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AwesomeMessageBottomSheet.entranceDuration,
    );
    _fade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.6, curve: Curves.easeOut),
    );
    _iconScale = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );
    final autoDismissAfter = widget.config.autoDismissAfter;
    if (autoDismissAfter != null) {
      _autoDismissTimer = Timer(
        autoDismissAfter,
        () => _close(AwesomeMessageResult.autoDismissed),
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) {
      return;
    }
    _started = true;
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = 1;
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _autoDismissTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _close(AwesomeMessageResult result) {
    if (_closed || !mounted) {
      return;
    }
    _closed = true;
    _autoDismissTimer?.cancel();
    Navigator.of(context).pop(result);
    switch (result) {
      case AwesomeMessageResult.primary:
        widget.config.onPrimaryPressed?.call();
      case AwesomeMessageResult.secondary:
        widget.config.onSecondaryPressed?.call();
      case AwesomeMessageResult.dismissed:
      case AwesomeMessageResult.autoDismissed:
        break;
    }
  }

  /// A text color that stays readable on [background].
  static Color _foregroundFor(Color background) {
    return ThemeData.estimateBrightnessForColor(background) == Brightness.dark
        ? Colors.white
        : Colors.black87;
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final sheetTheme = AwesomeBottomSheetThemeData.of(context);
    final screenSize = MediaQuery.sizeOf(context);
    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    final accent =
        config.accentColor ??
        sheetTheme.colorFor(config.type) ??
        config.type.defaultColor;
    final background =
        config.backgroundColor ??
        sheetTheme.backgroundColor ??
        theme.bottomSheetTheme.backgroundColor ??
        colorScheme.surface;
    final borderRadius =
        config.borderRadius ??
        sheetTheme.borderRadius ??
        AwesomeMessageBottomSheet.defaultBorderRadius;
    final margin = sheetTheme.margin ?? AwesomeMessageBottomSheet.defaultMargin;
    final padding =
        sheetTheme.padding ?? AwesomeMessageBottomSheet.defaultPadding;
    final maxWidth =
        sheetTheme.maxWidth ?? AwesomeMessageBottomSheet.defaultMaxWidth;
    final iconSize =
        sheetTheme.iconSize ?? AwesomeMessageBottomSheet.defaultIconSize;
    final elevation =
        sheetTheme.elevation ?? AwesomeMessageBottomSheet.defaultElevation;

    final titleStyle = (theme.textTheme.headlineSmall ?? const TextStyle())
        .copyWith(fontWeight: FontWeight.bold, color: accent)
        .merge(sheetTheme.titleStyle)
        .merge(config.titleStyle);
    final descriptionStyle = (theme.textTheme.bodyMedium ?? const TextStyle())
        .copyWith(color: colorScheme.onSurfaceVariant)
        .merge(sheetTheme.descriptionStyle)
        .merge(config.descriptionStyle);

    final maxHeight =
        (screenSize.height - keyboardInset) * 0.9 - margin.vertical;

    return PopScope(
      canPop: config.barrierDismissible,
      child: Padding(
        padding: EdgeInsets.only(bottom: keyboardInset),
        child: SafeArea(
          top: false,
          child: Align(
            alignment: Alignment.bottomCenter,
            // Without heightFactor the Align would grow to the full height
            // the route offers, which breaks drag-to-dismiss distances.
            heightFactor: 1,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxWidth,
                maxHeight: maxHeight.clamp(200.0, double.infinity),
              ),
              child: Padding(
                padding: margin,
                child: FadeTransition(
                  opacity: _fade,
                  child: Material(
                    color: background,
                    elevation: elevation,
                    shadowColor: colorScheme.shadow.withValues(alpha: 0.6),
                    surfaceTintColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: borderRadius),
                    clipBehavior: Clip.antiAlias,
                    child: Padding(
                      padding: padding,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildIcon(iconSize, reduceMotion),
                                  const SizedBox(height: 16),
                                  Semantics(
                                    header: true,
                                    child: Text(
                                      config.title,
                                      style: titleStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  if (config.description != null) ...[
                                    const SizedBox(height: 12),
                                    Text(
                                      config.description!,
                                      style: descriptionStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                  if (config.content != null) ...[
                                    const SizedBox(height: 16),
                                    config.content!,
                                  ],
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          _buildButtons(accent, colorScheme, sheetTheme),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(double size, bool reduceMotion) {
    final config = widget.config;
    final Widget icon;
    if (config.icon != null) {
      icon = config.icon!;
    } else if (config.customLottieAsset != null) {
      icon = Lottie.asset(
        config.customLottieAsset!,
        repeat: !reduceMotion,
        fit: BoxFit.contain,
      );
    } else {
      final animation = LottieAnimations.forType(config.type);
      icon = Lottie.memory(
        animation.bytes,
        repeat: animation.repeat && !reduceMotion,
        frameRate: FrameRate.composition,
        fit: BoxFit.contain,
      );
    }
    return ExcludeSemantics(
      child: ScaleTransition(
        scale: _iconScale,
        child: SizedBox.square(dimension: size, child: icon),
      ),
    );
  }

  Widget _buildButtons(
    Color accent,
    ColorScheme colorScheme,
    AwesomeBottomSheetThemeData sheetTheme,
  ) {
    final config = widget.config;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    );

    final primaryBackground = config.primaryButtonColor ?? accent;
    final primaryStyle =
        ButtonStyle(
              backgroundColor: config.primaryButtonColor == null
                  ? null
                  : WidgetStatePropertyAll(config.primaryButtonColor),
              foregroundColor: config.primaryButtonTextColor == null
                  ? null
                  : WidgetStatePropertyAll(config.primaryButtonTextColor),
            )
            .merge(sheetTheme.primaryButtonStyle)
            .merge(
              FilledButton.styleFrom(
                backgroundColor: primaryBackground,
                foregroundColor: _foregroundFor(primaryBackground),
                minimumSize: const Size.fromHeight(48),
                shape: shape,
              ),
            );
    final primaryButton = FilledButton(
      style: primaryStyle,
      onPressed: () => _close(AwesomeMessageResult.primary),
      child: Text(config.primaryButtonText),
    );

    if (!config.showSecondaryButton) {
      return SizedBox(width: double.infinity, child: primaryButton);
    }

    final secondaryStyle =
        ButtonStyle(
              foregroundColor: config.secondaryButtonTextColor == null
                  ? null
                  : WidgetStatePropertyAll(config.secondaryButtonTextColor),
              side: config.secondaryButtonColor == null
                  ? null
                  : WidgetStatePropertyAll(
                      BorderSide(color: config.secondaryButtonColor!),
                    ),
            )
            .merge(sheetTheme.secondaryButtonStyle)
            .merge(
              OutlinedButton.styleFrom(
                foregroundColor: colorScheme.onSurfaceVariant,
                side: BorderSide(color: colorScheme.outlineVariant),
                minimumSize: const Size.fromHeight(48),
                shape: shape,
              ),
            );

    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            style: secondaryStyle,
            onPressed: () => _close(AwesomeMessageResult.secondary),
            child: Text(config.secondaryButtonText),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: primaryButton),
      ],
    );
  }
}
