import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitExcludeSemantics extends StatelessWidget {
  final ViewAttribute attributes;
  final Widget child;

  const DuitExcludeSemantics({
    required this.attributes,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      key: ValueKey(attributes.id),
      excluding: attributes.payload.getBool(
        "excluding",
        defaultValue: true,
      ),
      child: child,
    );
  }
}

class DuitControlledExcludeSemantics extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitControlledExcludeSemantics({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  State<DuitControlledExcludeSemantics> createState() =>
      _DuitControlledExcludeSemanticsState();
}

class _DuitControlledExcludeSemanticsState
    extends State<DuitControlledExcludeSemantics>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      key: ValueKey(widget.controller.id),
      excluding: attributes.getBool(
        "excluding",
        defaultValue: true,
      ),
      child: widget.child,
    );
  }
}
