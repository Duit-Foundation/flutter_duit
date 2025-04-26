import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/animations/index.dart';
import 'package:flutter_duit/src/attributes/index.dart';

class DuitAnimatedRotation extends StatefulWidget {
  final UIElementController<AnimatedRotationAttributes> controller;
  final Widget child;

  const DuitAnimatedRotation({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitAnimatedRotation> createState() => _DuitAnimatedRotationState();
}

class _DuitAnimatedRotationState extends State<DuitAnimatedRotation>
    with
        ViewControllerChangeListener<DuitAnimatedRotation,
            AnimatedRotationAttributes>,
        OnAnimationEnd {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      key: Key(widget.controller.id),
      duration: attributes.duration,
      alignment: attributes.alignment,
      filterQuality: attributes.filterQuality,
      turns: attributes.turns,
      curve: attributes.curve,
      onEnd: onEndHandler(
        attributes.onEnd,
        widget.controller.performAction,
      ),
      child: widget.child,
    );
  }
}
