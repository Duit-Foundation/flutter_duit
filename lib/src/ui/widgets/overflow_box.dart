import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter_duit/src/animations/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

final class DuitOverflowBox extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;
  final Widget child;

  const DuitOverflowBox({
    required this.child,
    required this.attributes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithDataSource(
      context,
      attributes.payload,
    );

    return OverflowBox(
      key: Key(attributes.id),
      alignment: attrs.alignment(defaultValue: Alignment.center)!,
      minWidth: attrs.tryGetDouble(key: "minWidth"),
      maxWidth: attrs.tryGetDouble(key: "maxWidth"),
      minHeight: attrs.tryGetDouble(key: "minHeight"),
      maxHeight: attrs.tryGetDouble(key: "maxHeight"),
      fit: attrs.overflowBoxFit(defaultValue: OverflowBoxFit.max)!,
      child: child,
    );
  }
}

final class DuitControlledOverflowBox extends StatefulWidget
    with AnimatedAttributes {
  final UIElementController controller;
  final Widget child;

  const DuitControlledOverflowBox({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  State<DuitControlledOverflowBox> createState() =>
      _DuitControlledOverflowBoxState();
}

class _DuitControlledOverflowBoxState extends State<DuitControlledOverflowBox>
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

    return OverflowBox(
      key: Key(widget.controller.id),
      alignment: attrs.alignment(defaultValue: Alignment.center)!,
      minWidth: attrs.tryGetDouble(key: "minWidth"),
      maxWidth: attrs.tryGetDouble(key: "maxWidth"),
      minHeight: attrs.tryGetDouble(key: "minHeight"),
      maxHeight: attrs.tryGetDouble(key: "maxHeight"),
      fit: attrs.overflowBoxFit(defaultValue: OverflowBoxFit.max)!,
      child: widget.child,
    );
  }
}
