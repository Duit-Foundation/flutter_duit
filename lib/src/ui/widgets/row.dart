import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

class DuitRow extends StatelessWidget {
  final ViewAttribute attributes;
  final List<Widget> children;

  const DuitRow({
    required this.attributes,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    return Row(
      key: Key(attributes.id),
      mainAxisAlignment: attrs.mainAxisAlignment(
        defaultValue: MainAxisAlignment.start,
      )!,
      mainAxisSize: attrs.mainAxisSize(defaultValue: MainAxisSize.max)!,
      crossAxisAlignment: attrs.crossAxisAlignment(
        defaultValue: CrossAxisAlignment.center,
      )!,
      textDirection: attrs.textDirection(),
      verticalDirection: attrs.verticalDirection(
        defaultValue: VerticalDirection.down,
      ),
      textBaseline: attrs.textBaseline(),
      children: children,
    );
  }
}

class DuitControlledRow extends StatefulWidget {
  final UIElementController controller;
  final List<Widget> children;

  const DuitControlledRow({
    required this.controller,
    required this.children,
    super.key,
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
      mainAxisAlignment: attributes.mainAxisAlignment(
        defaultValue: MainAxisAlignment.start,
      )!,
      mainAxisSize: attributes.mainAxisSize(defaultValue: MainAxisSize.max)!,
      crossAxisAlignment: attributes.crossAxisAlignment(
        defaultValue: CrossAxisAlignment.center,
      )!,
      textDirection: attributes.textDirection(),
      verticalDirection: attributes.verticalDirection(
        defaultValue: VerticalDirection.down,
      ),
      textBaseline: attributes.textBaseline(),
      children: widget.children,
    );
  }
}
