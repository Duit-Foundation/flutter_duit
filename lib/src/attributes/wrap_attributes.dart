import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class WrapAttributes implements DuitAttributes<WrapAttributes> {
  final Axis? direction;
  final TextDirection? textDirection;
  final VerticalDirection? verticalDirection;
  final WrapAlignment? alignment, runAlignment;
  final double spacing, runSpacing;
  final WrapCrossAlignment? crossAxisAlignment;
  final TextBaseline? textBaseline;
  final Clip? clipBehavior;

  WrapAttributes({
    required this.spacing,
    required this.runSpacing,
    this.direction = Axis.horizontal,
    this.textDirection,
    this.verticalDirection,
    this.alignment = WrapAlignment.start,
    this.runAlignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.textBaseline,
    this.clipBehavior,
  });

  factory WrapAttributes.fromJson(Map<String, dynamic> json) {
    return WrapAttributes(
      direction: json['direction'] as Axis,
      textDirection: ParamsMapper.convertToTextDirection(json['textDirection']),
      verticalDirection:
          ParamsMapper.convertToVerticalDirection(json['verticalDirection']),
      alignment: json['alignment'] as WrapAlignment,
      runAlignment: json['runAlignment'] as WrapAlignment,
      spacing: NumUtils.toDoubleWithNullReplacement(json['spacing'], 0),
      runSpacing: NumUtils.toDoubleWithNullReplacement(json['runSpacing'], 0),
      crossAxisAlignment: json['crossAxisAlignment'] as WrapCrossAlignment,
      textBaseline: json['textBaseline'] as TextBaseline,
      clipBehavior: ParamsMapper.convertToClip(json['clipBehavior']),
    );
  }

  @override
  WrapAttributes copyWith(WrapAttributes other) {
    return WrapAttributes(
      direction: other.direction ?? direction,
      textDirection: other.textDirection ?? textDirection,
      verticalDirection: other.verticalDirection ?? verticalDirection,
      alignment: other.alignment ?? alignment,
      runAlignment: other.runAlignment,
      spacing: other.spacing,
      runSpacing: other.runSpacing,
      crossAxisAlignment: other.crossAxisAlignment ?? crossAxisAlignment,
      textBaseline: other.textBaseline ?? textBaseline,
      clipBehavior: other.clipBehavior ?? clipBehavior,
    );
  }
}
