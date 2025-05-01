import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

class DuitColumn extends StatelessWidget {
  final ViewAttribute attributes;
  final List<Widget> children;

  const DuitColumn({
    super.key,
    required this.attributes,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = DuitDataSource(attributes.payload);
    return Column(
      key: Key(attributes.id),
      mainAxisAlignment: attrs.mainAxisAlignment(),
      mainAxisSize: attrs.mainAxisSize(),
      crossAxisAlignment: attrs.crossAxisAlignment(),
      textDirection: attrs.textDirection(),
      verticalDirection: attrs.verticalDirection(),
      children: children,
    );
  }
}

class DuitControlledColumn extends StatefulWidget {
  final UIElementController controller;
  final List<Widget> children;

  const DuitControlledColumn({
    super.key,
    required this.controller,
    required this.children,
  });

  @override
  State<DuitControlledColumn> createState() => _DuitControlledColumnState();
}

class _DuitControlledColumnState extends State<DuitControlledColumn>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: Key(widget.controller.id),
      mainAxisAlignment: attributes.mainAxisAlignment(),
      mainAxisSize: attributes.mainAxisSize(),
      crossAxisAlignment: attributes.crossAxisAlignment(),
      textDirection: attributes.textDirection(),
      verticalDirection: attributes.verticalDirection(),
      children: widget.children,
    );
  }
}
