import 'package:flutter/painting.dart';

import 'index.dart';

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
