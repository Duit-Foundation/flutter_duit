import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/animations/index.dart";

class DuitAnimatedPositionedDirectionalState extends StatefulWidget
    with AnimatedAttributes {
  final UIElementController controller;
  final Widget child;

  const DuitAnimatedPositionedDirectionalState({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  State<DuitAnimatedPositionedDirectionalState> createState() =>
      _DuitAnimatedPositionedDirectionalStateState();
}

class _DuitAnimatedPositionedDirectionalStateState
    extends State<DuitAnimatedPositionedDirectionalState>
    with ViewControllerChangeListener, OnAnimationEnd {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.mergeWithDataSource(
      context,
      attributes,
    );
    return AnimatedPositionedDirectional(
      key: ValueKey(widget.controller.id),
      start: attrs.tryGetDouble(key: "start"),
      end: attrs.tryGetDouble(key: "end"),
      top: attrs.tryGetDouble(key: "top"),
      bottom: attrs.tryGetDouble(key: "bottom"),
      width: attrs.tryGetDouble(key: "width"),
      height: attrs.tryGetDouble(key: "height"),
      curve: attrs.curve()!,
      duration: attrs.duration(),
      onEnd: onEndHandler(
        attributes.getAction("onEnd"),
        widget.controller.performAction,
      ),
      child: widget.child,
    );
  }
}
