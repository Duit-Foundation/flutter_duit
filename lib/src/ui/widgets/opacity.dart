import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitOpacity extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;
  final Widget child;

  const DuitOpacity({
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

    return Opacity(
      key: Key(attributes.id),
      opacity: attrs.getDouble(
        key: "opacity",
        defaultValue: 1.0,
      ),
      child: child,
    );
  }
}

class DuitControlledOpacity extends StatefulWidget with AnimatedAttributes {
  final UIElementController controller;
  final Widget child;

  const DuitControlledOpacity({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitControlledOpacity> createState() => _DuitControlledOpacityState();
}

class _DuitControlledOpacityState extends State<DuitControlledOpacity>
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

    return Opacity(
      key: Key(widget.controller.id),
      opacity: attrs.getDouble(
        key: "opacity",
        defaultValue: 1.0,
      ),
      child: widget.child,
    );
  }
}
