import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/ui/models/attended_model.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// Represents the attributes for a TextField widget.
///
/// This class implements the [DuitAttributes] interface, allowing it to be used with DUIT widgets.
final class TextFieldAttributes extends AttendedModel<String>
    implements DuitAttributes<TextFieldAttributes> {
  final InputDecoration? decoration;
  final TextStyle? style;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final String? obscuringCharacter;
  final bool? obscureText,
      autocorrect,
      enableSuggestions,
      expands,
      readOnly,
      showCursor,
      enabled,
      autofocus;
  final int? maxLines, minLines, maxLength;

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
      decoration: AttributeValueMapper.toInputDecoration(json['decoration']),
      style: AttributeValueMapper.toTextStyle(json['style']),
      keyboardType: AttributeValueMapper.toTextInputType(json["keyboardType"]),
      textAlign: AttributeValueMapper.toTextAlign(json['textAlign']),
      textDirection: AttributeValueMapper.toTextDirection(json['textDirection']),
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

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) {
    return switch (methodName) {
      "fromJson" =>
        TextFieldAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
