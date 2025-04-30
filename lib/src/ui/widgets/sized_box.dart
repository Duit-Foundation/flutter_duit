import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/animations/index.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

class DuitSizedBox extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;
  final Widget? child;

  const DuitSizedBox({
    super.key,
    required this.attributes,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithDataSource(
      context,
      DuitDataSource(attributes.payload),
    );
    return SizedBox(
      key: Key(attributes.id),
      width: attrs.tryGetDouble(key: "width"),
      height: attrs.tryGetDouble(key: "height"),
      child: child,
    );
  }
}

class DuitControlledSizedBox extends StatefulWidget with AnimatedAttributes {
  final UIElementController controller;
  final Widget child;

  const DuitControlledSizedBox({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitControlledSizedBox> createState() => _DuitControlledSizedBoxState();
}

class _DuitControlledSizedBoxState extends State<DuitControlledSizedBox>
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

    return SizedBox(
      key: Key(widget.controller.id),
      width: attrs.tryGetDouble(key: "width"),
      height: attrs.tryGetDouble(key: "height"),
      child: widget.child,
    );
  }
}
