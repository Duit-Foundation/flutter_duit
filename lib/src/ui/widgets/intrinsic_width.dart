import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitIntrinsicWidth extends StatelessWidget with AnimatedAttributes {
  final Widget child;
  final ViewAttribute attributes;

  const DuitIntrinsicWidth({
    super.key,
    required this.child,
    required this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final attrs =
        mergeWithDataSource(context, DuitDataSource(attributes.payload));
    return IntrinsicWidth(
      key: Key(attributes.id),
      stepWidth: attrs.tryGetDouble(key: "stepWidth"),
      stepHeight: attrs.tryGetDouble(key: "stepHeight"),
      child: child,
    );
  }
}

class DuitControlledIntrinsicWidth extends StatefulWidget
    with AnimatedAttributes {
  final UIElementController controller;
  final Widget child;

  const DuitControlledIntrinsicWidth({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<DuitControlledIntrinsicWidth> createState() =>
      _DuitControlledIntrinsicWidthState();
}

class _DuitControlledIntrinsicWidthState
    extends State<DuitControlledIntrinsicWidth>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(
      widget.controller,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.mergeWithDataSource(
      context,
      attributes,
    );
    return IntrinsicWidth(
      key: Key(widget.controller.id),
      stepWidth: attrs.tryGetDouble(key: "stepWidth"),
      stepHeight: attrs.tryGetDouble(key: "stepHeight"),
      child: widget.child,
    );
  }
}
