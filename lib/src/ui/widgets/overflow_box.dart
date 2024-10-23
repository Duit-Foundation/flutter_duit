import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter_duit/src/animations/index.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

final class DuitOverflowBox extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute<OverflowBoxAttributes> attributes;
  final Widget child;

  const DuitOverflowBox({
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

    return OverflowBox(
      key: Key(attributes.id),
      alignment: attrs.alignment ?? Alignment.center,
      minWidth: attrs.minWidth,
      maxWidth: attrs.maxWidth,
      minHeight: attrs.minHeight,
      maxHeight: attrs.maxHeight,
      fit: attrs.fit ?? OverflowBoxFit.max,
      child: child,
    );
  }
}

final class DuitControlledOverflowBox extends StatefulWidget
    with AnimatedAttributes {
  final UIElementController<OverflowBoxAttributes> controller;
  final Widget child;

  const DuitControlledOverflowBox({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitControlledOverflowBox> createState() =>
      _DuitControlledOverflowBoxState();
}

class _DuitControlledOverflowBoxState extends State<DuitControlledOverflowBox>
    with
        ViewControllerChangeListener<DuitControlledOverflowBox,
            OverflowBoxAttributes> {
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

    return OverflowBox(
      key: Key(widget.controller.id),
      alignment: attrs.alignment ?? Alignment.center,
      minWidth: attrs.minWidth,
      maxWidth: attrs.maxWidth,
      minHeight: attrs.minHeight,
      maxHeight: attrs.maxHeight,
      fit: attrs.fit ?? OverflowBoxFit.max,
      child: widget.child,
    );
  }
}
