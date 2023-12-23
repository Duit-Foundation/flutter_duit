import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";

class DuitStack extends StatelessWidget {
  final ViewAttributeWrapper? attributes;
  final List<Widget> children;

  const DuitStack({
    super.key,
    this.children = const [],
    this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes?.payload as StackAttributes?;
    return Stack(
      alignment: attrs?.alignment ?? AlignmentDirectional.topStart,
      textDirection: attrs?.textDirection,
      fit: attrs?.fit ?? StackFit.loose,
      clipBehavior: attrs?.clipBehavior ?? Clip.hardEdge,
      children: children,
    );
  }
}

class DuitControlledStack extends StatefulWidget {
  final UIElementController? controller;
  final List<Widget> children;

  const DuitControlledStack({
    super.key,
    required this.children,
    this.controller,
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
    return Stack(
      alignment: attributes?.alignment ?? AlignmentDirectional.topStart,
      textDirection: attributes?.textDirection,
      fit: attributes?.fit ?? StackFit.loose,
      clipBehavior: attributes?.clipBehavior ?? Clip.hardEdge,
      children: widget.children,
    );
  }
}
