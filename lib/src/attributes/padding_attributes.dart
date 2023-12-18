import 'package:flutter/material.dart';
import 'package:flutter_duit/src/utils/index.dart';

import 'index.dart';

/// Represents the attributes for a Padding widget.
///
/// This class implements the [DuitAttributes] interface, allowing it to be used with DUIT widgets.
final class PaddingAttributes implements DuitAttributes<PaddingAttributes> {
  final EdgeInsetsGeometry? padding;

  PaddingAttributes({
    this.padding,
  });

  @override
  PaddingAttributes copyWith(other) {
    return PaddingAttributes(
      padding: other.padding ?? padding,
    );
  }

  factory PaddingAttributes.fromJson(JSONObject json) {
    return PaddingAttributes(
      padding: ParamsMapper.convertToEdgeInsets(json["padding"]),
    );
  }
}
