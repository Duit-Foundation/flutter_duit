import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/animations/index.dart';

class DuitAnimatedPhysicalModel extends StatefulWidget {
  final UIElementController controller;
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
    with ViewControllerChangeListener, OnAnimationEnd {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPhysicalModel(
      key: ValueKey(widget.controller.id),
      elevation: attributes.getDouble(key: "elevation"),
      color: attributes.parseColor(),
      shadowColor: attributes.parseColor(key: "shadowColor"),
      animateColor: attributes.getBool(
        "animateColor",
        defaultValue: true,
      ),
      animateShadowColor: attributes.getBool(
        "animateShadowColor",
        defaultValue: true,
      ),
      clipBehavior: attributes.clipBehavior(defaultValue: Clip.none)!,
      borderRadius: attributes.borderRadius(),
      shape: attributes.boxShape(defaultValue: BoxShape.rectangle)!,
      duration: attributes.duration(),
      curve: attributes.curve(defaultValue: Curves.linear)!,
      onEnd: onEndHandler(
        attributes.getAction("onEnd"),
        widget.controller.performAction,
      ),
      child: widget.child,
    );
  }
}
