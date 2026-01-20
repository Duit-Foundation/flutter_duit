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

class DuitControlledAspectRation extends StatefulWidget
    with AnimatedAttributes {
  final UIElementController controller;
  final Widget child;

  const DuitControlledAspectRation({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  State<DuitControlledAspectRation> createState() =>
      _DuitControlledAspectRationState();
}

class _DuitControlledAspectRationState extends State<DuitControlledAspectRation>
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
