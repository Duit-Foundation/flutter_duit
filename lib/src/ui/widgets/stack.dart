import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/animations/index.dart";
import "package:flutter_duit/src/attributes/index.dart";

class DuitStack extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute<StackAttributes> attributes;
  final List<Widget> children;

  const DuitStack({
    super.key,
    required this.attributes,
    this.children = const [],
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithAttributes(
      context,
      attributes.payload,
    );

    return Stack(
      key: Key(attributes.id),
      alignment: attrs.alignment ?? AlignmentDirectional.topStart,
      textDirection: attrs.textDirection,
      fit: attrs.fit ?? StackFit.loose,
      clipBehavior: attrs.clipBehavior ?? Clip.hardEdge,
      children: children,
    );
  }
}

class DuitControlledStack extends StatefulWidget with AnimatedAttributes {
  final UIElementController<StackAttributes> controller;
  final List<Widget> children;

  const DuitControlledStack({
    super.key,
    required this.children,
    required this.controller,
  });

  @override
  State<DuitControlledStack> createState() => _DuitControlledStackState();
}

class _DuitControlledStackState extends State<DuitControlledStack>
    with ViewControllerChangeListener<DuitControlledStack, StackAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.mergeWithController(
      context,
      widget.controller,
    );
    return Stack(
      alignment: attrs.alignment ?? AlignmentDirectional.topStart,
      textDirection: attrs.textDirection,
      fit: attrs.fit ?? StackFit.loose,
      clipBehavior: attrs.clipBehavior ?? Clip.hardEdge,
      children: widget.children,
    );
  }
}
