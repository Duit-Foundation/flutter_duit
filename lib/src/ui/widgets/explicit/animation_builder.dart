import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";

import "animation_context.dart";
import "animation_description.dart";

class DuitAnimationBuilder extends StatefulWidget {
  final List<AnimationDescription> descriptions;
  final Widget child;
  final UIElementController controller;

  const DuitAnimationBuilder({
    super.key,
    required this.descriptions,
    required this.child,
    required this.controller,
  });

  @override
  State<DuitAnimationBuilder> createState() => _DuitAnimationBuilderState();
}

class _DuitAnimationBuilderState extends State<DuitAnimationBuilder>
    with TickerProviderStateMixin {
  final Map<String, AnimationController> _controllers = {};
  final Map<String, Animation> _animations = {};

  @override
  void initState() {
    for (var description in widget.descriptions) {
      final controller = AnimationController(
        vsync: this,
        duration: description.duration,
      );

      final anim = Tween(begin: description.begin, end: description.end)
          .animate(controller);

      _animations[description.animatedPropKey] = anim;
      _controllers[description.animatedPropKey] = controller;
    }
    _controllers.forEach((_, value) {
      value.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controllers.forEach((_, value) {
      value.dispose();
    });
    super.dispose();
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
