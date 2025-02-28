import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/animations/index.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

class DuitSizedBox extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute<SizedBoxAttributes> attributes;
  final Widget? child;

  const DuitSizedBox({
    super.key,
    required this.attributes,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithAttributes(
      context,
      attributes.payload,
    );
    return SizedBox(
      key: Key(attributes.id),
      width: attrs.width?.toDouble(),
      height: attrs.height?.toDouble(),
      child: child,
    );
  }
}

class DuitControlledSizedBox extends StatefulWidget with AnimatedAttributes {
  final UIElementController<SizedBoxAttributes> controller;
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
    with
        ViewControllerChangeListener<DuitControlledSizedBox,
            SizedBoxAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.mergeWithAttributes(
      context,
      attributes,
    );

    return SizedBox(
      key: Key(widget.controller.id),
      width: attrs.width?.toDouble(),
      height: attrs.height?.toDouble(),
      child: widget.child,
    );
  }
}
