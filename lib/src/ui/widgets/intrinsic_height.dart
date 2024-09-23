import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";

class DuitIntrinsicHeight extends StatelessWidget {
  final ViewAttribute<IntrinsicHeightAttributes> attributes;
  final Widget child;

  const DuitIntrinsicHeight({
    super.key,
    required this.attributes,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      key: Key(attributes.id),
      child: child,
    );
  }
}

class DuitControlledIntrinsicHeight extends StatefulWidget {
  final UIElementController<IntrinsicHeightAttributes> controller;
  final Widget child;

  const DuitControlledIntrinsicHeight({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitControlledIntrinsicHeight> createState() =>
      _DuitControlledIntrinsicHeightState();
}

class _DuitControlledIntrinsicHeightState
    extends State<DuitControlledIntrinsicHeight> {
  //NOTE: We do not subscribe to attribute updates due to the lack of data in them that can be updated
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      key: Key(widget.controller.id),
      child: widget.child,
    );
  }
}
