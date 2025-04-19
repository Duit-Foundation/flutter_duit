import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/animations/index.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

class DuitPadding extends StatelessWidget with AnimatedAttributes {
  final Widget child;
  final ViewAttribute<PaddingAttributes> attributes;

  const DuitPadding({
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
    return Padding(
      key: Key(attributes.id),
      padding: attrs.padding,
      child: child,
    );
  }
}

class DuitControlledPadding extends StatefulWidget with AnimatedAttributes {
  final UIElementController<PaddingAttributes> controller;
  final Widget child;

  const DuitControlledPadding({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<DuitControlledPadding> createState() => _DuitControlledPaddingState();
}

class _DuitControlledPaddingState extends State<DuitControlledPadding>
    with
        ViewControllerChangeListener<DuitControlledPadding, PaddingAttributes> {
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

    return Padding(
      key: Key(widget.controller.id),
      padding: attrs.padding,
      child: widget.child,
    );
  }
}
