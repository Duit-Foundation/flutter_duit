import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";

class DUITExpanded extends StatelessWidget {
  final ViewAttributeWrapper? attributes;
  final Widget child;

  const DUITExpanded({
    super.key,
    required this.child,
    required this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes?.payload as ExpandedAttributes?;
    return Expanded(
      flex: attrs?.flex ?? 1,
      child: child,
    );
  }
}

class DUITControlledExpanded extends StatefulWidget {
  final Widget child;
  final UIElementController controller;

  const DUITControlledExpanded({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<DUITControlledExpanded> createState() => _DUITControlledExpandedState();
}

class _DUITControlledExpandedState extends State<DUITControlledExpanded>
    with
        ViewControllerChangeListener<DUITControlledExpanded,
            ExpandedAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: attributes?.flex ?? 1,
      child: widget.child,
    );
  }
}
