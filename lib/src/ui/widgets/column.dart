import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

class DuitColumn extends StatelessWidget {
  final ViewAttributeWrapper? attributes;
  final List<Widget> children;

  const DuitColumn({
    super.key,
    required this.attributes,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final state = attributes?.payload as ColumnAttributes?;
    return Column(
      mainAxisAlignment: state?.mainAxisAlignment ?? MainAxisAlignment.start,
      mainAxisSize: state?.mainAxisSize ?? MainAxisSize.max,
      crossAxisAlignment:
          state?.crossAxisAlignment ?? CrossAxisAlignment.center,
      textDirection: state?.textDirection,
      verticalDirection: state?.verticalDirection ?? VerticalDirection.down,
      children: children,
    );
  }
}

class DuitControlledColumn extends StatefulWidget {
  final UIElementController? controller;
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
      mainAxisAlignment:
          attributes?.mainAxisAlignment ?? MainAxisAlignment.start,
      mainAxisSize: attributes?.mainAxisSize ?? MainAxisSize.max,
      crossAxisAlignment:
          attributes?.crossAxisAlignment ?? CrossAxisAlignment.center,
      textDirection: attributes?.textDirection,
      verticalDirection:
          attributes?.verticalDirection ?? VerticalDirection.down,
      children: widget.children,
    );
  }
}
