import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitUnconstrainedBox extends StatelessWidget {
  final ViewAttribute attributes;
  final Widget child;

  const DuitUnconstrainedBox({
    required this.attributes,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    return UnconstrainedBox(
      key: Key(attributes.id),
      alignment: attrs.alignment(
        key: "alignment",
        defaultValue: Alignment.center,
      )!,
      constrainedAxis: attrs.axis(
        key: "constrainedAxis",
      ),
      clipBehavior: attrs.clipBehavior(
        key: "clipBehavior",
        defaultValue: Clip.none,
      )!,
      child: child,
    );
  }
}

class DuitControlledUnconstrainedBox extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitControlledUnconstrainedBox({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  State<DuitControlledUnconstrainedBox> createState() =>
      _DuitControlledUnconstrainedBoxState();
}

class _DuitControlledUnconstrainedBoxState
    extends State<DuitControlledUnconstrainedBox>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      key: Key(widget.controller.id),
      alignment: attributes.alignment(
        key: "alignment",
        defaultValue: Alignment.center,
      )!,
      constrainedAxis: attributes.axis(
        key: "constrainedAxis",
      ),
      clipBehavior: attributes.clipBehavior(
        key: "clipBehavior",
        defaultValue: Clip.none,
      )!,
      child: widget.child,
    );
  }
}
