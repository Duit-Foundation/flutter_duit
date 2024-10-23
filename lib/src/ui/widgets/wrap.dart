import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/animations/index.dart";
import "package:flutter_duit/src/attributes/index.dart";

class DuitWrap extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute<WrapAttributes> attributes;
  final List<Widget> children;

  const DuitWrap({
    super.key,
    required this.attributes,
    this.children = const [],
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithAttributes(context, attributes.payload);
    return Wrap(
      key: Key(attributes.id),
      alignment: attrs.alignment ?? WrapAlignment.start,
      runAlignment: attrs.runAlignment ?? WrapAlignment.start,
      spacing: attrs.spacing,
      runSpacing: attrs.runSpacing,
      direction: attrs.direction ?? Axis.horizontal,
      textDirection: attrs.textDirection,
      verticalDirection: attrs.verticalDirection ?? VerticalDirection.down,
      clipBehavior: attrs.clipBehavior ?? Clip.none,
      crossAxisAlignment: attrs.crossAxisAlignment ?? WrapCrossAlignment.start,
      children: children,
    );
  }
}

class DuitControlledWrap extends StatefulWidget with AnimatedAttributes {
  final UIElementController<WrapAttributes> controller;
  final List<Widget> children;

  const DuitControlledWrap({
    super.key,
    required this.controller,
    this.children = const [],
  });

  @override
  State<DuitControlledWrap> createState() => _DuitControlledWrapState();
}

class _DuitControlledWrapState extends State<DuitControlledWrap>
    with ViewControllerChangeListener<DuitControlledWrap, WrapAttributes> {
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

    return Wrap(
      key: Key(widget.controller.id),
      alignment: attrs.alignment ?? WrapAlignment.start,
      runAlignment: attrs.runAlignment ?? WrapAlignment.start,
      spacing: attrs.spacing,
      runSpacing: attrs.runSpacing,
      direction: attrs.direction ?? Axis.horizontal,
      textDirection: attrs.textDirection,
      crossAxisAlignment: attrs.crossAxisAlignment ?? WrapCrossAlignment.start,
      verticalDirection: attrs.verticalDirection ?? VerticalDirection.down,
      clipBehavior: attrs.clipBehavior ?? Clip.none,
      children: widget.children,
    );
  }
}
