import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';

class DuitSliverFillRemaining extends StatelessWidget {
  final ViewAttribute attributes;
  final Widget child;

  const DuitSliverFillRemaining({
    super.key,
    required this.attributes,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      key: ValueKey(attributes.id),
      hasScrollBody:
          attributes.payload.getBool("hasScrollBody", defaultValue: true),
      fillOverscroll: attributes.payload.getBool("fillOverscroll"),
      child: attributes.payload.getBool("needsBoxAdapter")
          ? SliverToBoxAdapter(child: child)
          : child,
    );
  }
}

class DuitControlledSliverFillRemaining extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitControlledSliverFillRemaining({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitControlledSliverFillRemaining> createState() =>
      _DuitControlledSliverFillRemainingState();
}

class _DuitControlledSliverFillRemainingState
    extends State<DuitControlledSliverFillRemaining>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      key: ValueKey(widget.controller.id),
      hasScrollBody: attributes.getBool("hasScrollBody", defaultValue: true),
      fillOverscroll: attributes.getBool("fillOverscroll"),
      child: attributes.getBool("needsBoxAdapter")
          ? SliverToBoxAdapter(child: widget.child)
          : widget.child,
    );
  }
}
