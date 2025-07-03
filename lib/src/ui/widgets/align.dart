import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitAlign extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;
  final Widget child;

  const DuitAlign({
    super.key,
    required this.attributes,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithDataSource(
      context,
      attributes.payload,
    );

    return Align(
      key: Key(attributes.id),
      alignment: attrs.alignment(defaultValue: Alignment.center)!,
      widthFactor: attrs.tryGetDouble(key: "widthFactor"),
      heightFactor: attrs.tryGetDouble(key: "heightFactor"),
      child: child,
    );
  }
}

class DuitControlledAlign extends StatefulWidget with AnimatedAttributes {
  final UIElementController controller;
  final Widget child;

  const DuitControlledAlign({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitControlledAlign> createState() => _DuitControlledAlignState();
}

class _DuitControlledAlignState extends State<DuitControlledAlign>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.mergeWithDataSource(
      context,
      attributes,
    );

    return Align(
      key: Key(widget.controller.id),
      alignment: attrs.alignment(defaultValue: Alignment.center)!,
      widthFactor: attrs.tryGetDouble(key: "widthFactor"),
      heightFactor: attrs.tryGetDouble(key: "heightFactor"),
      child: widget.child,
    );
  }
}
