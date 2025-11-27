import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

/// Виджет Card в не контроллируемом варианте
class DuitCard extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;
  final Widget child;

  const DuitCard({
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
    return Card(
      key: Key(attributes.id),
      color: attrs.tryParseColor(key: "color"),
      shadowColor: attrs.tryParseColor(key: "shadowColor"),
      elevation: attrs.tryGetDouble(key: "elevation"),
      shape: attrs.shapeBorder(),
      borderOnForeground: attrs.getBool(
        "borderOnForeground",
        defaultValue: true,
      ),
      margin: attrs.edgeInsets(
        key: "margin",
      ),
      clipBehavior: attrs.clipBehavior(),
      semanticContainer: attrs.getBool(
        "semanticContainer",
        defaultValue: true,
      ),
      child: child,
    );
  }
}

class DuitControlledCard extends StatefulWidget with AnimatedAttributes {
  final UIElementController controller;
  final Widget child;

  const DuitControlledCard({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  State<DuitControlledCard> createState() => _DuitControlledCardState();
}

class _DuitControlledCardState extends State<DuitControlledCard>
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
    return Card(
      key: Key(widget.controller.id),
      color: attrs.tryParseColor(key: "color"),
      shadowColor: attrs.tryParseColor(key: "shadowColor"),
      elevation: attrs.tryGetDouble(key: "elevation"),
      shape: attrs.shapeBorder(),
      borderOnForeground: attrs.getBool(
        "borderOnForeground",
        defaultValue: true,
      ),
      margin: attrs.edgeInsets(
        key: "margin",
      ),
      clipBehavior: attrs.clipBehavior(),
      semanticContainer: attrs.getBool(
        "semanticContainer",
        defaultValue: true,
      ),
      child: widget.child,
    );
  }
}
