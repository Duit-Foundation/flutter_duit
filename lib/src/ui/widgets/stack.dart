import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitStack extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;
  final List<Widget> children;

  const DuitStack({
    required this.attributes,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithDataSource(
      context,
      attributes.payload,
    );

    return Stack(
      key: ValueKey(attributes.id),
      alignment: attrs.alignmentDirectional(
          defaultValue: AlignmentDirectional.topStart)!,
      textDirection: attrs.textDirection(),
      fit: attrs.stackFit(defaultValue: StackFit.loose)!,
      clipBehavior: attrs.clipBehavior()!,
      children: children,
    );
  }
}

class DuitControlledStack extends StatefulWidget with AnimatedAttributes {
  final UIElementController controller;
  final List<Widget> children;

  const DuitControlledStack({
    required this.children,
    required this.controller,
    super.key,
  });

  @override
  State<DuitControlledStack> createState() => _DuitControlledStackState();
}

class _DuitControlledStackState extends State<DuitControlledStack>
    with ViewControllerChangeListener, SlotHost {
  @override
  void initState() {
    attachStateToController(widget.controller);
    handleSlots(widget.controller, widget.children);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.mergeWithDataSource(
      context,
      attributes,
    );
    return Stack(
      key: ValueKey(widget.controller.id),
      alignment: attrs.alignmentDirectional(
          defaultValue: AlignmentDirectional.topStart)!,
      textDirection: attrs.textDirection(),
      fit: attrs.stackFit(defaultValue: StackFit.loose)!,
      clipBehavior: attrs.clipBehavior()!,
      children: children,
    );
  }
}
