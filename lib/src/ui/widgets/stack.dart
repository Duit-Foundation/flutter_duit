import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitStack extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;
  final List<Widget> children;

  const DuitStack({
    super.key,
    required this.attributes,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithDataSource(
      context,
      DuitDataSource(attributes.payload),
    );

    return Stack(
      key: Key(attributes.id),
      alignment: attrs.alignmentDirectional(),
      textDirection: attrs.textDirection(),
      fit: attrs.stackFit(defaultValue: StackFit.loose),
      clipBehavior: attrs.clipBehavior(),
      children: children,
    );
  }
}

class DuitControlledStack extends StatefulWidget with AnimatedAttributes {
  final UIElementController controller;
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
    return Stack(
      alignment: attrs.alignmentDirectional(),
      textDirection: attrs.textDirection(),
      fit: attrs.stackFit(defaultValue: StackFit.loose),
      clipBehavior: attrs.clipBehavior(),
      children: widget.children,
    );
  }
}
