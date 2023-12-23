import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// Represents the attributes for a Text widget.
///
/// This class implements the [DuitAttributes] interface, allowing it to be used with DUIT widgets.
final class TextAttributes implements DuitAttributes<TextAttributes> {
  final String? data;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;
  final String? semanticsLabel;
  final TextStyle? style;

  TextAttributes({
    required this.data,
    this.textAlign,
    this.textDirection,
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
      maxLines: other.maxLines ?? maxLines,
      semanticsLabel: other.semanticsLabel ?? semanticsLabel,
      style: other.style ?? style,
    );
  }
}
