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
    this.clipBehavior,
  });

  factory WrapAttributes.fromJson(Map<String, dynamic> json) {
    return WrapAttributes(
      direction: ParamsMapper.convertToAxis(json['direction']),
      textDirection: ParamsMapper.convertToTextDirection(json['textDirection']),
      verticalDirection:
          ParamsMapper.convertToVerticalDirection(json['verticalDirection']),
      alignment: ParamsMapper.convertToWrapAlignment(json['alignment']),
      runAlignment: ParamsMapper.convertToWrapAlignment(json['runAlignment']),
      spacing: NumUtils.toDoubleWithNullReplacement(json['spacing'], 0),
      runSpacing: NumUtils.toDoubleWithNullReplacement(json['runSpacing'], 0),
      crossAxisAlignment:
          ParamsMapper.convertToWrapCrossAlignment(json['crossAxisAlignment']),
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
      clipBehavior: other.clipBehavior ?? clipBehavior,
    );
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) {
    return switch (methodName) {
      "fromJson" => WrapAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
