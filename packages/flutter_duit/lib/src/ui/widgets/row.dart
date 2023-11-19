import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/controller/index.dart";
import "package:flutter_duit/src/utils/state_mapper.dart";

class DUITRow extends StatelessWidget {
  final ViewAttributeWrapper? attributes;
  final List<Widget> children;

  const DUITRow({
    super.key,
    required this.attributes,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final state = attributes?.payload as RowAttributes?;
    return Row(
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

class DUITControlledRow extends StatefulWidget {
  final UIElementController? controller;
  final List<Widget> children;

  const DUITControlledRow({
    super.key,
    required this.controller,
    required this.children,
  });

  @override
  State<DUITControlledRow> createState() => _DUITControlledRowState();
}

class _DUITControlledRowState extends State<DUITControlledRow>
    with StateMapper<DUITControlledRow, RowAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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