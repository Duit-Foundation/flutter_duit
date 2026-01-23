import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitLimitedBox extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;
  final Widget child;

  const DuitLimitedBox({
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
    return LimitedBox(
      key: Key(attributes.id),
      maxWidth: attrs.getDouble(
        key: "maxWidth",
        defaultValue: double.infinity,
      ),
      maxHeight: attrs.getDouble(
        key: "maxHeight",
        defaultValue: double.infinity,
      ),
      child: child,
    );
  }
}

class DuitControlledLimitedBox extends StatefulWidget with AnimatedAttributes {
  final UIElementController controller;
  final Widget child;

  const DuitControlledLimitedBox({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  State<DuitControlledLimitedBox> createState() =>
      _DuitControlledLimitedBoxState();
}

class _DuitControlledLimitedBoxState extends State<DuitControlledLimitedBox>
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
    return LimitedBox(
      key: Key(widget.controller.id),
      maxWidth: attrs.getDouble(
        key: "maxWidth",
        defaultValue: double.infinity,
      ),
      maxHeight: attrs.getDouble(
        key: "maxHeight",
        defaultValue: double.infinity,
      ),
      child: widget.child,
    );
  }
}
