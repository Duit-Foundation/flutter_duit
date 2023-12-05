import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/utils/index.dart';

class DecoratedBoxAttributes implements DUITAttributes<DecoratedBoxAttributes> {
  Decoration? decoration;

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
