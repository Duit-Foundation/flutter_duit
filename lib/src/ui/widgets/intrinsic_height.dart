import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";

class DuitIntrinsicHeight extends StatelessWidget {
  final ViewAttribute attributes;
  final Widget child;

  const DuitIntrinsicHeight({
    required this.attributes,
    required this.child,
    super.key,
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
  final UIElementController controller;
  final Widget child;

  const DuitControlledIntrinsicHeight({
    required this.controller,
    required this.child,
    super.key,
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
