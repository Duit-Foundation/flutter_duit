import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitClipRect extends StatelessWidget {
  final ViewAttribute attributes;
  final Widget child;

  const DuitClipRect({
    required this.attributes,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    return ClipRect(
      key: ValueKey(attributes.id),
      clipBehavior: attrs.clipBehavior(
        defaultValue: Clip.hardEdge,
      )!,
      child: child,
    );
  }
}

class DuitControlledClipRect extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitControlledClipRect({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  State<DuitControlledClipRect> createState() => _DuitControlledClipRectState();
}

class _DuitControlledClipRectState extends State<DuitControlledClipRect>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      key: ValueKey(widget.controller.id),
      clipBehavior: attributes.clipBehavior(
        defaultValue: Clip.hardEdge,
      )!,
      child: widget.child,
    );
  }
}
