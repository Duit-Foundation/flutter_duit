import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/animations/index.dart";

class DuitAnimatedSlide extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitAnimatedSlide({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  State<DuitAnimatedSlide> createState() => _DuitAnimatedSlideState();
}

class _DuitAnimatedSlideState extends State<DuitAnimatedSlide>
    with ViewControllerChangeListener, OnAnimationEnd {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      key: ValueKey(widget.controller.id),
      offset: attributes.offset(defaultValue: Offset.zero)!,
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
