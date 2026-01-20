import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitFractionallySizedBox extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;
  final Widget child;

  const DuitFractionallySizedBox({
    required this.attributes,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithDataSource(
      context,
      attributes.payload,
    );
    return FractionallySizedBox(
      key: Key(attributes.id),
      widthFactor: attrs.tryGetDouble(
        key: "widthFactor",
      ),
      heightFactor: attrs.tryGetDouble(
        key: "heightFactor",
      ),
      alignment: attrs.alignment(
        key: "alignment",
        defaultValue: Alignment.center,
      )!,
      child: child,
    );
  }
}

class DuitControlledFractionallySizedBox extends StatefulWidget
    with AnimatedAttributes {
  final UIElementController controller;
  final Widget child;

  const DuitControlledFractionallySizedBox({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  State<DuitControlledFractionallySizedBox> createState() =>
      _DuitControlledFractionallySizedBoxState();
}

class _DuitControlledFractionallySizedBoxState
    extends State<DuitControlledFractionallySizedBox>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.mergeWithDataSource(
      context,
      attributes,
    );
    return FractionallySizedBox(
      key: Key(widget.controller.id),
      widthFactor: attrs.tryGetDouble(
        key: "widthFactor",
      ),
      heightFactor: attrs.tryGetDouble(
        key: "heightFactor",
      ),
      alignment: attrs.alignment(
        key: "alignment",
        defaultValue: Alignment.center,
      )!,
      child: widget.child,
    );
  }
}
