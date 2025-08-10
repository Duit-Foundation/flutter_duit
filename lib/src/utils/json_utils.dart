import 'package:duit_kernel/duit_kernel.dart';

sealed class JsonUtils {
  ///Modifies the original [model] object by adding values from the [dataSource]
  ///object to it if there are [ValueReference] objects in the attributes
  static Map<String, dynamic> mergeWithDataSource(
    ComponentDescription model,
    Map<String, dynamic> dataSource,
  ) {
    for (var rwT in model.refs) {
      final vRef = rwT.ref;
      dynamic value;

      if (dataSource[vRef.objectKey] != null) {
        value = dataSource[vRef.objectKey];
      } else if (vRef.defaultValue != null) {
        value = vRef.defaultValue;
      } else {
        value = null;
      }

      if (value != null) {
        rwT.target[vRef.attributeKey] = value;
      }
    }

    return model.data;
  }

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
