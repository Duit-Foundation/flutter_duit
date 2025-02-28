import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/animations/index.dart";
import "package:flutter_duit/src/attributes/index.dart";
import 'package:flutter_duit/src/duit_impl/index.dart';

class DuitColoredBox extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute<ColoredBoxAttributes> attributes;
  final Widget child;

  const DuitColoredBox({
    super.key,
    required this.attributes,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithAttributes(context, attributes.payload);
    return ColoredBox(
      key: Key(attributes.id),
      color: attrs.color,
      child: child,
    );
  }
}

class DuitControlledColoredBox extends StatefulWidget with AnimatedAttributes {
  final UIElementController<ColoredBoxAttributes> controller;
  final Widget child;

  const DuitControlledColoredBox({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<DuitControlledColoredBox> createState() =>
      _DuitControlledColoredBoxState();
}

class _DuitControlledColoredBoxState extends State<DuitControlledColoredBox>
    with
        ViewControllerChangeListener<DuitControlledColoredBox,
            ColoredBoxAttributes> {
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
    return ColoredBox(
      key: Key(widget.controller.id),
      color: attrs.color,
      child: widget.child,
    );
  }
}
