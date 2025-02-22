import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";

class DuitIntrinsicWidth extends StatelessWidget with AnimatedAttributes {
  final Widget child;
  final ViewAttribute<IntrinsicWidthAttributes> attributes;

  const DuitIntrinsicWidth({
    super.key,
    required this.child,
    required this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithAttributes(context, attributes.payload);
    return IntrinsicWidth(
      key: Key(attributes.id),
      stepWidth: attrs.stepWidth,
      stepHeight: attrs.stepHeight,
      child: child,
    );
  }
}

class DuitControlledIntrinsicWidth extends StatefulWidget
    with AnimatedAttributes {
  final Widget child;
  final UIElementController<IntrinsicWidthAttributes> controller;

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
    with
        ViewControllerChangeListener<DuitControlledIntrinsicWidth,
            IntrinsicWidthAttributes> {
  @override
  void initState() {
    attachStateToController(
      widget.controller,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.mergeWithAttributes(
      context,
      attributes,
    );
    return IntrinsicWidth(
        key: Key(widget.controller.id),
        stepWidth: attrs.stepWidth,
        stepHeight: attrs.stepHeight,
        child: widget.child);
  }
}
