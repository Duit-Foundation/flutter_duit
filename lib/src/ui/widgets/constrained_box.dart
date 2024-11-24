import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/animations/index.dart";
import "package:flutter_duit/src/attributes/index.dart";

class DuitConstrainedBox extends StatelessWidget with AnimatedAttributes {
  final Widget child;
  final ViewAttribute<ConstrainedBoxAttributes> attributes;

  const DuitConstrainedBox({
    super.key,
    required this.child,
    required this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithAttributes(
      context,
      attributes.payload,
    );

    return ConstrainedBox(
      key: ValueKey(attributes.id),
      constraints: attrs.constraints,
      child: child,
    );
  }
}

class DuitControlledConstrainedBox extends StatefulWidget
    with AnimatedAttributes {
  final Widget child;
  final UIElementController<ConstrainedBoxAttributes> controller;

  const DuitControlledConstrainedBox({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<DuitControlledConstrainedBox> createState() =>
      _DuitControlledConstrainedBoxState();
}

class _DuitControlledConstrainedBoxState
    extends State<DuitControlledConstrainedBox>
    with
        ViewControllerChangeListener<DuitControlledConstrainedBox,
            ConstrainedBoxAttributes> {
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

    return ConstrainedBox(
      key: ValueKey(widget.controller.id),
      constraints: attrs.constraints,
      child: widget.child,
    );
  }
}
