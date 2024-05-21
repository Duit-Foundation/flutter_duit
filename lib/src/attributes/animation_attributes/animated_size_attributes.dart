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
      duration: ParamsMapper.convertToDuration(json['duration']),
      reverseDuration: ParamsMapper.convertToDuration(json['reverseDuration']),
      clipBehavior: ParamsMapper.convertToClip(json['clipBehavior']),
      curve: ParamsMapper.convertToCurve(json['curve']),
      alignment: ParamsMapper.convertToAlignment(json['alignment']),
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
}
