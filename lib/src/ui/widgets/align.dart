import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";

class DuitAlign extends StatelessWidget {
  final ViewAttributeWrapper? attributes;
  final Widget? child;

  const DuitAlign({
    super.key,
    this.attributes,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes?.payload as AlignAttributes?;
    return Align(
      alignment: attrs?.alignment ?? Alignment.center,
      widthFactor: attrs?.widthFactor,
      heightFactor: attrs?.heightFactor,
      child: child,
    );
  }
}

class DuitControlledAlign extends StatefulWidget {
  final UIElementController? controller;
  final Widget? child;

  const DuitControlledAlign({
    super.key,
    this.controller,
    this.child,
  });

  @override
  State<DuitControlledAlign> createState() => _DuitControlledAlignState();
}

class _DuitControlledAlignState extends State<DuitControlledAlign>
    with ViewControllerChangeListener<DuitControlledAlign, AlignAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: attributes?.alignment ?? Alignment.center,
      widthFactor: attributes?.widthFactor,
      heightFactor: attributes?.heightFactor,
      child: widget.child,
    );
  }
}
