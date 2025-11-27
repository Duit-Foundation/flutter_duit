import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitRotatedBox extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;
  final Widget child;

  const DuitRotatedBox({
    required this.attributes,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithDataSource(
      context,
      attributes.payload,
    );

    return RotatedBox(
      key: Key(attributes.id),
      quarterTurns: attrs.getInt(key: "quarterTurns"),
      child: child,
    );
  }
}

class DuitControlledRotatedBox extends StatefulWidget with AnimatedAttributes {
  final UIElementController controller;
  final Widget child;

  const DuitControlledRotatedBox({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  State<DuitControlledRotatedBox> createState() =>
      _DuitControlledRotatedBoxState();
}

class _DuitControlledRotatedBoxState extends State<DuitControlledRotatedBox>
    with ViewControllerChangeListener {
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

    return RotatedBox(
      key: Key(widget.controller.id),
      quarterTurns: attrs.getInt(key: "quarterTurns"),
      child: widget.child,
    );
  }
}
