import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import 'package:flutter_duit/src/duit_impl/index.dart';

class DuitRow extends StatelessWidget {
  final ViewAttribute attributes;
  final List<Widget> children;

  const DuitRow({
    super.key,
    required this.attributes,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = DuitDataSource(attributes.payload);
    return Row(
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

class DuitControlledRow extends StatefulWidget {
  final UIElementController controller;
  final List<Widget> children;

  const DuitControlledRow({
    super.key,
    required this.controller,
    required this.children,
  });

  @override
  State<DuitControlledRow> createState() => _DuitControlledRowState();
}

class _DuitControlledRowState extends State<DuitControlledRow>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
