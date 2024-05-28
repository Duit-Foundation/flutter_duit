import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import 'package:flutter_duit/src/duit_impl/index.dart';

class DuitRow extends StatelessWidget {
  final ViewAttribute<RowAttributes> attributes;
  final List<Widget> children;

  const DuitRow({
    super.key,
    required this.attributes,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final state = attributes.payload;
    return Row(
      key: Key(attributes.id),
      mainAxisAlignment: state.mainAxisAlignment ?? MainAxisAlignment.start,
      mainAxisSize: state.mainAxisSize ?? MainAxisSize.max,
      crossAxisAlignment: state.crossAxisAlignment ?? CrossAxisAlignment.center,
      textDirection: state.textDirection,
      verticalDirection: state.verticalDirection ?? VerticalDirection.down,
      children: children,
    );
  }
}

class DuitControlledRow extends StatefulWidget {
  final UIElementController<RowAttributes> controller;
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
    with ViewControllerChangeListener<DuitControlledRow, RowAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      key: Key(widget.controller.id),
      mainAxisAlignment:
          attributes.mainAxisAlignment ?? MainAxisAlignment.start,
      mainAxisSize: attributes.mainAxisSize ?? MainAxisSize.max,
      crossAxisAlignment:
          attributes.crossAxisAlignment ?? CrossAxisAlignment.center,
      textDirection: attributes.textDirection,
      verticalDirection: attributes.verticalDirection ?? VerticalDirection.down,
      children: widget.children,
    );
  }
}
