import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitSafeArea extends StatelessWidget with AnimatedAttributes {
  final Widget child;
  final ViewAttribute attributes;

  const DuitSafeArea({
    super.key,
    required this.child,
    required this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithDataSource(context, attributes.payload);
    return SafeArea(
      key: Key(attributes.id),
      top: attrs.getBool("top", defaultValue: true),
      left: attrs.getBool("left", defaultValue: true),
      right: attrs.getBool("right", defaultValue: true),
      bottom: attrs.getBool("bottom", defaultValue: true),
      minimum: attrs.edgeInsets(
        key: "minimum",
        defaultValue: EdgeInsets.zero,
      )!,
      maintainBottomViewPadding: attrs.getBool("maintainBottomViewPadding"),
      child: child,
    );
  }
}

class DuitControlledSafeArea extends StatefulWidget with AnimatedAttributes {
  final Widget child;
  final UIElementController controller;

  const DuitControlledSafeArea({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<DuitControlledSafeArea> createState() => _DuitControlledSafeAreaState();
}

class _DuitControlledSafeAreaState extends State<DuitControlledSafeArea>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(
      widget.controller,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.mergeWithDataSource(
      context,
      attributes,
    );
    return SafeArea(
      key: Key(widget.controller.id),
      top: attrs.getBool("top", defaultValue: true),
      left: attrs.getBool("left", defaultValue: true),
      right: attrs.getBool("right", defaultValue: true),
      bottom: attrs.getBool("bottom", defaultValue: true),
      minimum: attrs.edgeInsets(
        key: "minimum",
        defaultValue: EdgeInsets.zero,
      )!,
      maintainBottomViewPadding: attrs.getBool("maintainBottomViewPadding"),
      child: widget.child,
    );
  }
}
