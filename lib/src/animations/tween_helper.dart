import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/animations/index.dart';

mixin TweenHelper<T extends StatefulWidget> on State<T> {
  TextDirection? _textDirection;

  void launch(
    DuitTweenDescription animation,
    AnimationController controller,
  ) {
    if (animation.trigger == AnimationTrigger.onEnter) {
      switch (animation.method) {
        case AnimationMethod.forward:
          controller.forward();
          break;
        case AnimationMethod.repeat:
          controller.repeat(
            reverse: animation.reverseOnRepeat,
          );
          break;
        case AnimationMethod.reverse:
          controller.reverse();
          break;
        case AnimationMethod.toggle:
          if (controller.isForwardOrCompleted) {
            controller.reverse();
          } else {
            controller.forward();
          }
          break;
      }
    }
  }

  Animation<Object?> animate(
    Tween tween,
    AnimationController controller,
    AnimationInterval? interval,
    Curve? curve,
  ) {
    if (interval != null) {
      return tween.animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(
            interval.begin,
            interval.end,
            curve: curve ?? Curves.linear,
          ),
        ),
      );
    } else {
      return tween.animate(
        CurvedAnimation(
          parent: controller,
          curve: curve ?? Curves.linear,
        ),
      );
    }
  }

  Tween createTween(
    DuitTweenDescription animation,
  ) {
    _textDirection ??= Directionality.of(context);

    return switch (animation) {
      ColorTweenDescription() => ColorTween(
          begin: animation.begin,
          end: animation.end,
        ),
      TweenDescription() => Tween(
          begin: animation.begin,
          end: animation.end,
        ),
      TextStyleTweenDescription() => TextStyleTween(
          begin: animation.begin,
          end: animation.end,
        ),
      DecorationTweenDescription() => DecorationTween(
          begin: animation.begin,
          end: animation.end,
        ),
      AlignmentTweenDescription() => AlignmentTween(
          begin: animation.begin.resolve(_textDirection),
          end: animation.end.resolve(_textDirection),
        ),
      EdgeInsetsTweenDescription() => EdgeInsetsTween(
          begin: animation.begin.resolve(_textDirection),
          end: animation.end.resolve(_textDirection),
        ),
      BoxConstraintsTweenDescription() => BoxConstraintsTween(
          begin: animation.begin,
          end: animation.end,
        ),
      SizeTweenDescription() => SizeTween(
          begin: animation.begin,
          end: animation.end,
        ),
      BorderTweenDescription() => BorderTween(
          begin: animation.begin,
          end: animation.end,
        ),
      Object() => throw UnimplementedError(
          "Tween of type ${animation.runtimeType} is not implemented"),
    };
  }
}
