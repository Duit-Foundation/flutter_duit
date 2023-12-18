import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/controller/index.dart";
import 'package:flutter_duit/src/duit_impl/index.dart';

class DuitColoredBox extends StatelessWidget {
  final ViewAttributeWrapper? attributes;
  final Widget child;

  const DuitColoredBox({
    super.key,
    this.attributes,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final state = attributes?.payload as ColoredBoxAttributes?;
    return ColoredBox(
      color: state?.color ?? Colors.black,
      child: child,
    );
  }
}

class DuitControlledColoredBox extends StatefulWidget {
  final UIElementController? controller;
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
    with ViewControllerChangeListener<DuitControlledColoredBox, ColoredBoxAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: attributes?.color ?? Colors.black,
      child: widget.child,
    );
  }
}
