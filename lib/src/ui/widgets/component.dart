import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/duit_impl/subtree_holder.dart";

///Wraps a subtree of component widgets and controls its updating]
class DuitComponent extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitComponent({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<DuitComponent> createState() => _DuitComponentState();
}

class _DuitComponentState extends State<DuitComponent>
    with SubtreeHolder<DuitComponent> {
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
