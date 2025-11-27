import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitOffstage extends StatelessWidget {
  final Widget child;
  final ViewAttribute attributes;

  const DuitOffstage({
    required this.child,
    required this.attributes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    return Offstage(
      key: Key(attributes.id),
      offstage: attrs.getBool(
        "offstage",
        defaultValue: true,
      ),
      child: child,
    );
  }
}

class DuitControlledOffstage extends StatefulWidget {
  final Widget child;
  final UIElementController controller;

  const DuitControlledOffstage({
    required this.child,
    required this.controller,
    super.key,
  });

  @override
  State<DuitControlledOffstage> createState() => _DuitControlledOffstageState();
}

class _DuitControlledOffstageState extends State<DuitControlledOffstage>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Offstage(
      key: Key(widget.controller.id),
      offstage: attributes.getBool(
        "offstage",
        defaultValue: true,
      ),
      child: widget.child,
    );
  }
}
