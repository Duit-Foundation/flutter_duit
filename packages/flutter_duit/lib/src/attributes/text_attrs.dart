import 'package:flutter/material.dart';
import 'package:flutter_duit/src/utils/index.dart';

abstract interface class ITextAttributes {
  abstract String data;
  abstract TextAlign? textAlign;
  abstract TextDirection? textDirection;
  abstract bool? softWrap;
  abstract TextOverflow? overflow;
  abstract double? textScaleFactor;
  abstract int? maxLines;
  abstract String? semanticsLabel;
  abstract TextStyle? style;
}

final class TextAttributes implements ITextAttributes {
  @override
  String data;
  @override
  TextAlign? textAlign;
  @override
  TextDirection? textDirection;
  @override
  bool? softWrap;
  @override
  TextOverflow? overflow;
  @override
  double? textScaleFactor;
  @override
  int? maxLines;
  @override
  String? semanticsLabel;
  @override
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
      textAlign: json["textAlign"]?.toTextAlign(),
      textScaleFactor: json["textScaleFactor"],
      softWrap: json["softWrap"],
      maxLines: json["maxLines"],
      semanticsLabel: json["semanticsLabel"],
      style: json["style"]?.toTextStyle(),
      overflow: json["overflow"]?.toTextOverflow(),
      textDirection: json["textDirection"]?.toTextDirection(),
    );
  }
}
