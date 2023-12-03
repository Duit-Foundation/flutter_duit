import 'package:flutter/material.dart';
import 'package:flutter_duit/src/utils/index.dart';

import 'index.dart';

final class PaddingAttributes implements DUITAttributes<PaddingAttributes> {
  EdgeInsetsGeometry? padding;

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
