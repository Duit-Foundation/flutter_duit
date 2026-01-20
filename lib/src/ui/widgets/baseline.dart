import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitBaseline extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;
  final Widget child;

  const DuitBaseline({
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
    return Baseline(
      key: Key(attributes.id),
      baseline: attrs.getDouble(
        key: "baseline",
        defaultValue: 1.0,
      ),
      baselineType: attrs.textBaseline(
        key: "baselineType",
        defaultValue: TextBaseline.alphabetic,
      )!,
      child: child,
    );
  }
}

class DuitControlledBaseline extends StatefulWidget with AnimatedAttributes {
  final UIElementController controller;
  final Widget child;

  const DuitControlledBaseline({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  State<DuitControlledBaseline> createState() => _DuitControlledBaselineState();
}

class _DuitControlledBaselineState extends State<DuitControlledBaseline>
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
    return Baseline(
      key: Key(widget.controller.id),
      baseline: attrs.getDouble(
        key: "baseline",
        defaultValue: 1.0,
      ),
      baselineType: attrs.textBaseline(
        key: "baselineType",
        defaultValue: TextBaseline.alphabetic,
      )!,
      child: widget.child,
    );
  }
}
