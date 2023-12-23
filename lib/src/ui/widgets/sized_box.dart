import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

class DuitSizedBox extends StatelessWidget {
  final ViewAttributeWrapper? attributes;
  final Widget? child;

  const DuitSizedBox({
    super.key,
    required this.attributes,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final state = attributes?.payload as SizedBoxAttributes?;
    return SizedBox(
      width: state?.width?.toDouble(),
      height: state?.height?.toDouble(),
      child: child,
    );
  }
}

class DuitControlledSizedBox extends StatefulWidget {
  final UIElementController? controller;
  final Widget? child;

  const DuitControlledSizedBox({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitControlledSizedBox> createState() => _DuitControlledSizedBoxState();
}

class _DuitControlledSizedBoxState extends State<DuitControlledSizedBox>
    with
        ViewControllerChangeListener<DuitControlledSizedBox,
            SizedBoxAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: attributes?.width?.toDouble(),
      height: attributes?.height?.toDouble(),
      child: widget.child,
    );
  }
}
