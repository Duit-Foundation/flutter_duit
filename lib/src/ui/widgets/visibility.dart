import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitVisibility extends StatelessWidget {
  final ViewAttribute attributes;
  final List<Widget?> children;

  const DuitVisibility({
    required this.attributes,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    final child = children.elementAtOrNull(0);
    assert(child != null, "Visibility widget must have a child");

    final replacement = children.elementAtOrNull(1) ?? const SizedBox.shrink();

    return Visibility(
      key: ValueKey(attributes.id),
      visible: attrs.getBool(
        "visible",
        defaultValue: true,
      ),
      maintainState: attrs.getBool("maintainState"),
      maintainAnimation: attrs.getBool("maintainAnimation"),
      maintainSize: attrs.getBool("maintainSize"),
      maintainSemantics: attrs.getBool("maintainSemantics"),
      maintainInteractivity: attrs.getBool("maintainInteractivity"),
      replacement: replacement,
      child: child!,
    );
  }
}

class DuitControlledVisibility extends StatefulWidget {
  final UIElementController controller;
  final List<Widget?> children;

  const DuitControlledVisibility({
    required this.controller,
    required this.children,
    super.key,
  });

  @override
  State<DuitControlledVisibility> createState() =>
      _DuitControlledVisibilityState();
}

class _DuitControlledVisibilityState extends State<DuitControlledVisibility>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final child = widget.children.elementAtOrNull(0);
    assert(child != null, "Visibility widget must have a child");

    final replacement =
        widget.children.elementAtOrNull(1) ?? const SizedBox.shrink();

    return Visibility(
      key: ValueKey(widget.controller.id),
      visible: attributes.getBool(
        "visible",
        defaultValue: true,
      ),
      maintainState: attributes.getBool("maintainState"),
      maintainAnimation: attributes.getBool("maintainAnimation"),
      maintainSize: attributes.getBool("maintainSize"),
      maintainSemantics: attributes.getBool("maintainSemantics"),
      maintainInteractivity: attributes.getBool("maintainInteractivity"),
      replacement: replacement,
      child: child!,
    );
  }
}
