import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/animations/index.dart";

class DuitAnimatedSize extends StatefulWidget {
  final Widget child;
  final UIElementController controller;

  const DuitAnimatedSize({
    required this.child,
    required this.controller,
    super.key,
  });

  @override
  State<DuitAnimatedSize> createState() => _DuitAnimatedSizeState();
}

class _DuitAnimatedSizeState extends State<DuitAnimatedSize>
    with ViewControllerChangeListener, OnAnimationEnd {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      key: ValueKey(widget.controller.id),
      duration: attributes.duration(),
      clipBehavior: attributes.clipBehavior(defaultValue: Clip.hardEdge)!,
      alignment: attributes.alignment(defaultValue: Alignment.center)!,
      curve: attributes.curve(defaultValue: Curves.linear)!,
      reverseDuration: attributes.duration(key: "reverseDuration"),
      onEnd: onEndHandler(
        attributes.getAction("onEnd"),
        widget.controller.performAction,
      ),
      child: widget.child,
    );
  }
}
