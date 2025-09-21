/// Model class for Lottie animation data
class LottieData {
  /// The name/identifier of the animation
  final String name;

  /// The JSON data as a Map for better type safety
  final Map<String, dynamic> jsonData;

  /// Duration of the animation in seconds
  final double duration;

  /// Whether the animation should repeat
  final bool repeat;

  /// Frame rate of the animation
  final int frameRate;

  const LottieData({
    required this.name,
    required this.jsonData,
    required this.duration,
    this.repeat = true,
    this.frameRate = 60,
  });

  /// Convert to JSON string for Lottie.memory
  String toJsonString() {
    return jsonData
        .toString()
        .replaceAll('{', '{\n  ')
        .replaceAll('}', '\n}')
        .replaceAll(', ', ',\n  ');
  }

  /// Get properly formatted JSON string
  String get formattedJson {
    final buffer = StringBuffer();
    _writeJsonObject(buffer, jsonData, 0);
    return buffer.toString();
  }

  void _writeJsonObject(StringBuffer buffer, dynamic obj, int indent) {
    final indentStr = '  ' * indent;

    if (obj is Map) {
      buffer.writeln('{');
      final entries = obj.entries.toList();
      for (int i = 0; i < entries.length; i++) {
        final entry = entries[i];
        buffer.write('$indentStr  "${entry.key}": ');
        _writeJsonObject(buffer, entry.value, indent + 1);
        if (i < entries.length - 1) buffer.write(',');
        buffer.writeln();
      }
      buffer.write('$indentStr}');
    } else if (obj is List) {
      buffer.write('[');
      for (int i = 0; i < obj.length; i++) {
        if (i > 0) buffer.write(', ');
        _writeJsonObject(buffer, obj[i], indent);
      }
      buffer.write(']');
    } else if (obj is String) {
      buffer.write('"$obj"');
    } else {
      buffer.write(obj.toString());
    }
  }
}
