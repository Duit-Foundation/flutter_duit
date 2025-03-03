import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class RichTextAttributes extends AnimatedPropertyOwner
    implements DuitAttributes<RichTextAttributes> {
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
    required super.parentBuilderId,
    required super.affectedProperties,
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
      parentBuilderId: other.parentBuilderId,
      affectedProperties: other.affectedProperties,
    );
  }

  factory RichTextAttributes.fromJson(Map<String, dynamic> json) {
    return RichTextAttributes(
      textSpan: AttributeValueMapper.toTextSpan(json['textSpan']),
      style: AttributeValueMapper.toTextStyle(json['style']),
      strutStyle: AttributeValueMapper.toStrutStyle(json['strutStyle']),
      textAlign: AttributeValueMapper.toTextAlign(json['textAlign']),
      textDirection:
          AttributeValueMapper.toTextDirection(json['textDirection']),
      softWrap: json['softWrap'],
      overflow: AttributeValueMapper.toTextOverflow(json['overflow']),
      maxLines: NumUtils.toInt(json['maxLines']),
      semanticsLabel: json['semanticsLabel'],
      textWidthBasis: AttributeValueMapper.toTextWidthBasis(
        json['textWidthBasis'],
      ),
      textHeightBehavior: AttributeValueMapper.toTextHeightBehavior(
        json['textHeightBehavior'],
      ),
      selectionColor: ColorUtils.tryParseColor(json['selectionColor']),
      textScaler: AttributeValueMapper.toTextScaler(json['textScaler']),
      parentBuilderId: json['parentBuilderId'],
      affectedProperties: Set.from(
        json['affectedProperties'] ?? {},
      ),
    );
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) {
    return switch (methodName) {
      "fromJson" =>
        RichTextAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
