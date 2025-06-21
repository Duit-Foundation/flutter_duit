import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/animations/index.dart';
import 'package:flutter_duit/src/attributes/index.dart';

class DuitAnimatedPhysicalModel extends StatefulWidget {
  final UIElementController<AnimatedPhysicalModelAttributes> controller;
  final Widget child;

  const DuitAnimatedPhysicalModel({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitAnimatedPhysicalModel> createState() =>
      _DuitAnimatedPhysicalModelState();
}

class _DuitAnimatedPhysicalModelState extends State<DuitAnimatedPhysicalModel>
    with
        ViewControllerChangeListener<DuitAnimatedPhysicalModel,
            AnimatedPhysicalModelAttributes>,
        OnAnimationEnd {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPhysicalModel(
      key: ValueKey(widget.controller.id),
      elevation: attributes.elevation,
      color: attributes.color,
      shadowColor: attributes.shadowColor,
      animateColor: attributes.animateColor,
      animateShadowColor: attributes.animateShadowColor,
      clipBehavior: attributes.clipBehavior,
      borderRadius: attributes.borderRadius,
      shape: attributes.shape,
      duration: attributes.duration,
      curve: attributes.curve,
      onEnd: onEndHandler(
        attributes.onEnd,
        widget.controller.performAction,
      ),
      child: widget.child,
    );
  }
}
