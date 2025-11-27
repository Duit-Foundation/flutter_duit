import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/animations/index.dart";

class DuitAnimatedPadding extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitAnimatedPadding({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  State<DuitAnimatedPadding> createState() => _DuitAnimatedPaddingState();
}

class _DuitAnimatedPaddingState extends State<DuitAnimatedPadding>
    with ViewControllerChangeListener, OnAnimationEnd {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      key: ValueKey(widget.controller.id),
      padding: attributes.edgeInsets(defaultValue: EdgeInsets.zero)!,
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
