import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

class DuitCenter extends StatelessWidget {
  final ViewAttribute attributes;
  final Widget child;

  const DuitCenter({
    required this.attributes,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    return Center(
      key: Key(attributes.id),
      widthFactor: attrs.tryGetDouble(key: "widthFactor"),
      heightFactor: attrs.tryGetDouble(key: "heightFactor"),
      child: child,
    );
  }
}

class DuitControlledCenter extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitControlledCenter({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  State<DuitControlledCenter> createState() => _DuitControlledCenterState();
}

class _DuitControlledCenterState extends State<DuitControlledCenter>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      key: Key(widget.controller.id),
      widthFactor: attributes.tryGetDouble(key: "widthFactor"),
      heightFactor: attributes.tryGetDouble(key: "heightFactor"),
      child: widget.child,
    );
  }
}
