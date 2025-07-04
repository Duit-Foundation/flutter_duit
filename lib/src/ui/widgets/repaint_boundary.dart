import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitRepaintBoundary extends StatelessWidget {
  final Widget child;
  final ViewAttribute attributes;

  const DuitRepaintBoundary({
    super.key,
    required this.child,
    required this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final childIndex = attributes.payload.tryGetInt(key: "childIndex");

    if (childIndex == null) {
      return RepaintBoundary(
        key: Key(attributes.id),
        child: child,
      );
    } else {
      return RepaintBoundary.wrap(
        child,
        childIndex,
      );
    }
  }
}

class DuitControlledRepaintBoundary extends StatefulWidget {
  final Widget child;
  final UIElementController controller;

  const DuitControlledRepaintBoundary({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<DuitControlledRepaintBoundary> createState() =>
      _DuitControlledRepaintBoundaryState();
}

class _DuitControlledRepaintBoundaryState
    extends State<DuitControlledRepaintBoundary>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final childIndex = attributes.tryGetInt(key: "childIndex");
    if (childIndex == null) {
      return RepaintBoundary(
        key: Key(widget.controller.id),
        child: widget.child,
      );
    } else {
      return RepaintBoundary.wrap(
        widget.child,
        childIndex,
      );
    }
  }
}
