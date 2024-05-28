import 'package:flutter/material.dart';
import 'index.dart';

/// [Tween] description
final class TweenDescription extends DuitTweenDescription<double> {
  TweenDescription({
    required super.animatedPropKey,
    required super.duration,
    required super.begin,
    required super.end,
    super.curve,
    super.trigger,
    super.method,
    super.reverseOnRepeat,
  });
}

/// [ColorTween] description
final class ColorTweenDescription extends DuitTweenDescription<Color> {
  ColorTweenDescription({
    required super.animatedPropKey,
    required super.duration,
    required super.begin,
    required super.end,
    super.curve,
    super.trigger,
    super.method,
    super.reverseOnRepeat,
  });
}

/// [TextStyleTween] description
final class TextStyleTweenDescription extends DuitTweenDescription<TextStyle> {
  TextStyleTweenDescription({
    required super.animatedPropKey,
    required super.duration,
    required super.begin,
    required super.end,
    super.curve,
    super.trigger,
    super.method,
    super.reverseOnRepeat,
  });
}

/// [DecorationTween] description
final class DecorationTweenDescription
    extends DuitTweenDescription<Decoration> {
  DecorationTweenDescription({
    required super.animatedPropKey,
    required super.duration,
    required super.begin,
    required super.end,
    super.curve,
    super.trigger,
    super.method,
    super.reverseOnRepeat,
  });
}
