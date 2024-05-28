import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";

class DuitRepaintBoundary extends StatelessWidget {
  final Widget child;
  final ViewAttribute<RepaintBoundaryAttributes> attributes;

  const DuitRepaintBoundary({
    super.key,
    required this.child,
    required this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;

    if (attrs.childIndex == null) {
      return RepaintBoundary(
        child: child,
      );
    } else {
      return RepaintBoundary.wrap(
        child,
        attrs.childIndex!,
      );
    }
  }
}

class DuitControlledRepaintBoundary extends StatefulWidget {
  final Widget child;
  final UIElementController<RepaintBoundaryAttributes> controller;

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
    with
        ViewControllerChangeListener<DuitControlledRepaintBoundary,
            RepaintBoundaryAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (attributes.childIndex == null) {
      return RepaintBoundary(
        key: Key(widget.controller.id),
        child: widget.child,
      );
    } else {
      return RepaintBoundary.wrap(
        widget.child,
        attributes.childIndex!,
      );
    }
  }
}
