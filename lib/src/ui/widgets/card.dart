import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/index.dart';

/// Виджет Card в не контроллируемом варианте
class DuitCard extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute<CardAttributes> attributes;
  final Widget child;

  const DuitCard({
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
    return Card(
      key: Key(attributes.id),
      color: attrs.color,
      shadowColor: attrs.shadowColor,
      elevation: attrs.elevation,
      shape: attrs.shape,
      borderOnForeground: attrs.borderOnForeground,
      margin: attrs.margin,
      clipBehavior: attrs.clipBehavior,
      semanticContainer: attrs.semanticContainer,
      child: child,
    );
  }
}

class DuitControlledCard extends StatefulWidget with AnimatedAttributes {
  final UIElementController<CardAttributes> controller;
  final Widget child;

  const DuitControlledCard({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitControlledCard> createState() => _DuitControlledCardState();
}

class _DuitControlledCardState extends State<DuitControlledCard>
    with ViewControllerChangeListener<DuitControlledCard, CardAttributes> {
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
    return Card(
      key: Key(widget.controller.id),
      color: attrs.color,
      shadowColor: attrs.shadowColor,
      elevation: attrs.elevation,
      shape: attrs.shape,
      borderOnForeground: attrs.borderOnForeground,
      margin: attrs.margin,
      clipBehavior: attrs.clipBehavior,
      semanticContainer: attrs.semanticContainer,
      child: widget.child,
    );
  }
}
