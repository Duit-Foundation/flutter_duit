import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/ui/models/attended_model.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class RadioGroupContextAttributes extends AttendedModel<dynamic>
    implements DuitAttributes<RadioGroupContextAttributes> {
  final dynamic groupValue;

  RadioGroupContextAttributes({
    super.value,
    required this.groupValue,
  });

  factory RadioGroupContextAttributes.fromJson(Map<String, dynamic> json) {
    final groupValue = json['groupValue'];
    return RadioGroupContextAttributes(
      value: groupValue,
      groupValue: groupValue,
    );
  }

  @override
  RadioGroupContextAttributes copyWith(other) {
    return RadioGroupContextAttributes(
      groupValue: other.groupValue,
    );
  }
}

final class RadioAttributes implements DuitAttributes<RadioAttributes> {
  final dynamic value;
  final bool? toggleable, autofocus;
  final Color? activeColor, focusColor, hoverColor;
  final MaterialStateProperty<Color>? fillColor;
  final MaterialStateProperty<Color>? overlayColor;
  final double? splashRadius;
  final MaterialTapTargetSize? materialTapTargetSize;
  final VisualDensity? visualDensity;

  RadioAttributes({
    required this.value,
    required this.toggleable,
    required this.autofocus,
    required this.activeColor,
    required this.focusColor,
    required this.hoverColor,
    required this.fillColor,
    required this.overlayColor,
    required this.splashRadius,
    required this.materialTapTargetSize,
    required this.visualDensity,
  });

  factory RadioAttributes.fromJson(Map<String, dynamic> json) {
    final value = json['value'];
    assert(value != null, "value must not be null");
    assert(value is String || value is bool || value is double || value is int,
        "Value must be string, bool, double or int type");
    return RadioAttributes(
      value: value,
      toggleable: json['toggleable'],
      autofocus: json['autofocus'],
      activeColor: ColorUtils.tryParseNullableColor(json['activeColor']),
      focusColor: ColorUtils.tryParseNullableColor(json['focusColor']),
      hoverColor: ColorUtils.tryParseNullableColor(json['hoverColor']),
      fillColor: ParamsMapper.convertToMSPColor(json['fillColor']),
      overlayColor: ParamsMapper.convertToMSPColor(json['overlayColor']),
      splashRadius: NumUtils.toDouble(json['splashRadius']),
      materialTapTargetSize: ParamsMapper.convertToMaterialTapTargetSize(
          json['materialTapTargetSize']),
      visualDensity: ParamsMapper.convertToVisualDensity(json['visualDensity']),
    );
  }

  @override
  RadioAttributes copyWith(other) {
    return RadioAttributes(
      toggleable: other.toggleable ?? toggleable,
      autofocus: other.autofocus ?? autofocus,
      activeColor: other.activeColor ?? activeColor,
      focusColor: other.focusColor ?? focusColor,
      hoverColor: other.hoverColor ?? hoverColor,
      fillColor: other.fillColor ?? fillColor,
      overlayColor: other.overlayColor ?? overlayColor,
      splashRadius: other.splashRadius ?? splashRadius,
      materialTapTargetSize:
          other.materialTapTargetSize ?? materialTapTargetSize,
      visualDensity: other.visualDensity ?? visualDensity,
      value: other.value ?? value,
    );
  }
}
