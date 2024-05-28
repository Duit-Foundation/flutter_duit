import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";

class DuitExpanded extends StatelessWidget {
  final ViewAttribute<ExpandedAttributes> attributes;
  final Widget child;

  const DuitExpanded({
    super.key,
    required this.child,
    required this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    return Expanded(
      key: Key(attributes.id),
      flex: attrs.flex ?? 1,
      child: child,
    );
  }
}

class DuitControlledExpanded extends StatefulWidget {
  final Widget child;
  final UIElementController<ExpandedAttributes> controller;

  const DuitControlledExpanded({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<DuitControlledExpanded> createState() => _DuitControlledExpandedState();
}

class _DuitControlledExpandedState extends State<DuitControlledExpanded>
    with
        ViewControllerChangeListener<DuitControlledExpanded,
            ExpandedAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      key: Key(widget.controller.id),
      flex: attributes.flex ?? 1,
      child: widget.child,
    );
  }
}
