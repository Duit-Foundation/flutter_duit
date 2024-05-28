import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

class DuitColumn extends StatelessWidget {
  final ViewAttribute<ColumnAttributes> attributes;
  final List<Widget> children;

  const DuitColumn({
    super.key,
    required this.attributes,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      key: Key(attributes.id),
      mainAxisAlignment:
          attributes.payload.mainAxisAlignment ?? MainAxisAlignment.start,
      mainAxisSize: attributes.payload.mainAxisSize ?? MainAxisSize.max,
      crossAxisAlignment:
          attributes.payload.crossAxisAlignment ?? CrossAxisAlignment.center,
      textDirection: attributes.payload.textDirection,
      verticalDirection:
          attributes.payload.verticalDirection ?? VerticalDirection.down,
      children: children,
    );
  }
}

class DuitControlledColumn extends StatefulWidget {
  final UIElementController<ColumnAttributes> controller;
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
    with ViewControllerChangeListener<DuitControlledColumn, ColumnAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
