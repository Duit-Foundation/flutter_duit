import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_duit/src/utils/index.dart';

import 'index.dart';
import 'tween.dart';

base class DuitTweenDescription<T> {
  final String animatedPropKey;
  final Duration duration;
  final T begin, end;
  final Curve curve;
  final AnimationTrigger trigger;
  final AnimationMethod method;
  final bool reverseOnRepeat;
  final ServerAction? onAnimationEnd;

  DuitTweenDescription({
    required this.animatedPropKey,
    required this.duration,
    required this.begin,
    required this.end,
    this.trigger = AnimationTrigger.onEnter,
    this.curve = Curves.linear,
    this.method = AnimationMethod.forward,
    this.reverseOnRepeat = false,
    this.onAnimationEnd,
  });

  static AnimationMethod _methodFromValue(dynamic value) {
    return switch (value) {
      0 => AnimationMethod.forward,
      1 => AnimationMethod.repeat,
      2 => AnimationMethod.reverse,
      3 => AnimationMethod.toggle,
      Object() || null => AnimationMethod.forward,
    };
  }

  static AnimationTrigger _triggerFromValue(dynamic value) {
    return switch (value) {
      0 => AnimationTrigger.onEnter,
      1 => AnimationTrigger.onAction,
      Object() || null => AnimationTrigger.onEnter,
    };
  }

  static DuitTweenDescription fromJson<T>(JSONObject json) {
    final type = json["type"] as String;
    return switch (type) {
      "colorTween" => ColorTweenDescription(
          animatedPropKey: json["animatedPropKey"],
          duration: ParamsMapper.convertToDuration(json["duration"]),
          begin: ColorUtils.tryParseColor(json["begin"]),
          end: ColorUtils.tryParseColor(json["end"]),
          curve: ParamsMapper.convertToCurve(json["curve"]),
          trigger: _triggerFromValue(json["trigger"]),
          method: _methodFromValue(json["method"]),
          reverseOnRepeat: json["reverseOnRepeat"] ?? false,
        ) as DuitTweenDescription,
      "tween" => TweenDescription(
          animatedPropKey: json["animatedPropKey"],
          duration: ParamsMapper.convertToDuration(json["duration"]),
          begin: NumUtils.toDoubleWithNullReplacement(json["begin"], 0.0),
          end: NumUtils.toDoubleWithNullReplacement(json["end"], 0.0),
          curve: ParamsMapper.convertToCurve(json["curve"]),
          trigger: _triggerFromValue(json["trigger"]),
          method: _methodFromValue(json["method"]),
          reverseOnRepeat: json["reverseOnRepeat"] ?? false,
        ) as DuitTweenDescription,
      "textStyleTween" => TextStyleTweenDescription(
          animatedPropKey: json["animatedPropKey"],
          duration: ParamsMapper.convertToDuration(json["duration"]),
          begin: ParamsMapper.convertToTextStyle(json["begin"])!,
          end: ParamsMapper.convertToTextStyle(json["end"])!,
          curve: ParamsMapper.convertToCurve(json["curve"]),
          trigger: _triggerFromValue(json["trigger"]),
          method: _methodFromValue(json["method"]),
          reverseOnRepeat: json["reverseOnRepeat"] ?? false,
        ) as DuitTweenDescription,
      "decorationTween" => DecorationTweenDescription(
          animatedPropKey: json["animatedPropKey"],
          duration: ParamsMapper.convertToDuration(json["duration"]),
          begin: ParamsMapper.convertToDecoration(json["begin"])!,
          end: ParamsMapper.convertToDecoration(json["end"])!,
          curve: ParamsMapper.convertToCurve(json["curve"]),
          trigger: _triggerFromValue(json["trigger"]),
          method: _methodFromValue(json["method"]),
          reverseOnRepeat: json["reverseOnRepeat"] ?? false,
        ) as DuitTweenDescription,
      String() => throw UnimplementedError(),
    };
  }
}
