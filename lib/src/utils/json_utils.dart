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

  static T? nullOrParse<T>(
    String key,
    Map<String, dynamic> map,
    T Function(Map<String, dynamic>) f,
  ) {
    if (map.containsKey(key)) {
      return f(map[key]);
    } else {
      return null;
    }
  }

  static void assertFields(Map<String, dynamic> map, Iterable<String> fields) {
    for (var field in fields) {
      if (!map.containsKey(field)) {
        throw ArgumentError("Field $field is required");
      }
    }
  }
}
