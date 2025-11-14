import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitClipOval extends StatelessWidget {
  final ViewAttribute attributes;
  final Widget child;

  const DuitClipOval({
    required this.attributes,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    return ClipOval(
      key: ValueKey(attributes.id),
      clipBehavior: attrs.clipBehavior(defaultValue: Clip.antiAlias)!,
      child: child,
    );
  }
}

class DuitControlledClipOval extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitControlledClipOval({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  State<DuitControlledClipOval> createState() => _DuitControlledClipOvalState();
}

class _DuitControlledClipOvalState extends State<DuitControlledClipOval>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      key: ValueKey(widget.controller.id),
      clipBehavior: attributes.clipBehavior(defaultValue: Clip.antiAlias)!,
      child: widget.child,
    );
  }
}
