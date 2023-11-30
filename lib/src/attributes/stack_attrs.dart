import 'package:flutter/cupertino.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class StackAttributes implements DUITAttributes<StackAttributes> {
  AlignmentGeometry? alignment;
  TextDirection? textDirection;
  StackFit? fit;
  Clip? clipBehavior;

  StackAttributes({
    required this.alignment,
    this.textDirection,
    required this.fit,
    required this.clipBehavior,
  });

  factory StackAttributes.fromJson(JSONObject json) {
    return StackAttributes(
      alignment: ParamsMapper.convertToAlignmentDirectional(json["alignment"]),
      textDirection: ParamsMapper.convertToTextDirection(json["textDirection"]),
      fit: ParamsMapper.convertToStackFit(json["fit"]),
      clipBehavior: ParamsMapper.convertToClip(json["clipBehavior"]),
    );
  }

  @override
  StackAttributes copyWith(other) {
    return StackAttributes(
      alignment: other.alignment ?? alignment,
      textDirection: other.textDirection ?? textDirection,
      fit: other.fit ?? fit,
      clipBehavior: other.clipBehavior ?? clipBehavior,
    );
  }
}
