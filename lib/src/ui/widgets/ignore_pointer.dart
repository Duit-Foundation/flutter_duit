import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";

class DuitIgnorePointer extends StatelessWidget {
  final ViewAttribute attributes;
  final Widget child;

  const DuitIgnorePointer({
    super.key,
    required this.attributes,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = DuitDataSource(attributes.payload);
    return IgnorePointer(
      key: Key(attributes.id),
      ignoring: attrs.getBool("ignoring", defaultValue: true),
      child: child,
    );
  }
}

class DuitControlledIgnorePointer extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitControlledIgnorePointer({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitControlledIgnorePointer> createState() =>
      _DuitControlledIgnorePointerState();
}

class _DuitControlledIgnorePointerState
    extends State<DuitControlledIgnorePointer>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      key: Key(widget.controller.id),
      ignoring: attributes.getBool("ignoring", defaultValue: true),
      child: widget.child,
    );
  }
}
