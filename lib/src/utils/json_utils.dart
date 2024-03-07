import 'package:duit_kernel/duit_kernel.dart';

import 'jsono.dart';

class JsonUtils {
  ///Modifies the original [layout] object by adding values from the [data]
  ///object to it if there are [ValueReference] objects in the attributes
  static Map<String, dynamic> fillComponentProperties(
    JSONObject layout,
    JSONObject dataSource,
  ) {
    if (dataSource.values.isEmpty) return layout;

    void replaceId(JSONObject map) {
      if (map["controlled"] == true) {
        final type = map["type"];
        final timestamp = DateTime.now().microsecondsSinceEpoch;
        final id = "${type}_$timestamp";
        map["id"] = id;
      }
    }

    final src = Map<String, dynamic>.from(layout);
    final attributes = src["attributes"] as JSONObject?;
    final refs = List.from(attributes?["refs"] ?? []);

    //generate unique id for controlled widgets to prevent duplicates of ids in controllers registry
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
