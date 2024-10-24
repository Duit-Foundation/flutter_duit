import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/animations/index.dart";
import "package:flutter_duit/src/attributes/index.dart";

class DuitRotatedBox extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute<RotatedBoxAttributes> attributes;
  final Widget child;

  const DuitRotatedBox({
    super.key,
    required this.attributes,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithAttributes(
      context,
      attributes.payload,
    );

    return RotatedBox(
      key: Key(attributes.id),
      quarterTurns: attrs.quarterTurns,
      child: child,
    );
  }
}

class DuitControlledRotatedBox extends StatefulWidget with AnimatedAttributes {
  final UIElementController<RotatedBoxAttributes> controller;
  final Widget child;

  const DuitControlledRotatedBox({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitControlledRotatedBox> createState() =>
      _DuitControlledRotatedBoxState();
}

class _DuitControlledRotatedBoxState extends State<DuitControlledRotatedBox>
    with
        ViewControllerChangeListener<DuitControlledRotatedBox,
            RotatedBoxAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.mergeWithAttributes(
      context,
      attributes,
    );

    return RotatedBox(
      key: Key(widget.controller.id),
      quarterTurns: attrs.quarterTurns,
      child: widget.child,
    );
  }
}
