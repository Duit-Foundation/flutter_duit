import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";

final class DuitBackdropFilter extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute<BackdropFilterAttributes> attributes;
  final Widget child;

  const DuitBackdropFilter({
    super.key,
    required this.attributes,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithAttributes(
      context,
      attributes.payload,
    );

    return BackdropFilter(
      filter: attrs.filter,
      blendMode: attrs.blendMode,
      child: child,
    );
  }
}

class DuitControlledBackdropFilter extends StatefulWidget
    with AnimatedAttributes {
  final UIElementController<BackdropFilterAttributes> controller;
  final Widget child;

  const DuitControlledBackdropFilter({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitControlledBackdropFilter> createState() =>
      __DuitControlledBackdropFilterStateState();
}

class __DuitControlledBackdropFilterStateState
    extends State<DuitControlledBackdropFilter>
    with
        ViewControllerChangeListener<DuitControlledBackdropFilter,
            BackdropFilterAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.mergeWithAttributes(
      context,
      attributes,
    );

    return BackdropFilter(
      filter: attrs.filter,
      blendMode: attrs.blendMode,
      child: widget.child,
    );
  }
}
