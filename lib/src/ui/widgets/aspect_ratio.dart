import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitAspectRatio extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;
  final Widget child;

  const DuitAspectRatio({
    required this.attributes,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithDataSource(
      context,
      attributes.payload,
    );
    return AspectRatio(
      key: Key(attributes.id),
      aspectRatio: attrs.getDouble(key: "aspectRatio", defaultValue: 1.0),
      child: child,
    );
  }
}

class DuitControlledAspectRatio extends StatefulWidget
    with AnimatedAttributes {
  final UIElementController controller;
  final Widget child;

  const DuitControlledAspectRatio({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  State<DuitControlledAspectRatio> createState() =>
      _DuitControlledAspectRatioState();
}

class _DuitControlledAspectRatioState extends State<DuitControlledAspectRatio>
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
    return AspectRatio(
      key: Key(widget.controller.id),
      aspectRatio: attrs.getDouble(key: "aspectRatio", defaultValue: 1.0),
      child: widget.child,
    );
  }
}
