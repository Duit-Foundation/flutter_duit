import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/controller/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

class DUITSizedBox extends StatelessWidget {
  final ViewAttributeWrapper? attributes;
  final Widget? child;

  const DUITSizedBox({
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

class DUITControlledSizedBox extends StatefulWidget {
  final UIElementController? controller;
  final Widget? child;

  const DUITControlledSizedBox({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DUITControlledSizedBox> createState() => _DUITControlledSizedBoxState();
}

class _DUITControlledSizedBoxState extends State<DUITControlledSizedBox>
    with ViewControllerChangeListener<DUITControlledSizedBox, SizedBoxAttributes> {
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
