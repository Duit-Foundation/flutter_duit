import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitConstrainedBox extends StatelessWidget with AnimatedAttributes {
  final Widget child;
  final ViewAttribute attributes;

  const DuitConstrainedBox({
    super.key,
    required this.child,
    required this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithDataSource(
      context,
      DuitDataSource(attributes.payload),
    );

    return ConstrainedBox(
      key: ValueKey(attributes.id),
      constraints: attrs.boxConstraints(),
      child: child,
    );
  }
}

class DuitControlledConstrainedBox extends StatefulWidget
    with AnimatedAttributes {
  final Widget child;
  final UIElementController controller;

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

    return ConstrainedBox(
      key: ValueKey(widget.controller.id),
      constraints: attrs.boxConstraints(),
      child: widget.child,
    );
  }
}
