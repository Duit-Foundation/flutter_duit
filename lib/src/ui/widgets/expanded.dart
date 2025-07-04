import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitExpanded extends StatelessWidget {
  final ViewAttribute attributes;
  final Widget child;

  const DuitExpanded({
    super.key,
    required this.child,
    required this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      key: Key(attributes.id),
      flex: attributes.payload.getInt(
        key: "flex",
        defaultValue: 1,
      ),
      child: child,
    );
  }
}

class DuitControlledExpanded extends StatefulWidget {
  final Widget child;
  final UIElementController controller;

  const DuitControlledExpanded({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<DuitControlledExpanded> createState() => _DuitControlledExpandedState();
}

class _DuitControlledExpandedState extends State<DuitControlledExpanded>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      key: Key(widget.controller.id),
      flex: attributes.getInt(
        key: "flex",
        defaultValue: 1,
      ),
      child: widget.child,
    );
  }
}
