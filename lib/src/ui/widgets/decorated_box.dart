import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/animations/index.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

class DuitDecoratedBox extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute<DecoratedBoxAttributes> attributes;
  final Widget child;

  const DuitDecoratedBox({
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

    return DecoratedBox(
      key: Key(attributes.id),
      decoration: attrs.decoration ?? const BoxDecoration(),
      child: child,
    );
  }
}

class DuitControlledDecoratedBox extends StatefulWidget
    with AnimatedAttributes {
  final UIElementController<DecoratedBoxAttributes> controller;
  final Widget child;

  const DuitControlledDecoratedBox({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitControlledDecoratedBox> createState() =>
      _DuitControlledDecoratedBoxState();
}

class _DuitControlledDecoratedBoxState extends State<DuitControlledDecoratedBox>
    with
        ViewControllerChangeListener<DuitControlledDecoratedBox,
            DecoratedBoxAttributes> {
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

    return DecoratedBox(
      key: Key(widget.controller.id),
      decoration: attrs.decoration ?? const BoxDecoration(),
      child: widget.child,
    );
  }
}
