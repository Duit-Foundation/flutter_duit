import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";
import "package:flutter_duit/src/duit_kernel/index.dart";

class DuitPositioned extends StatelessWidget {
  final Widget child;
  final ViewAttributeWrapper? attributes;

  const DuitPositioned({
    super.key,
    required this.child,
    this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes?.payload as PositionedAttributes?;
    return Positioned(
      top: attrs?.top,
      left: attrs?.left,
      right: attrs?.right,
      bottom: attrs?.bottom,
      child: child,
    );
  }
}

class DuitControlledPositioned extends StatefulWidget {
  final UIElementController? controller;
  final Widget child;

  const DuitControlledPositioned({
    super.key,
    required this.child,
    this.controller,
  });

  @override
  State<DuitControlledPositioned> createState() =>
      _DuitControlledPositionedState();
}

class _DuitControlledPositionedState extends State<DuitControlledPositioned>
    with
        ViewControllerChangeListener<DuitControlledPositioned,
            PositionedAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: attributes?.top,
      left: attributes?.left,
      right: attributes?.right,
      bottom: attributes?.bottom,
      child: widget.child,
    );
  }
}
