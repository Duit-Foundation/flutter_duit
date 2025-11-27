import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/animations/index.dart";

class DuitAnimatedPositioned extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitAnimatedPositioned({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  State<DuitAnimatedPositioned> createState() => _DuitAnimatedPositionedState();
}

class _DuitAnimatedPositionedState extends State<DuitAnimatedPositioned>
    with ViewControllerChangeListener, OnAnimationEnd {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      key: Key(widget.controller.id),
      top: attributes.tryGetDouble(key: "top"),
      right: attributes.tryGetDouble(key: "right"),
      bottom: attributes.tryGetDouble(key: "bottom"),
      left: attributes.tryGetDouble(key: "left"),
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
