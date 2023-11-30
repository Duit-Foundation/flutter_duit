import 'package:flutter/material.dart';
import 'package:flutter_duit/src/utils/index.dart';

import 'index.dart';

final class TextAttributes implements DUITAttributes<TextAttributes> {
  String? data;
  TextAlign? textAlign;
  TextDirection? textDirection;
  bool? softWrap;
  TextOverflow? overflow;
  double? textScaleFactor;
  int? maxLines;
  String? semanticsLabel;
  TextStyle? style;

  TextAttributes({
    required this.data,
    this.textAlign,
    this.textDirection,
    this.textScaleFactor,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.style,
  });

  static TextAttributes? fromJson(JSONObject json) {
    return TextAttributes(
      data: json["data"] ?? "",
      textAlign: ParamsMapper.convertToTextAlign(json["textAlign"]),
      textScaleFactor: json["textScaleFactor"],
      softWrap: json["softWrap"],
      maxLines: json["maxLines"],
      semanticsLabel: json["semanticsLabel"],
      style: ParamsMapper.convertToTextStyle(json["style"]),
      overflow: ParamsMapper.convertToTextOverflow(json["overflow"]),
      textDirection: ParamsMapper.convertToTextDirection(json["textDirection"]),
    );
  }

  @override
  TextAttributes copyWith(TextAttributes other) {
    return TextAttributes(
      data: other.data ?? data,
      textAlign: other.textAlign ?? textAlign,
      textDirection: other.textDirection ?? textDirection,
      softWrap: other.softWrap ?? softWrap,
      overflow: other.overflow ?? overflow,
      textScaleFactor: other.textScaleFactor ?? textScaleFactor,
      maxLines: other.maxLines ?? maxLines,
      semanticsLabel: other.semanticsLabel ?? semanticsLabel,
      style: other.style ?? style,
    );
  }
}
