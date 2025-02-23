import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";

class DuitSafeArea extends StatelessWidget with AnimatedAttributes {
  final Widget child;
  final ViewAttribute<SafeAreaAttributes> attributes;

  const DuitSafeArea({
    super.key,
    required this.child,
    required this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithAttributes(context, attributes.payload);
    return SafeArea(
      key: Key(attributes.id),
      top: attrs.top,
      left: attrs.left,
      right: attrs.right,
      bottom: attrs.bottom,
      minimum: attrs.minimum ?? EdgeInsets.zero,
      maintainBottomViewPadding: attrs.maintainBottomViewPadding ?? false,
      child: child,
    );
  }
}

class DuitControlledSafeArea extends StatefulWidget with AnimatedAttributes {
  final Widget child;
  final UIElementController<SafeAreaAttributes> controller;

  const DuitControlledSafeArea({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<DuitControlledSafeArea> createState() => _DuitControlledSafeAreaState();
}

class _DuitControlledSafeAreaState extends State<DuitControlledSafeArea>
    with
        ViewControllerChangeListener<DuitControlledSafeArea,
            SafeAreaAttributes> {
  @override
  void initState() {
    attachStateToController(
      widget.controller,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.mergeWithAttributes(
      context,
      attributes,
    );
    return SafeArea(
      key: Key(widget.controller.id),
      top: attrs.top,
      left: attrs.left,
      right: attrs.right,
      bottom: attrs.bottom,
      minimum: attrs.minimum ?? EdgeInsets.zero,
      child: widget.child,
    );
  }
}
