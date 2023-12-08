import "package:flutter/material.dart";
import "package:flutter_duit/src/ui/models/attended_model.dart";
import "package:flutter_duit/src/utils/index.dart";

import "index.dart";

//TODO: need add shape [OutlinedBorder]

/// Represents the attributes for a checkbox widget.
///
/// This class implements the [DUITAttributes] interface, allowing it to be used with DUIT widgets.
class CheckboxAttributes extends AttendedModel<bool>
    implements DUITAttributes<CheckboxAttributes> {
  // OutlinedBorder? shape;
  final bool? autofocus;
  final bool? isError;
  final bool? tristate;
  final String? semanticLabel;
  final double? splashRadius;
  final BorderSide? side;
  final MaterialStateProperty<Color>? fillColor;
  final MaterialStateProperty<Color>? overlayColor;
  final Color? checkColor;
  final Color? splashColor;
  final Color? activeColor;
  final Color? focusColor;
  final Color? hoverColor;
  final VisualDensity visualDensity;

  CheckboxAttributes({
    required super.value,
    this.autofocus,
    this.checkColor,
    this.tristate,
    this.activeColor,
    this.fillColor,
    this.focusColor,
    this.overlayColor,
    this.splashColor,
    this.splashRadius,
    this.hoverColor,
    this.isError,
    this.semanticLabel,
    this.side,
    this.visualDensity = const VisualDensity(),
    // this.shape,
  });

  @override
  CheckboxAttributes copyWith(other) {
    return CheckboxAttributes(
      value: other.value,
      autofocus: other.autofocus ?? autofocus,
      isError: other.isError ?? isError,
      tristate: other.tristate ?? tristate,
      semanticLabel: other.semanticLabel ?? semanticLabel,
      splashRadius: other.splashRadius ?? splashRadius,
      side: other.side ?? side,
      checkColor: other.checkColor ?? checkColor,
      fillColor: other.fillColor ?? fillColor,
      splashColor: other.splashColor ?? splashColor,
      overlayColor: other.overlayColor ?? overlayColor,
      activeColor: other.activeColor ?? activeColor,
      focusColor: other.focusColor ?? focusColor,
      hoverColor: other.hoverColor ?? hoverColor,
      visualDensity: other.visualDensity,
      // shape: other.shape ?? shape,
    );
  }

  factory CheckboxAttributes.fromJson(Map<String, dynamic> json) {
    return CheckboxAttributes(
      value: json['value'] ?? false,
      autofocus: json['autofocus'] ?? false,
      isError: json['isError'] ?? false,
      tristate: json['tristate'] ?? false,
      semanticLabel: json['semanticLabel'],
      splashRadius: json['splashRadius'],
      // shape: json['shape'] as OutlinedBorder,
      hoverColor: ColorUtils.tryParseColor(json["hoverColor"]),
      side: ParamsMapper.convertToBorderSide(json["side"]),
      checkColor: ColorUtils.tryParseColor(json["checkColor"]),
      fillColor: ParamsMapper.convertToMSPColor(json["fillColor"]),
      splashColor: ColorUtils.tryParseColor(json["splashColor"]),
      overlayColor: ParamsMapper.convertToMSPColor(json["overlayColor"]),
      activeColor: ColorUtils.tryParseColor(json["activeColor"]),
      focusColor: ColorUtils.tryParseColor(json["focusColor"]),
      visualDensity: ParamsMapper.convertToVisualDensity(json["visualDensity"]),
    );
  }
}
