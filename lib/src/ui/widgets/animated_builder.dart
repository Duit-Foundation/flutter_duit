import "dart:async";

import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/animations/index.dart";
import "package:flutter_duit/src/controller/index.dart";

class DuitAnimatedBuilder extends StatefulWidget {
  final Widget child;
  final UIElementController controller;

  const DuitAnimatedBuilder({
    required this.child,
    required this.controller,
    super.key,
  });

  @override
  State<DuitAnimatedBuilder> createState() => _DuitAnimatedBuilderState();
}

class _DuitAnimatedBuilderState extends State<DuitAnimatedBuilder>
    with TickerProviderStateMixin, TweenHelper {
  final _controllers = <String, AnimationController>{};
  final _animations = <String, Animation>{};

  @override
  void didChangeDependencies() {
    widget.controller.listenCommand(_handleCommand);
    final attrs = widget.controller.attributes.payload;
    for (var description in attrs.tweens()) {
      final controller = AnimationController(
        vsync: this,
        duration: description.duration,
      );

      //Handle group of tween descriptions
      if (description is TweenDescriptionGroup) {
        //Use groupId as key instead of animatedPropKey
        _controllers[description.groupId] = controller;

        for (var groupMember in description.tweens) {
          final tween = createTweenFrom(groupMember);

          final animation = animate(
            tween,
            controller,
            groupMember.interval,
            groupMember.curve,
          );

          _animations[groupMember.animatedPropKey] = animation;

          if (description.trigger.needsRunImmediently) {
            execAnimation(
              description.method,
              controller,
              description.reverseOnRepeat,
            );
          }
        }
      } else {
        //Handle single tween description
        final tween = createTweenFrom(description);

        _controllers[description.animatedPropKey] = controller;

        final animation = animate(
          tween,
          controller,
          description.interval,
          description.curve,
        );

        _animations[description.animatedPropKey] = animation;

        if (description.trigger.needsRunImmediently) {
          execAnimation(
            description.method,
            controller,
            description.reverseOnRepeat,
          );
        }
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

  Future<void> _handleCommand(RemoteCommand command) async {
    if (command is AnimationCommand) {
      final controller = _controllers[command.animatedPropKey];
      if (controller != null) {
        execAnimation(
          command.method,
          controller,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final wC = widget.controller;

    return AnimatedBuilder(
      animation: Listenable.merge(
        _controllers.values,
      ),
      builder: (context, child) {
        return DuitAnimationContext(
          streams: _animations,
          parentId: wC.attributes.payload.tryGetString("persistentId") ?? wC.id,
          //Priority use of persistentId
          child: child ?? const SizedBox.shrink(),
        );
      },
      child: widget.child,
    );
  }
}
