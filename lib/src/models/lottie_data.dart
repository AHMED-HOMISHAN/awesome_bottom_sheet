import 'dart:convert';
import 'dart:typed_data';

/// An in-memory Lottie animation described by its JSON document.
///
/// The package ships one instance per message type in `LottieAnimations`.
/// You can create your own to supply a custom animation without bundling an
/// asset file:
///
/// ```dart
/// const celebrate = LottieData(
///   name: 'celebrate',
///   duration: 1.2,
///   jsonData: {/* Lottie JSON */},
/// );
/// Lottie.memory(celebrate.bytes);
/// ```
class LottieData {
  /// Creates an animation from its decoded Lottie JSON.
  const LottieData({
    required this.name,
    required this.jsonData,
    required this.duration,
    this.repeat = true,
    this.frameRate = 60,
  });

  /// A short identifier, used for debugging and as a semantic hint.
  final String name;

  /// The decoded Lottie JSON document.
  final Map<String, dynamic> jsonData;

  /// Duration of one loop, in seconds.
  final double duration;

  /// Whether the animation should loop while the sheet is open.
  final bool repeat;

  /// The frame rate the animation was authored at.
  final int frameRate;

  static final Expando<Uint8List> _bytesCache = Expando<Uint8List>(
    'LottieData.bytes',
  );

  /// The animation encoded as UTF-8 JSON, ready for `Lottie.memory`.
  ///
  /// The bytes are computed once per instance and cached. Handing the same
  /// buffer to the lottie package on every build lets it reuse the parsed
  /// composition instead of decoding the JSON again.
  Uint8List get bytes =>
      _bytesCache[this] ??= utf8.encode(jsonEncode(jsonData));

  /// The animation as a compact JSON string.
  @Deprecated(
    'Use `bytes` with Lottie.memory, or jsonEncode(jsonData). '
    'This member will be removed in 2.0.0.',
  )
  String toJsonString() => jsonEncode(jsonData);

  /// The animation as an indented JSON string.
  @Deprecated(
    'Use `bytes` with Lottie.memory, or JsonEncoder.withIndent for '
    'pretty printing. This member will be removed in 2.0.0.',
  )
  String get formattedJson =>
      const JsonEncoder.withIndent('  ').convert(jsonData);

  @override
  String toString() => 'LottieData($name, ${duration}s, repeat: $repeat)';
}
