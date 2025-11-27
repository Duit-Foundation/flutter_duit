import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitSliverPadding extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;
  final Widget child;

  const DuitSliverPadding({
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

    return SliverPadding(
      key: Key(attributes.id),
      padding: attrs.edgeInsets(defaultValue: EdgeInsets.zero)!,
      sliver: attrs.getBool("needsBoxAdapter")
          ? SliverToBoxAdapter(child: child)
          : child,
    );
  }
}

class DuitControlledSliverPadding extends StatefulWidget
    with AnimatedAttributes {
  final UIElementController controller;
  final Widget child;

  const DuitControlledSliverPadding({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  State<DuitControlledSliverPadding> createState() =>
      _DuitControlledSliverPaddingState();
}

class _DuitControlledSliverPaddingState
    extends State<DuitControlledSliverPadding>
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

    return SliverPadding(
      key: ValueKey(widget.controller.id),
      padding: attrs.edgeInsets(defaultValue: EdgeInsets.zero)!,
      sliver: attrs.getBool("needsBoxAdapter")
          ? SliverToBoxAdapter(child: widget.child)
          : widget.child,
    );
  }
}
