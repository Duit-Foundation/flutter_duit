import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/utils/index.dart';

class RichTextAttributes implements DuitAttributes<RichTextAttributes> {
  final InlineSpan? textSpan;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;
  final TextScaler? textScaler;

  const RichTextAttributes({
    this.textSpan,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
    this.textScaler,
  });

  @override
  RichTextAttributes copyWith(other) {
    return RichTextAttributes(
      textSpan: other.textSpan ?? textSpan,
      style: other.style ?? style,
      strutStyle: other.strutStyle ?? strutStyle,
      textAlign: other.textAlign ?? textAlign,
      textDirection: other.textDirection ?? textDirection,
      softWrap: other.softWrap ?? softWrap,
      overflow: other.overflow ?? overflow,
      maxLines: other.maxLines ?? maxLines,
      semanticsLabel: other.semanticsLabel ?? semanticsLabel,
      textWidthBasis: other.textWidthBasis ?? textWidthBasis,
      textHeightBehavior: other.textHeightBehavior ?? textHeightBehavior,
      selectionColor: other.selectionColor ?? selectionColor,
      textScaler: other.textScaler ?? textScaler,
    );
  }

  factory RichTextAttributes.fromJson(Map<String, dynamic> json) {
    return RichTextAttributes(
      textSpan: json['textSpan'] as InlineSpan,
      style: ParamsMapper.convertToTextStyle(json['style']),
      strutStyle: ParamsMapper.convertToStrutStyle(json['strutStyle']),
      textAlign: ParamsMapper.convertToTextAlign(json['textAlign']),
      textDirection: ParamsMapper.convertToTextDirection(json['textDirection']),
      softWrap: json['softWrap'],
      overflow: ParamsMapper.convertToTextOverflow(json['overflow']),
      maxLines: NumUtils.toInt(json['maxLines']),
      semanticsLabel: json['semanticsLabel'],
      textWidthBasis: ParamsMapper.convertToTextWidthBasis(
        json['textWidthBasis'],
      ),
      textHeightBehavior: ParamsMapper.convertToTextHeightBehavior(
        json['textHeightBehavior'],
      ),
      selectionColor: ColorUtils.tryParseColor(json['selectionColor']),
      textScaler: ParamsMapper.convertToTextScaler(json['textScaler']),
    );
  }
}
