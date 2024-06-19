import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/ui/models/attended_model.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class SwitchAttributes extends AttendedModel<bool>
    implements DuitAttributes<SwitchAttributes> {
  final Color? activeColor,
      focusColor,
      hoverColor,
      activeTrackColor,
      inactiveTrackColor;
  final MaterialStateProperty<Color>? overlayColor,
      trackColor,
      thumbColor,
      trackOutlineColor;
  final MaterialStateProperty<double>? trackOutlineWidth;
  final double? splashRadius;
  final MaterialTapTargetSize? materialTapTargetSize;
  final bool? autofocus;

  SwitchAttributes({
    required super.value,
    this.activeColor,
    this.focusColor,
    this.hoverColor,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.overlayColor,
    this.trackColor,
    this.thumbColor,
    this.trackOutlineColor,
    this.trackOutlineWidth,
    this.splashRadius,
    this.materialTapTargetSize,
    this.autofocus,
  });

  @override
  SwitchAttributes copyWith(SwitchAttributes other) {
    return SwitchAttributes(
      value: other.value,
      activeColor: other.activeColor ?? activeColor,
      focusColor: other.focusColor ?? focusColor,
      hoverColor: other.hoverColor ?? hoverColor,
      thumbColor: other.thumbColor ?? thumbColor,
      activeTrackColor: other.activeTrackColor ?? activeTrackColor,
      inactiveTrackColor: other.inactiveTrackColor ?? inactiveTrackColor,
      overlayColor: other.overlayColor ?? overlayColor,
      trackColor: other.trackColor ?? trackColor,
      trackOutlineColor: other.trackOutlineColor ?? trackOutlineColor,
      trackOutlineWidth: other.trackOutlineWidth ?? trackOutlineWidth,
      splashRadius: other.splashRadius ?? splashRadius,
      materialTapTargetSize:
          other.materialTapTargetSize ?? materialTapTargetSize,
      autofocus: other.autofocus ?? autofocus,
    );
  }

  factory SwitchAttributes.fromJson(Map<String, dynamic> json) {
    return SwitchAttributes(
      value: json["value"] ?? false,
      activeColor: ColorUtils.tryParseNullableColor(json['activeColor']),
      focusColor: ColorUtils.tryParseNullableColor(json['focusColor']),
      hoverColor: ColorUtils.tryParseNullableColor(json['hoverColor']),
      activeTrackColor:
          ColorUtils.tryParseNullableColor(json['activeTrackColor']),
      inactiveTrackColor:
          ColorUtils.tryParseNullableColor(json['inactiveTrackColor']),
      thumbColor: AttributeValueMapper.toMSPColor(json['thumbColor']),
      overlayColor: AttributeValueMapper.toMSPColor(json['overlayColor']),
      trackColor: AttributeValueMapper.toMSPColor(json['trackColor']),
      trackOutlineColor:
          AttributeValueMapper.toMSPColor(json['trackOutlineColor']),
      trackOutlineWidth:
          AttributeValueMapper.toMSPDouble(json['trackOutlineWidth']),
      splashRadius: NumUtils.toDouble(json['splashRadius']),
      materialTapTargetSize: AttributeValueMapper.toMaterialTapTargetSize(
          json['materialTapTargetSize']),
      autofocus: json['autofocus'],
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
        SwitchAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
