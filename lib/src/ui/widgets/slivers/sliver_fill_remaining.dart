import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/index.dart';

class DuitSliverFillRemaining extends StatelessWidget {
  final ViewAttribute<SliverFillRemainingAttributes> attributes;
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
      hasScrollBody: attributes.payload.hasScrollBody,
      fillOverscroll: attributes.payload.fillOverscroll,
      child: attributes.payload.needsBoxAdapter
          ? SliverToBoxAdapter(child: child)
          : child,
    );
  }
}

class DuitControlledSliverFillRemaining extends StatefulWidget {
  final UIElementController<SliverFillRemainingAttributes> controller;
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
    with
        ViewControllerChangeListener<DuitControlledSliverFillRemaining,
            SliverFillRemainingAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      key: ValueKey(widget.controller.id),
      hasScrollBody: attributes.hasScrollBody,
      fillOverscroll: attributes.fillOverscroll,
      child: attributes.needsBoxAdapter
          ? SliverToBoxAdapter(child: widget.child)
          : widget.child,
    );
  }
}
