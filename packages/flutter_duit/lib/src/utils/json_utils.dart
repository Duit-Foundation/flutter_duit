import "package:duit_kernel/duit_kernel.dart";

sealed class JsonUtils {
  /// Safely extracts a child map from JSON data.
  ///
  /// Returns null if the key doesn't exist or the value is not a valid Map.
  @preferInline
  static Map<String, dynamic>? extractMap(
    Map<String, dynamic> json,
    String key,
  ) {
    final value = json[key];
    if (value is Map<String, dynamic>) {
      return value;
    }
    if (value is Map) {
      try {
        return value.cast<String, dynamic>();
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  /// Safely extracts a list of values of type [T] from JSON data at [key].
  ///
  /// Returns an empty list if the key doesn't exist or contains invalid data.
  @preferInline
  static List<T> extractList<T>(
    Map<String, dynamic> json,
    String key,
  ) {
    final value = json[key];
    if (value is List<T>) return value;
    if (value is List) return value.cast<T>(); // throws if any element is not T
    return const [];
  }
}
