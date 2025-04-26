import 'package:duit_kernel/duit_kernel.dart';
import "package:flutter/material.dart";
import 'package:flutter_duit/src/animations/index.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class AnimatedSizeAttributes extends ImplicitAnimatable
    implements DuitAttributes<AnimatedSizeAttributes> {
  final Duration reverseDuration;
  final Clip? clipBehavior;
  final AlignmentGeometry? alignment;

  AnimatedSizeAttributes({
    required super.duration,
    required this.reverseDuration,
    required this.clipBehavior,
    super.curve,
    required this.alignment,
    super.onEnd,
  });

  factory AnimatedSizeAttributes.fromJson(Map<String, dynamic> json) {
    assert(json['duration'] != null, "Duration cannot be null");
    return AnimatedSizeAttributes(
      reverseDuration: AttributeValueMapper.toDuration(json['reverseDuration']),
      clipBehavior: AttributeValueMapper.toClip(json['clipBehavior']),
      alignment: AttributeValueMapper.toAlignment(json['alignment']),
      duration: AttributeValueMapper.toDuration(json['duration']),
      curve: AttributeValueMapper.toCurve(json['curve']),
      onEnd: ActionUtils(json).parseAction('onEnd'),
    );
  }

  @override
  AnimatedSizeAttributes copyWith(AnimatedSizeAttributes other) {
    return AnimatedSizeAttributes(
      duration: duration,
      reverseDuration: other.reverseDuration,
      clipBehavior: other.clipBehavior,
      curve: other.curve,
      alignment: other.alignment,
      onEnd: other.onEnd ?? onEnd,
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
