import 'package:flutter/material.dart';
import 'package:flutter_duit/src/attributes/attributes.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class ElevatedButtonAttributes
    implements DUITAttributes<ElevatedButtonAttributes> {
  bool? autofocus;
  Clip? clipBehavior;

  ElevatedButtonAttributes({
    this.autofocus,
    this.clipBehavior,
  });

  factory ElevatedButtonAttributes.fromJson(JSONObject json) {
    return ElevatedButtonAttributes(
      autofocus: json["autofocus"],
      clipBehavior: ParamsMapper.convertToClip(json["clipBehavior"]),
    );
  }

  @override
  ElevatedButtonAttributes copyWith(ElevatedButtonAttributes other) {
    return ElevatedButtonAttributes(
      autofocus: other.autofocus ?? autofocus,
      clipBehavior: other.clipBehavior ?? clipBehavior,
    );
  }
}
