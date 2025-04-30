import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

final class DuitFittedBox extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;
  final Widget child;

  const DuitFittedBox({
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

    return FittedBox(
      key: Key(attributes.id),
      fit: attrs.boxFit(defaultValue: BoxFit.contain) as BoxFit,
      clipBehavior: attrs.clipBehavior(defaultValue: Clip.none),
      alignment: attrs.alignment(defaultValue: Alignment.center) as Alignment,
      child: child,
    );
  }
}

class DuitControlledFittedBox extends StatefulWidget with AnimatedAttributes {
  final UIElementController controller;
  final Widget child;

  const DuitControlledFittedBox({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<DuitControlledFittedBox> createState() =>
      _DuitControlledFittedBoxState();
}

class _DuitControlledFittedBoxState extends State<DuitControlledFittedBox>
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

    return FittedBox(
      key: Key(widget.controller.id),
      fit: attrs.boxFit(defaultValue: BoxFit.contain) as BoxFit,
      clipBehavior: attrs.clipBehavior(defaultValue: Clip.none),
      alignment: attrs.alignment(defaultValue: Alignment.center) as Alignment,
      child: widget.child,
    );
  }
}
