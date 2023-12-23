import 'package:flutter/material.dart';
import 'package:flutter_duit/src/duit_kernel/index.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// Represents the attributes for a DecoratedBox widget.
///
/// This class implements the [DuitAttributes] interface, allowing it to be used with DUIT widgets.
class DecoratedBoxAttributes implements DuitAttributes<DecoratedBoxAttributes> {
  final Decoration? decoration;

  DecoratedBoxAttributes({
    required this.decoration,
  });

  factory DecoratedBoxAttributes.fromJson(JSONObject json) {
    return DecoratedBoxAttributes(
      decoration: ParamsMapper.convertToDecoration(json["decoration"]),
    );
  }

  @override
  DecoratedBoxAttributes copyWith(other) {
    return DecoratedBoxAttributes(
      decoration: other.decoration ?? decoration,
    );
  }
}
