import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';

class DuitSliverOpacity extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;
  final Widget child;

  const DuitSliverOpacity({
    super.key,
    required this.attributes,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithDataSource(context, attributes.payload);
    return SliverOpacity(
      key: ValueKey(attributes.id),
      opacity: attrs.getDouble(key: "opacity", defaultValue: 1.0),
      sliver: attrs.getBool("needsBoxAdapter")
          ? SliverToBoxAdapter(child: child)
          : child,
    );
  }
}

class DuitControlledSliverOpacity extends StatefulWidget
    with AnimatedAttributes {
  final UIElementController controller;
  final Widget child;

  const DuitControlledSliverOpacity({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitControlledSliverOpacity> createState() =>
      _DuitControlledSliverOpacityState();
}

class _DuitControlledSliverOpacityState
    extends State<DuitControlledSliverOpacity>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.mergeWithDataSource(context, attributes);
    return SliverOpacity(
      key: ValueKey(widget.controller.id),
      opacity: attrs.getDouble(key: "opacity", defaultValue: 1.0),
      sliver: attrs.getBool("needsBoxAdapter")
          ? SliverToBoxAdapter(child: widget.child)
          : widget.child,
    );
  }
}
