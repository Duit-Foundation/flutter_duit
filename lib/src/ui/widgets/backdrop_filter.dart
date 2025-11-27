import "dart:ui";

import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

final class DuitBackdropFilter extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;
  final Widget child;

  const DuitBackdropFilter({
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

    return BackdropFilter(
      key: ValueKey(attributes.id),
      filter: attrs.imageFilter(
        defaultValue: ImageFilter.blur(),
      )!,
      blendMode: attrs.blendMode(defaultValue: BlendMode.srcOver),
      child: child,
    );
  }
}

class DuitControlledBackdropFilter extends StatefulWidget
    with AnimatedAttributes {
  final UIElementController controller;
  final Widget child;

  const DuitControlledBackdropFilter({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  State<DuitControlledBackdropFilter> createState() =>
      __DuitControlledBackdropFilterStateState();
}

class __DuitControlledBackdropFilterStateState
    extends State<DuitControlledBackdropFilter>
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

    return BackdropFilter(
      key: ValueKey(widget.controller.id),
      filter: attrs.imageFilter(
        defaultValue: ImageFilter.blur(),
      )!,
      blendMode: attrs.blendMode(defaultValue: BlendMode.srcOver),
      child: widget.child,
    );
  }
}
