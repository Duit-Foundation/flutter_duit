import "dart:async";

import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/animations/index.dart";
import "package:flutter_duit/src/animations/tween.dart";
import "package:flutter_duit/src/attributes/index.dart";

class DuitAnimationBuilder extends StatefulWidget {
  final Widget child;
  final UIElementController<AnimatedBuilderAttributes> controller;

  const DuitAnimationBuilder({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<DuitAnimationBuilder> createState() => _DuitAnimationBuilderState();
}

class _DuitAnimationBuilderState extends State<DuitAnimationBuilder>
    with TickerProviderStateMixin {
  final _controllers = <String, AnimationController>{};
  final _animations = <String, Animation>{};

  @override
  void initState() {
    widget.controller.listenCommand(_handleCommand);
    final attrs = widget.controller.attributes.payload;
    for (var animation in attrs.tweenDescriptions) {
      final controller = AnimationController(
        vsync: this,
        duration: animation.duration,
      );

      final tween = switch (animation.runtimeType) {
        ColorTweenDescription => ColorTween(
            begin: animation.begin,
            end: animation.end,
          ).animate(
            CurvedAnimation(
              parent: controller,
              curve: animation.curve,
            ),
          ),
        TweenDescription => Tween(
            begin: animation.begin,
            end: animation.end,
          ).animate(
            CurvedAnimation(
              parent: controller,
              curve: animation.curve,
            ),
          ),
        TextStyleTweenDescription => TextStyleTween(
            begin: animation.begin,
            end: animation.end,
          ).animate(
            CurvedAnimation(
              parent: controller,
              curve: animation.curve,
            ),
          ),
        DecorationTweenDescription => DecorationTween(
            begin: animation.begin,
            end: animation.end,
          ).animate(
            CurvedAnimation(
              parent: controller,
              curve: animation.curve,
            ),
          ),
        AlignmentTweenDescription => AlignmentTween(
            begin: animation.begin,
            end: animation.end,
          ).animate(
            CurvedAnimation(
              parent: controller,
              curve: animation.curve,
            ),
          ),
        EdgeInsetsTweenDescription => EdgeInsetsTween(
            begin: animation.begin,
            end: animation.end,
          ).animate(
            CurvedAnimation(
              parent: controller,
              curve: animation.curve,
            ),
          ),
        BoxConstraintsTweenDescription => BoxConstraintsTween(
            begin: animation.begin,
            end: animation.end,
          ).animate(
            CurvedAnimation(
              parent: controller,
              curve: animation.curve,
            ),
          ),
        SizeTweenDescription => SizeTween(
            begin: animation.begin,
            end: animation.end,
          ).animate(
            CurvedAnimation(
              parent: controller,
              curve: animation.curve,
            ),
          ),
        BorderTweenDescription => BorderTween(
            begin: animation.begin,
            end: animation.end,
          ).animate(
            CurvedAnimation(
              parent: controller,
              curve: animation.curve,
            ),
          ),
        Type() => throw UnimplementedError(),
      };

      _animations[animation.animatedPropKey] = tween;
      _controllers[animation.animatedPropKey] = controller;

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
            if (controller.isCompleted) {
              controller.reverse();
            } else {
              controller.forward();
            }
            break;
        }
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    _controllers.forEach((_, controller) {
      controller.dispose();
    });
    widget.controller.removeCommandListener();
    super.dispose();
  }

  Future<void> _handleCommand(AnimationCommand command) async {
    final controller = _controllers[command.animatedPropKey];

    if (controller != null) {
      switch (command.method) {
        case AnimationMethod.forward:
          controller.forward();
          break;
        case AnimationMethod.repeat:
          controller.repeat();
          break;
        case AnimationMethod.reverse:
          controller.reverse();
          break;
        case AnimationMethod.toggle:
          if (controller.isAnimating || controller.isCompleted) {
            controller.reverse();
          } else {
            controller.forward();
          }
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(
        _animations.values.toList(),
      ),
      builder: (context, child) {
        final dataObj = <String, dynamic>{};

        _animations.forEach((key, animation) {
          dataObj[key] = animation.value;
        });

        final wC = widget.controller;

        return DuitAnimationContext(
          data: dataObj,
          parentId: wC.attributes.payload.persistentId ?? wC.id,
          //Priority use of persistentId
          child: child ?? const SizedBox.shrink(),
        );
      },
      child: widget.child,
    );
  }
}
