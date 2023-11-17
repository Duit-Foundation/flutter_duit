import 'package:flutter/cupertino.dart';
import 'package:flutter_duit/src/utils/index.dart';

import 'index.dart';

final class RowAttributes implements DUITAttributes<RowAttributes> {
  MainAxisAlignment? mainAxisAlignment;
  MainAxisSize? mainAxisSize;
  CrossAxisAlignment? crossAxisAlignment;
  TextDirection? textDirection;
  VerticalDirection? verticalDirection;
  Clip? clipBehavior;

  RowAttributes({
    this.mainAxisAlignment,
    this.mainAxisSize,
    this.textDirection,
    this.clipBehavior,
    this.crossAxisAlignment,
    this.verticalDirection,
  });

  factory RowAttributes.fromJson(JSONObject json) {
    return RowAttributes(
      mainAxisAlignment:
          ParamsMapper.convertToMainAxisAlignment(json["mainAxisAlignment"]),
      textDirection: ParamsMapper.convertToTextDirection(json["textDirection"]),
      crossAxisAlignment:
          ParamsMapper.convertToCrossAxisAlignment(json["crossAxisAlignment"]),
      clipBehavior: ParamsMapper.convertToClip(json["clipBehavior"]),
      mainAxisSize: ParamsMapper.convertToMainAxisSize(json["mainAxisSize"]),
      verticalDirection:
          ParamsMapper.convertToVerticalDirection(json["verticalDirection"]),
    );
  }

  @override
  RowAttributes copyWith(RowAttributes other) {
    return RowAttributes(
      mainAxisAlignment: other.mainAxisAlignment ?? mainAxisAlignment,
      mainAxisSize: other.mainAxisSize ?? mainAxisSize,
      crossAxisAlignment: other.crossAxisAlignment ?? crossAxisAlignment,
      textDirection: other.textDirection ?? textDirection,
      verticalDirection: other.verticalDirection ?? verticalDirection,
      clipBehavior: other.clipBehavior ?? clipBehavior,
    );
  }
}
