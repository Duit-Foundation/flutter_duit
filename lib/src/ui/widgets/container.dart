import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/animations/animated_props.dart";

class DuitContainer extends StatelessWidget with AnimatedPropertiesMixin {
  final Widget child;
  final ViewAttribute<ContainerAttributes> attributes;

  const DuitContainer({
    super.key,
    required this.child,
    required this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = wrapAttributes(context, attributes.payload);

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

class DuitControlledContainer extends StatefulWidget
    with AnimatedPropertiesMixin {
  final Widget child;
  final UIElementController<ContainerAttributes> controller;

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
    attachStateToController(
      widget.controller,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.wrapAttributes(
      context,
      widget.controller.attributes!.payload,
    );
    return Container(
      key: Key(widget.controller.id),
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
      child: widget.child,
    );
  }
}
