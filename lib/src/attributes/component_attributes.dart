import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter_duit/src/ui/models/ui_tree.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class ComponentAttributes implements DuitAttributes<ComponentAttributes> {
  final DuitTree? data;

  ComponentAttributes({
    this.data,
  });

  factory ComponentAttributes.fromJson(JSONObject json) {
    return ComponentAttributes(
      data: json["tree"],
    );
  }

  @override
  ComponentAttributes copyWith(other) {
    return ComponentAttributes(
      data: other.data ?? data,
    );
  }
}
