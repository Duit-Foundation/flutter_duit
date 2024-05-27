import 'package:flutter/animation.dart';
import 'package:flutter_duit/src/utils/index.dart';

import 'index.dart';
import 'tweens.dart';

base class DuitTweenDescription<T> {
  final String animatedPropKey;
  final Duration duration;
  final T begin, end;
  final Curve curve;
  final AnimationTrigger trigger;
  final AnimationMethod method;
  final bool reverseOnRepeat;

  DuitTweenDescription({
    required this.animatedPropKey,
    required this.duration,
    required this.begin,
    required this.end,
    this.trigger = AnimationTrigger.onEnter,
    this.curve = Curves.linear,
    this.method = AnimationMethod.forward,
    this.reverseOnRepeat = false,
  });

  static DuitTweenDescription fromJson<T>(JSONObject json) {
    final type = json["type"] as String;
    return switch (type) {
      "colorTween" => ColorTweenDescription(
          animatedPropKey: json["animatedPropKey"],
          duration: ParamsMapper.convertToDuration(json["duration"]),
          begin: ColorUtils.tryParseColor(json["begin"]),
          end: ColorUtils.tryParseColor(json["end"]),
          curve: ParamsMapper.convertToCurve(json["curve"]),
          trigger: json["trigger"],
          method: json["method"],
          reverseOnRepeat: json["reverseOnRepeat"] ?? false,
        ) as DuitTweenDescription,
      "tween" => TweenDescription(
          animatedPropKey: json["animatedPropKey"],
          duration: ParamsMapper.convertToDuration(json["duration"]),
          begin: NumUtils.toDoubleWithNullReplacement(json["begin"], 0.0),
          end: NumUtils.toDoubleWithNullReplacement(json["end"], 0.0),
          curve: ParamsMapper.convertToCurve(json["curve"]),
          trigger: switch (json["trigger"]) {
            0 => AnimationTrigger.onEnter,
            1 => AnimationTrigger.onAction,
            Object() || null => AnimationTrigger.onEnter,
          },
          method: switch (json["method"]) {
            0 => AnimationMethod.forward,
            1 => AnimationMethod.repeat,
            2 => AnimationMethod.reverse,
            3 => AnimationMethod.toggle,
            Object() || null => AnimationMethod.forward,
          },
          reverseOnRepeat: json["reverseOnRepeat"] ?? false,
        ) as DuitTweenDescription,
      String() => throw UnimplementedError(),
    };
  }
}
