import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitSizedOverflowBox extends StatelessWidget {
  final ViewAttribute attributes;
  final Widget child;

  const DuitSizedOverflowBox({
    required this.attributes,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    return SizedOverflowBox(
      key: Key(attributes.id),
      size: attrs.size(
        "size",
      ),
      alignment: attrs.alignment(
        key: "alignment",
        defaultValue: Alignment.center,
      )!,
      child: child,
    );
  }
}

class DuitControlledSizedOverflowBox extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitControlledSizedOverflowBox({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  State<DuitControlledSizedOverflowBox> createState() =>
      _DuitControlledSizedOverflowBoxState();
}

class _DuitControlledSizedOverflowBoxState
    extends State<DuitControlledSizedOverflowBox>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedOverflowBox(
      key: Key(widget.controller.id),
      size: attributes.size(
        "size",
      ),
      alignment: attributes.alignment(
        key: "alignment",
        defaultValue: Alignment.center,
      )!,
      child: widget.child,
    );
  }
}
