import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitFlexible extends StatelessWidget {
  final ViewAttribute attributes;
  final Widget child;

  const DuitFlexible({
    required this.child,
    required this.attributes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    return Flexible(
      key: ValueKey(attributes.id),
      flex: attrs.getInt(
        key: "flex",
        defaultValue: 1,
      ),
      fit: attrs.flexFit(
        key: "fit",
        defaultValue: FlexFit.loose,
      )!,
      child: child,
    );
  }
}

class DuitControlledFlexible extends StatefulWidget {
  final Widget child;
  final UIElementController controller;

  const DuitControlledFlexible({
    required this.child,
    required this.controller,
    super.key,
  });

  @override
  State<DuitControlledFlexible> createState() => _DuitControlledFlexibleState();
}

class _DuitControlledFlexibleState extends State<DuitControlledFlexible>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      key: ValueKey(widget.controller.id),
      flex: attributes.getInt(
        key: "flex",
        defaultValue: 1,
      ),
      fit: attributes.flexFit(
        key: "fit",
        defaultValue: FlexFit.loose,
      )!,
      child: widget.child,
    );
  }
}
