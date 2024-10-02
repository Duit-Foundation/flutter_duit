import 'package:duit_kernel/duit_kernel.dart';

import 'jsono.dart';

class JsonUtils {
  ///Modifies the original [model] object by adding values from the [dataSource]
  ///object to it if there are [ValueReference] objects in the attributes
  static Map<String, dynamic> mergeWithDataSource(
    DuitComponentDescription model,
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

  ///Modifies the original [layout] object by adding values from the [data]
  ///object to it if there are [ValueReference] objects in the attributes
  @Deprecated("Use mergeWithDataSource instead")
  static Map<String, dynamic> fillComponentProperties(
    JSONObject layout,
    JSONObject dataSource,
  ) {
    final src = Map<String, dynamic>.from(layout);

    void replaceId(JSONObject map) {
      if (map["controlled"] == true) {
        final type = map["type"];
        final timestamp = DateTime.now().microsecondsSinceEpoch;
        final id = "${type}_$timestamp";
        map["id"] = id;
      }
    }

    if (dataSource.values.isEmpty) {
      replaceId(src);
      return src;
    }

    final attributes = src["attributes"];
    final refs = List.from(attributes?["refs"] ?? []);

    replaceId(src);

    for (var ref in refs) {
      final payload = ValueReference.fromJson(ref);
      final value = dataSource[payload.objectKey];

      if (value != null) {
        attributes?[payload.attributeKey] = value;
      }
    }

    if (src["child"] != null) {
      final child = fillComponentProperties(
        src["child"],
        dataSource,
      );

      src["child"] = child;
    }

    if (src["children"] != null) {
      final children = List.from(src["children"]);
      final ln = children.length;
      final arr = [];
      for (var i = 0; i < ln; i++) {
        final child = fillComponentProperties(
          children[i],
          dataSource,
        );

        arr.add(child);
      }

      src["children"] = arr;
    }

    return src;
  }
}
