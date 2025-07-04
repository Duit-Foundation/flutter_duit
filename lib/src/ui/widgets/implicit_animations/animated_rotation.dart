import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/animations/index.dart';

class DuitAnimatedRotation extends StatefulWidget {
  final UIElementController controller;
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
    with ViewControllerChangeListener, OnAnimationEnd {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      key: Key(widget.controller.id),
      duration: attributes.duration(),
      alignment: attributes.alignment(defaultValue: Alignment.center)!,
      filterQuality: attributes.filterQuality(),
      turns: attributes.getDouble(key: "turns"),
      curve: attributes.curve(defaultValue: Curves.linear)!,
      onEnd: onEndHandler(
        attributes.getAction("onEnd"),
        widget.controller.performAction,
      ),
      child: widget.child,
    );
  }
}
