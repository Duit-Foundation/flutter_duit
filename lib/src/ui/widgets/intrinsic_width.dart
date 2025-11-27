import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitIntrinsicWidth extends StatelessWidget with AnimatedAttributes {
  final Widget child;
  final ViewAttribute attributes;

  const DuitIntrinsicWidth({
    required this.child,
    required this.attributes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithDataSource(context, attributes.payload);
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
  final Widget child;
  final UIElementController controller;

  const DuitControlledIntrinsicWidth({
    required this.child,
    required this.controller,
    super.key,
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
