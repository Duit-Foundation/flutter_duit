import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/animations/index.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class AnimatedRotationAttributes extends ImplicitAnimatable
    implements DuitAttributes<AnimatedRotationAttributes> {
  final double turns;
  final Alignment alignment;
  final FilterQuality? filterQuality;

  const AnimatedRotationAttributes({
    required this.turns,
    required this.alignment,
    required super.duration,
    this.filterQuality,
    super.curve,
    super.onEnd,
  });

  factory AnimatedRotationAttributes.fromJson(Map<String, dynamic> json) {
    return AnimatedRotationAttributes(
      turns: NumUtils.toDoubleWithNullReplacement(json['turns'], 0.0),
      alignment: AttributeValueMapper.toAlignment(
        json['alignment'],
        Alignment.center,
      ),
      filterQuality:
          AttributeValueMapper.toFilterQuality(json['filterQuality']),
      duration: AttributeValueMapper.toDuration(json['duration']),
      curve: AttributeValueMapper.toCurve(json['curve']),
      onEnd: ActionUtils(json).parseAction('onEnd'),
    );
  }

  @override
  AnimatedRotationAttributes copyWith(AnimatedRotationAttributes other) {
    return AnimatedRotationAttributes(
      turns: other.turns,
      alignment: other.alignment,
      duration: other.duration,
      curve: other.curve,
      onEnd: other.onEnd ?? onEnd,
      filterQuality: other.filterQuality ?? filterQuality,
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
