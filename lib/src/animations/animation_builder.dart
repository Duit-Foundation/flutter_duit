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
    with TickerProviderStateMixin, TweenHelper {
  final _controllers = <String, AnimationController>{};
  final _animations = <String, Animation>{};

  @override
  void didChangeDependencies() {
    widget.controller.listenCommand(_handleCommand);
    final attrs = widget.controller.attributes.payload;
    for (var description in attrs.tweenDescriptions) {
      final controller = AnimationController(
        vsync: this,
        duration: description.duration,
      );

      //Handle group of tween descriptions
      if (description is TweenDescriptionGroup) {
        //Use groupId as key instead of animatedPropKey
        _controllers[description.groupId] = controller;

        for (var groupMember in description.tweens) {
          final tween = createTween(groupMember);

          final animation = animate(
            tween,
            controller,
            groupMember.interval,
            groupMember.curve,
          );

          _animations[groupMember.animatedPropKey] = animation;

          launch(
            description,
            controller,
          );
        }
      } else {
        //Handle single tween description
        final tween = createTween(description);

        _controllers[description.animatedPropKey] = controller;

        final animation = animate(
          tween,
          controller,
          description.interval,
          description.curve,
        );

        _animations[description.animatedPropKey] = animation;

        launch(
          description,
          controller,
        );
      }
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.forEach(
      (_, c) => c.dispose(),
    );
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
          handleToggleMethod(controller);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final wC = widget.controller;

    return AnimatedBuilder(
      animation: Listenable.merge(
        _animations.values,
      ),
      builder: (context, child) {
        final dataObj = <String, dynamic>{};

        _animations.forEach(
          (key, animation) {
            dataObj[key] = animation.value;
          },
        );

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
