import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/animations/index.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class AnimatedScaleAttributes extends ImplicitAnimatable
    implements DuitAttributes<AnimatedScaleAttributes> {
  final double scale;
  final Alignment alignment;
  final FilterQuality? filterQuality;

  const AnimatedScaleAttributes({
    required super.duration,
    required this.scale,
    required this.alignment,
    this.filterQuality,
    super.curve,
    super.onEnd,
  });

  factory AnimatedScaleAttributes.fromJson(Map<String, dynamic> json) {
    final action = ActionUtils(json);
    return AnimatedScaleAttributes(
      scale: NumUtils.toDoubleWithNullReplacement(json["scale"], 1.0),
      alignment: AttributeValueMapper.toAlignment(json["alignment"]),
      duration: AttributeValueMapper.toDuration(json["duration"]),
      curve: AttributeValueMapper.toCurve(json["curve"]),
      onEnd: action.parseAction("onEnd"),
      filterQuality:
          AttributeValueMapper.toFilterQuality(json["filterQuality"]),
    );
  }

  @override
  AnimatedScaleAttributes copyWith(AnimatedScaleAttributes other) {
    return AnimatedScaleAttributes(
      scale: other.scale,
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
