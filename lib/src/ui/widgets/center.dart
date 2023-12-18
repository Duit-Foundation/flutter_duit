import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/controller/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

class DuitCenter extends StatelessWidget {
  final ViewAttributeWrapper? attributes;
  final Widget child;

  const DuitCenter({
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

class DuitControlledCenter extends StatefulWidget {
  final UIElementController? controller;
  final Widget child;

  const DuitControlledCenter({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitControlledCenter> createState() => _DuitControlledCenterState();
}

class _DuitControlledCenterState extends State<DuitControlledCenter>
    with ViewControllerChangeListener<DuitControlledCenter, CenterAttributes> {
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
