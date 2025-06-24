import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/animations/index.dart';

final class AnimatedSlideAttributes extends ImplicitAnimatable
    implements DuitAttributes<AnimatedSlideAttributes> {
  final Offset offset;

  const AnimatedSlideAttributes({
    required super.duration,
    required this.offset,
    super.curve,
    super.onEnd,
  });

  factory AnimatedSlideAttributes.fromJson(Map<String, dynamic> json) {
    final action = ActionUtils(json);
    return AnimatedSlideAttributes(
      offset: AttributeValueMapper.toOffset(json["offset"]),
      duration: AttributeValueMapper.toDuration(json["duration"]),
      curve: AttributeValueMapper.toCurve(json["curve"]),
      onEnd: action.parseAction("onEnd"),
    );
  }

  @override
  AnimatedSlideAttributes copyWith(AnimatedSlideAttributes other) {
    return AnimatedSlideAttributes(
      offset: other.offset,
      duration: other.duration,
      curve: other.curve,
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
