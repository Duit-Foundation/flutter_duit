import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/index.dart';

class DuitPhysicalModel extends StatelessWidget with AnimatedAttributes {
  final Widget child;
  final ViewAttribute<PhysicalModelAttributes> attributes;

  const DuitPhysicalModel({
    super.key,
    required this.child,
    required this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithAttributes(context, attributes.payload);
    return PhysicalModel(
      key: Key(attributes.id),
      elevation: attrs.elevation,
      color: attrs.color,
      shadowColor: attrs.shadowColor,
      clipBehavior: attrs.clipBehavior,
      borderRadius: attrs.borderRadius,
      shape: attrs.shape ?? BoxShape.rectangle,
      child: child,
    );
  }
}

class DuitControlledPhysicalModel extends StatefulWidget
    with AnimatedAttributes {
  final Widget child;
  final UIElementController<PhysicalModelAttributes> controller;

  const DuitControlledPhysicalModel({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<DuitControlledPhysicalModel> createState() =>
      _DuitControlledPhysicalModelState();
}

class _DuitControlledPhysicalModelState
    extends State<DuitControlledPhysicalModel>
    with
        ViewControllerChangeListener<DuitControlledPhysicalModel,
            PhysicalModelAttributes> {
  @override
  void initState() {
    attachStateToController(
      widget.controller,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.mergeWithAttributes(
      context,
      attributes,
    );

    return PhysicalModel(
      key: Key(widget.controller.id),
      elevation: attrs.elevation,
      color: attrs.color,
      shadowColor: attrs.shadowColor,
      clipBehavior: attrs.clipBehavior,
      borderRadius: attrs.borderRadius,
      shape: attrs.shape ?? BoxShape.rectangle,
      child: widget.child,
    );
  }
}
