import 'dart:async';

import 'package:duit_kernel/duit_kernel.dart';

import 'jsono.dart';

class JsonUtils {
  ///Modifies the original [layout] object by adding values from the [data]
  ///object to it if there are [ValueReference] objects in the attributes
  static FutureOr<void> mergeComponentLayoutDescriptionWithExternalData(
    JSONObject layout,
    JSONObject data,
  ) async {
    final attributes = layout["attributes"] as JSONObject?;
    final refs = List.from(attributes?["refs"] ?? []);

    for (var ref in refs) {
      final payload = ValueReference.fromJson(ref);
      final value = data[payload.objectKey];

      if (value != null ) {
        attributes?[payload.attributeKey] = value;
      }
    }

    if (layout["child"] != null) {
      mergeComponentLayoutDescriptionWithExternalData(layout["child"], data);
    }

    if (layout["children"] != null) {
      final children = List.from(layout["children"]);
      for (var element in children) {
        mergeComponentLayoutDescriptionWithExternalData(element, data);
      }
    }
  }
}
