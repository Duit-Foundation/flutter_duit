import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/controller/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

class DUITCenter extends StatelessWidget {
  final ViewAttributeWrapper? attributes;
  final Widget child;

  const DUITCenter({
    super.key,
    required this.attributes,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final state = attributes?.payload as CenterAttributes?;
    return Center(
      widthFactor: state?.widthFactor,
      heightFactor: state?.heightFactor,
      child: child,
    );
  }
}

class DUITControlledCenter extends StatefulWidget {
  final UIElementController? controller;
  final Widget child;

  const DUITControlledCenter({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DUITControlledCenter> createState() => _DUITControlledCenterState();
}

class _DUITControlledCenterState extends State<DUITControlledCenter>
    with ViewControllerChangeListener<DUITControlledCenter, CenterAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      widthFactor: attributes?.widthFactor,
      heightFactor: attributes?.heightFactor,
      child: widget.child,
    );
  }
}
