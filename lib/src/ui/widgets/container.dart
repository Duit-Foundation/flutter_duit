import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";

class DuitContainer extends StatelessWidget {
  final Widget child;
  final ViewAttribute attributes;

  const DuitContainer({
    super.key,
    required this.child,
    required this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload as ContainerAttributes;
    return Container(
      key: Key(attributes.id),
      alignment: attrs.alignment,
      constraints: attrs.constraints,
      padding: attrs.padding,
      margin: attrs.margin,
      width: attrs.width,
      height: attrs.height,
      color: attrs.color,
      clipBehavior: attrs.clipBehavior ?? Clip.none,
      decoration: attrs.decoration,
      transformAlignment: attrs.transformAlignment,
      child: child,
    );
  }
}

class DuitControlledContainer extends StatefulWidget {
  final Widget child;
  final UIElementController controller;

  const DuitControlledContainer({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<DuitControlledContainer> createState() =>
      _DuitControlledContainerState();
}

class _DuitControlledContainerState extends State<DuitControlledContainer>
    with
        ViewControllerChangeListener<DuitControlledContainer,
            ContainerAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(widget.controller.id),
      alignment: attributes.alignment,
      constraints: attributes.constraints,
      padding: attributes.padding,
      margin: attributes.margin,
      width: attributes.width,
      height: attributes.height,
      color: attributes.color,
      clipBehavior: attributes.clipBehavior ?? Clip.none,
      decoration: attributes.decoration,
      transformAlignment: attributes.transformAlignment,
      child: widget.child,
    );
  }
}
