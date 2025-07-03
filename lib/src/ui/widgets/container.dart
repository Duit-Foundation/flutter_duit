import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitContainer extends StatelessWidget with AnimatedAttributes {
  final Widget child;
  final ViewAttribute attributes;

  const DuitContainer({
    super.key,
    required this.child,
    required this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithDataSource(context, attributes.payload);
    return Container(
      key: Key(attributes.id),
      alignment: attrs.alignment(),
      constraints: attrs.boxConstraints(),
      padding: attrs.edgeInsets(),
      margin: attrs.edgeInsets(key: "margin"),
      width: attrs.tryGetDouble(key: "width"),
      height: attrs.tryGetDouble(key: "height"),
      color: attrs.tryParseColor(key: "color"),
      clipBehavior: attrs.clipBehavior(defaultValue: Clip.none)!,
      decoration: attrs.decoration(),
      transformAlignment: attrs.alignment(),
      child: child,
    );
  }
}

class DuitControlledContainer extends StatefulWidget with AnimatedAttributes {
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
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(
      widget.controller,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.mergeWithDataSource(
      context,
      attributes,
    );
    return Container(
      key: Key(widget.controller.id),
      alignment: attrs.alignment(),
      constraints: attrs.boxConstraints(),
      padding: attrs.edgeInsets(),
      margin: attrs.edgeInsets(key: "margin"),
      width: attrs.tryGetDouble(key: "width"),
      height: attrs.tryGetDouble(key: "height"),
      color: attrs.tryParseColor(key: "color"),
      clipBehavior: attrs.clipBehavior(defaultValue: Clip.none)!,
      decoration: attrs.decoration(),
      transformAlignment: attrs.alignment(),
      child: widget.child,
    );
  }
}
