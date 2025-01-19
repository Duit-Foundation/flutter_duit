import 'package:flutter/material.dart';
import 'index.dart';

final class TweenDescriptionGroup extends DuitTweenDescription<void> {
  final Iterable<DuitTweenDescription> tweens;
  final String groupId;

  const TweenDescriptionGroup({
    required super.duration,
    required this.groupId,
    required this.tweens,
    super.method,
    super.reverseOnRepeat,
    super.trigger,
  }) : super(
          animatedPropKey: "",
          end: null,
          begin: null,
        );
}

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
    super.interval,
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
    super.interval,
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
    super.interval,
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
    super.interval,
  });
}

final class AlignmentTweenDescription
    extends DuitTweenDescription<AlignmentGeometry> {
  AlignmentTweenDescription({
    required super.animatedPropKey,
    required super.duration,
    required super.begin,
    required super.end,
    super.curve,
    super.trigger,
    super.method,
    super.reverseOnRepeat,
    super.interval,
  });
}

final class EdgeInsetsTweenDescription
    extends DuitTweenDescription<EdgeInsetsGeometry> {
  EdgeInsetsTweenDescription({
    required super.animatedPropKey,
    required super.duration,
    required super.begin,
    required super.end,
    super.curve,
    super.trigger,
    super.method,
    super.reverseOnRepeat,
    super.interval,
  });
}

final class BoxConstraintsTweenDescription
    extends DuitTweenDescription<BoxConstraints> {
  BoxConstraintsTweenDescription({
    required super.animatedPropKey,
    required super.duration,
    required super.begin,
    required super.end,
    super.curve,
    super.trigger,
    super.method,
    super.reverseOnRepeat,
    super.interval,
  });
}

final class SizeTweenDescription extends DuitTweenDescription<Size> {
  SizeTweenDescription({
    required super.animatedPropKey,
    required super.duration,
    required super.begin,
    required super.end,
    super.curve,
    super.trigger,
    super.method,
    super.reverseOnRepeat,
    super.interval,
  });
}

final class BorderTweenDescription extends DuitTweenDescription<Border> {
  BorderTweenDescription({
    required super.animatedPropKey,
    required super.duration,
    required super.begin,
    required super.end,
    super.curve,
    super.trigger,
    super.method,
    super.reverseOnRepeat,
    super.interval,
  });
}
