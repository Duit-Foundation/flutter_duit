import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/duit_impl/subtree_holder.dart";

///Wraps a subtree of component widgets and controls its updating
class DuitSubtree extends StatefulWidget {
  final Widget child;
  final UIElementController<SubtreeAttributes> controller;

  const DuitSubtree({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<DuitSubtree> createState() => _DuitComponentState();
}

class _DuitComponentState extends State<DuitSubtree>
    with SubtreeHolder<DuitSubtree> {
  @override
  void initState() {
    attachStateToController(
      widget.controller,
      widget.child,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return subtreeChild;
  }
}
