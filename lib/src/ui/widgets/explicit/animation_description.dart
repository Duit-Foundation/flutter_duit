import 'dart:ui';

import 'package:flutter_duit/src/utils/index.dart';

class AnimationDescription<T> {
  final String animatedPropKey;
  final Duration duration;
  final T begin, end;

  AnimationDescription({
    required this.animatedPropKey,
    required this.duration,
    required this.begin,
    required this.end,
  });

  static AnimationDescription fromJson<T>(JSONObject json) {
    final type = json["type"] as String;
    return switch (type) {
      "colorTween" => ColorTweenDescription(
          animatedPropKey: json["animatedPropKey"],
          duration: ParamsMapper.convertToDuration(json["duration"]),
          begin: ColorUtils.tryParseColor(json["begin"]),
          end: ColorUtils.tryParseColor(json["end"]),
        ) as AnimationDescription,
      "tween" => TweenDescription(
          animatedPropKey: json["animatedPropKey"],
          duration: ParamsMapper.convertToDuration(json["duration"]),
          begin: NumUtils.toDoubleWithNullReplacement(json["begin"], 0.0),
          end: NumUtils.toDoubleWithNullReplacement(json["end"], 0.0),
        ) as AnimationDescription,
      String() => throw UnimplementedError(),
    };
  }
}

final class TweenDescription extends AnimationDescription<double> {
  TweenDescription({
    required super.animatedPropKey,
    required super.duration,
    required super.begin,
    required super.end,
  });
}

final class ColorTweenDescription extends AnimationDescription<Color> {
  ColorTweenDescription({
    required super.animatedPropKey,
    required super.duration,
    required super.begin,
    required super.end,
  });
}
