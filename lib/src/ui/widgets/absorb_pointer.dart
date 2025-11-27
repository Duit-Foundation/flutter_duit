import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitAbsorbPointer extends StatelessWidget {
  final Widget child;
  final ViewAttribute attributes;

  const DuitAbsorbPointer({
    required this.child,
    required this.attributes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    return AbsorbPointer(
      key: Key(attributes.id),
      absorbing: attrs.getBool("absorbing"),
      child: child,
    );
  }
}

class DuitControlledAbsorbPointer extends StatefulWidget {
  final Widget child;
  final UIElementController controller;

  const DuitControlledAbsorbPointer({
    required this.child,
    required this.controller,
    super.key,
  });

  @override
  State<DuitControlledAbsorbPointer> createState() =>
      _DuitControlledAbsorbPointerState();
}

class _DuitControlledAbsorbPointerState
    extends State<DuitControlledAbsorbPointer>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      key: Key(widget.controller.id),
      absorbing: attributes.getBool("absorbing"),
      child: widget.child,
    );
  }
}
