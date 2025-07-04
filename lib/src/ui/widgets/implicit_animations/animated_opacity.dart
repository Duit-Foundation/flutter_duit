import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/animations/index.dart";

class DuitAnimatedOpacity extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitAnimatedOpacity({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<DuitAnimatedOpacity> createState() => _DuitAnimatedOpacityState();
}

class _DuitAnimatedOpacityState extends State<DuitAnimatedOpacity>
    with ViewControllerChangeListener, OnAnimationEnd {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      key: ValueKey(widget.controller.id),
      duration: attributes.duration(),
      curve: attributes.curve(defaultValue: Curves.linear)!,
      opacity: attributes.getDouble(
        key: "opacity",
        defaultValue: 1.0,
      ),
      onEnd: onEndHandler(
        attributes.getAction("onEnd"),
        widget.controller.performAction,
      ),
      child: widget.child,
    );
  }
}
