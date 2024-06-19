import 'package:duit_kernel/duit_kernel.dart';
import "package:flutter/material.dart";
import 'package:flutter_duit/src/utils/index.dart';

final class AnimatedSizeAttributes
    implements DuitAttributes<AnimatedSizeAttributes> {
  final Duration duration, reverseDuration;
  final Clip? clipBehavior;
  final Curve curve;
  final AlignmentGeometry? alignment;

  AnimatedSizeAttributes({
    required this.duration,
    required this.reverseDuration,
    required this.clipBehavior,
    required this.curve,
    required this.alignment,
  });

  factory AnimatedSizeAttributes.fromJson(Map<String, dynamic> json) {
    assert(json['duration'] != null, "Duration cannot be null");
    return AnimatedSizeAttributes(
      duration: AttributeValueMapper.toDuration(json['duration']),
      reverseDuration: AttributeValueMapper.toDuration(json['reverseDuration']),
      clipBehavior: AttributeValueMapper.toClip(json['clipBehavior']),
      curve: AttributeValueMapper.toCurve(json['curve']),
      alignment: AttributeValueMapper.toAlignment(json['alignment']),
    );
  }

  @override
  AnimatedSizeAttributes copyWith(AnimatedSizeAttributes other) {
    return AnimatedSizeAttributes(
      duration: other.duration,
      reverseDuration: other.reverseDuration,
      clipBehavior: other.clipBehavior,
      curve: other.curve,
      alignment: other.alignment,
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
        AnimatedSizeAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
