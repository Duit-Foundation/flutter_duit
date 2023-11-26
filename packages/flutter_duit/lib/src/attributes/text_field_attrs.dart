import 'package:flutter/material.dart';
import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/ui/models/attended_model.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class TextFieldAttributes extends AttendedModel<String>
    implements DUITAttributes<TextFieldAttributes> {
  InputDecoration? decoration;
  TextStyle? style;
  TextInputType? keyboardType;
  TextAlign? textAlign;
  TextAlignVertical? textAlignVertical;
  TextDirection? textDirection;
  String? obscuringCharacter;
  bool? obscureText,
      autocorrect,
      enableSuggestions,
      expands,
      readOnly,
      showCursor,
      enabled,
      autofocus;
  int? maxLines, minLines, maxLength;

  TextFieldAttributes({
    this.decoration,
    this.style,
    this.keyboardType,
    this.textAlign,
    this.textAlignVertical,
    this.textDirection,
    this.obscuringCharacter,
    this.obscureText,
    this.autofocus,
    this.maxLines,
    this.autocorrect,
    this.enabled,
    this.enableSuggestions,
    this.expands,
    this.maxLength,
    this.minLines,
    this.readOnly,
    this.showCursor,
  }) : super(value: "");

  factory TextFieldAttributes.fromJson(JSONObject json) {
    return TextFieldAttributes(
      decoration: ParamsMapper.convertToInputDecoration(json['decoration']),
      style: ParamsMapper.convertToTextStyle(json['style']),
      keyboardType: ParamsMapper.convertToTextInputType(json["keyboardType"]),
      textAlign: ParamsMapper.convertToTextAlign(json['textAlign']),
      textDirection: ParamsMapper.convertToTextDirection(json['textDirection']),
      obscuringCharacter: json['obscuringCharacter'],
      obscureText: json['obscureText'],
      autocorrect: json['autocorrect'],
      enableSuggestions: json['enableSuggestions'],
      expands: json['expands'],
      readOnly: json['readOnly'],
      showCursor: json['showCursor'],
      enabled: json['enabled'],
      autofocus: json['autofocus'],
      maxLines: json['maxLines'],
      minLines: json['minLines'],
      maxLength: json['maxLength'],
    );
  }

  @override
  TextFieldAttributes copyWith(other) {
    return TextFieldAttributes(
      decoration: other.decoration ?? decoration,
      style: other.style ?? style,
      keyboardType: other.keyboardType ?? keyboardType,
      textAlign: other.textAlign ?? textAlign,
      textAlignVertical: other.textAlignVertical ?? textAlignVertical,
      textDirection: other.textDirection ?? textDirection,
      obscuringCharacter: other.obscuringCharacter ?? obscuringCharacter,
      obscureText: other.obscureText ?? obscureText,
      autocorrect: other.autocorrect ?? autocorrect,
      enableSuggestions: other.enableSuggestions ?? enableSuggestions,
      expands: other.expands ?? expands,
      readOnly: other.readOnly ?? readOnly,
      showCursor: other.showCursor ?? showCursor,
      enabled: other.enabled ?? enabled,
      autofocus: other.autofocus ?? autofocus,
      maxLines: other.maxLines ?? maxLines,
      minLines: other.minLines ?? minLines,
      maxLength: other.maxLength ?? maxLength,
    );
  }
}
