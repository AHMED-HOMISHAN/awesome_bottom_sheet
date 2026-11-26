/// How a message bottom sheet was closed.
///
/// Returned by every `AwesomeBottomSheet.show*` method, so callers can react
/// to the user's choice without wiring callbacks:
///
/// ```dart
/// final result = await AwesomeBottomSheet.showWarning(
///   context: context,
///   title: 'Delete account?',
///   primaryButtonText: 'Delete',
///   secondaryButtonText: 'Keep',
/// );
/// if (result.isPrimary) deleteAccount();
/// ```
enum AwesomeMessageResult {
  /// The primary button was tapped.
  primary,

  /// The secondary button was tapped.
  secondary,

  /// The sheet was dismissed by tapping the barrier, dragging it down or
  /// navigating back.
  dismissed,

  /// The sheet closed itself because `autoDismissAfter` elapsed.
  autoDismissed;

  /// Whether the primary button was tapped.
  bool get isPrimary => this == AwesomeMessageResult.primary;

  /// Whether the secondary button was tapped.
  bool get isSecondary => this == AwesomeMessageResult.secondary;

  /// Whether the sheet closed without either button being tapped.
  bool get isDismissed =>
      this == AwesomeMessageResult.dismissed ||
      this == AwesomeMessageResult.autoDismissed;
}
