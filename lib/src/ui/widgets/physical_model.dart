import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitPhysicalModel extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;
  final Widget child;

  const DuitPhysicalModel({
    required this.child,
    required this.attributes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithDataSource(context, attributes.payload);
    return PhysicalModel(
      key: Key(attributes.id),
      elevation: attrs.getDouble(key: "elevation"),
      color: attrs.parseColor(),
      shadowColor: attrs.parseColor(
        key: "shadowColor",
        defaultValue: const Color(0xFF000000),
      ),
      clipBehavior: attrs.clipBehavior(defaultValue: Clip.none)!,
      borderRadius: attrs.borderRadius(),
      shape: attrs.boxShape(defaultValue: BoxShape.rectangle)!,
      child: child,
    );
  }
}

class DuitControlledPhysicalModel extends StatefulWidget
    with AnimatedAttributes {
  final UIElementController controller;
  final Widget child;

  const DuitControlledPhysicalModel({
    required this.child,
    required this.controller,
    super.key,
  });

  @override
  State<DuitControlledPhysicalModel> createState() =>
      _DuitControlledPhysicalModelState();
}

class _DuitControlledPhysicalModelState
    extends State<DuitControlledPhysicalModel>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(
      widget.controller,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.mergeWithDataSource(
      context,
      attributes,
    );

    return PhysicalModel(
      key: Key(widget.controller.id),
      elevation: attrs.getDouble(key: "elevation"),
      color: attrs.parseColor(),
      shadowColor: attrs.parseColor(
        key: "shadowColor",
        defaultValue: const Color(0xFF000000),
      ),
      clipBehavior: attrs.clipBehavior(defaultValue: Clip.none)!,
      borderRadius: attrs.borderRadius(),
      shape: attrs.boxShape(defaultValue: BoxShape.rectangle)!,
      child: widget.child,
    );
  }
}
