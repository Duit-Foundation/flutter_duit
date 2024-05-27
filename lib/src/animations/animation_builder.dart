import "dart:async";

import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/animations/index.dart";
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
    final attrs = widget.controller.attributes!.payload;
    for (var description in attrs.tweenDescriptions) {
      final controller = AnimationController(
        vsync: this,
        duration: description.duration,
      );

      final animation = Tween(
        begin: description.begin,
        end: description.end,
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: description.curve,
        ),
      );

      _animations[description.animatedPropKey] = animation;
      _controllers[description.animatedPropKey] = controller;

      if (description.trigger == AnimationTrigger.onEnter) {
        switch (description.method) {
          case AnimationMethod.forward:
            controller.forward();
            break;
          case AnimationMethod.repeat:
            controller.repeat(
              reverse: description.reverseOnRepeat,
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

        return DuitAnimationContext(
          data: dataObj,
          parentId: widget.controller.id,
          child: child ?? const SizedBox.shrink(),
        );
      },
      child: widget.child,
    );
  }
}
