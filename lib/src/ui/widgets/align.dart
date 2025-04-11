import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";

class DuitAlign extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute<AlignAttributes> attributes;
  final Widget child;

  const DuitAlign({
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

    return Align(
      key: Key(attributes.id),
      alignment: attrs.alignment,
      widthFactor: attrs.widthFactor,
      heightFactor: attrs.heightFactor,
      child: child,
    );
  }
}

class DuitControlledAlign extends StatefulWidget with AnimatedAttributes {
  final UIElementController<AlignAttributes> controller;
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
    with ViewControllerChangeListener<DuitControlledAlign, AlignAttributes> {
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

    return Align(
      key: Key(widget.controller.id),
      alignment: attrs.alignment,
      widthFactor: attrs.widthFactor,
      heightFactor: attrs.heightFactor,
      child: widget.child,
    );
  }
}
