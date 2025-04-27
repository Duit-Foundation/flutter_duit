import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/index.dart';

class DuitSliverPadding extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute<SliverPaddingAttributes> attributes;
  final Widget child;

  const DuitSliverPadding({
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

    return SliverPadding(
      padding: attrs.padding,
      sliver: attrs.needsBoxAdapter ? SliverToBoxAdapter(child: child) : child,
    );
  }
}

class DuitControlledSliverPadding extends StatefulWidget
    with AnimatedAttributes {
  final UIElementController<SliverPaddingAttributes> controller;
  final Widget child;

  const DuitControlledSliverPadding({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitControlledSliverPadding> createState() =>
      _DuitControlledSliverPaddingState();
}

class _DuitControlledSliverPaddingState
    extends State<DuitControlledSliverPadding>
    with
        ViewControllerChangeListener<DuitControlledSliverPadding,
            SliverPaddingAttributes> {
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

    return SliverPadding(
      key: ValueKey(widget.controller.id),
      padding: attrs.padding,
      sliver: attrs.needsBoxAdapter
          ? SliverToBoxAdapter(child: widget.child)
          : widget.child,
    );
  }
}
