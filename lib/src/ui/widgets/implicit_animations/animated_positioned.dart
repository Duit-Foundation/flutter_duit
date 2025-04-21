import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/animations/index.dart';
import 'package:flutter_duit/src/attributes/index.dart';

class DuitAnimatedPositioned extends StatefulWidget {
  final UIElementController<AnimatedPositionedAttributes> controller;
  final Widget child;

  const DuitAnimatedPositioned({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitAnimatedPositioned> createState() => _DuitAnimatedPositionedState();
}

class _DuitAnimatedPositionedState extends State<DuitAnimatedPositioned>
    with
        ViewControllerChangeListener<DuitAnimatedPositioned,
            AnimatedPositionedAttributes>,
        OnAnimationEnd {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      key: Key(widget.controller.id),
      top: attributes.top,
      right: attributes.right,
      bottom: attributes.bottom,
      left: attributes.left,
      duration: attributes.duration,
      curve: attributes.curve,
      child: widget.child,
    );
  }
}
