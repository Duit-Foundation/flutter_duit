import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/animations/index.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class AnimatedCrossFadeAttributes extends ImplicitAnimatable
    implements DuitAttributes<AnimatedCrossFadeAttributes> {
  final Duration? reverseDuration;
  final Curve firstCurve, secondCurve, sizeCurve;
  final bool excludeBottomFocus;

  /// Where 0 - [CrossFadeState.first], 1 - [CrossFadeState.second]
  final int crossFadeState;
  final AlignmentGeometry alignment;

  const AnimatedCrossFadeAttributes({
    required super.duration,
    required this.reverseDuration,
    required this.firstCurve,
    required this.secondCurve,
    required this.sizeCurve,
    required this.excludeBottomFocus,
    required this.crossFadeState,
    required this.alignment,
  });

  factory AnimatedCrossFadeAttributes.fromJson(Map<String, dynamic> json) {
    return AnimatedCrossFadeAttributes(
      duration: AttributeValueMapper.toDuration(json['duration']),
      reverseDuration: json['reverseDuration'] != null
          ? AttributeValueMapper.toDuration(json['reverseDuration'])
          : null,
      firstCurve: AttributeValueMapper.toCurve(json['firstCurve']),
      secondCurve: AttributeValueMapper.toCurve(json['secondCurve']),
      sizeCurve: AttributeValueMapper.toCurve(json['sizeCurve']),
      excludeBottomFocus: json['excludeBottomFocus'] ?? true,
      crossFadeState: NumUtils.toInt(json['crossFadeState']) ?? 0,
      alignment: AttributeValueMapper.toAlignment(json['alignment']),
    );
  }

  @override
  AnimatedCrossFadeAttributes copyWith(AnimatedCrossFadeAttributes other) {
    return AnimatedCrossFadeAttributes(
      duration: other.duration,
      reverseDuration: other.reverseDuration ?? reverseDuration,
      firstCurve: other.firstCurve,
      secondCurve: other.secondCurve,
      sizeCurve: other.sizeCurve,
      excludeBottomFocus: other.excludeBottomFocus,
      crossFadeState: other.crossFadeState,
      alignment: other.alignment,
    );
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) =>
      throw UnimplementedError();
}
