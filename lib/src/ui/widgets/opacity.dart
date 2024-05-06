import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";

class DuitOpacity extends StatelessWidget {
  final ViewAttributeWrapper attributes;
  final Widget child;

  const DuitOpacity({
    super.key,
    required this.attributes,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload as OpacityAttributes;
    return Opacity(
      key: Key(attributes.id),
      opacity: attrs.opacity,
      child: child,
    );
  }
}

class DuitControlledOpacity extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitControlledOpacity({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitControlledOpacity> createState() => _DuitControlledOpacityState();
}

class _DuitControlledOpacityState extends State<DuitControlledOpacity>
    with
        ViewControllerChangeListener<DuitControlledOpacity, OpacityAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      key: Key(widget.controller.id),
      opacity: attributes.opacity,
      child: widget.child,
    );
  }
}
