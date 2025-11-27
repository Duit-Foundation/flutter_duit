import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/animations/index.dart";

class DuitSliverAnimatedOpacity extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitSliverAnimatedOpacity({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  State<DuitSliverAnimatedOpacity> createState() =>
      _DuitSliverAnimatedOpacityState();
}

class _DuitSliverAnimatedOpacityState extends State<DuitSliverAnimatedOpacity>
    with ViewControllerChangeListener, OnAnimationEnd {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAnimatedOpacity(
      key: ValueKey(widget.controller.id),
      opacity: attributes.getDouble(key: "opacity", defaultValue: 1.0),
      duration: attributes.duration(),
      curve: attributes.curve(defaultValue: Curves.linear)!,
      onEnd: onEndHandler(
        attributes.getAction("onEnd"),
        widget.controller.performAction,
      ),
      sliver: attributes.getBool("needsBoxAdapter")
          ? SliverToBoxAdapter(child: widget.child)
          : widget.child,
    );
  }
}
