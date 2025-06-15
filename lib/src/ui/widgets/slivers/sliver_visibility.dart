import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/index.dart';

class DuitSliverVisibility extends StatelessWidget {
  final ViewAttribute<SliverVisibilityAttributes> attributes;
  final Widget child;

  const DuitSliverVisibility({
    super.key,
    required this.attributes,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SliverVisibility(
      key: ValueKey(attributes.id),
      visible: attributes.payload.visible,
      maintainState: attributes.payload.maintainState,
      maintainAnimation: attributes.payload.maintainAnimation,
      maintainSize: attributes.payload.maintainSize,
      maintainSemantics: attributes.payload.maintainSemantics,
      maintainInteractivity: attributes.payload.maintainInteractivity,
      sliver: attributes.payload.needsBoxAdapter
          ? SliverToBoxAdapter(child: child)
          : child,
    );
  }
}

class DuitControlledSliverVisibility extends StatefulWidget {
  final UIElementController<SliverVisibilityAttributes> controller;
  final Widget child;

  const DuitControlledSliverVisibility({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitControlledSliverVisibility> createState() =>
      _DuitControlledSliverVisibilityState();
}

class _DuitControlledSliverVisibilityState
    extends State<DuitControlledSliverVisibility>
    with
        ViewControllerChangeListener<DuitControlledSliverVisibility,
            SliverVisibilityAttributes>,
        OutOfBoundWidgetBuilder {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverVisibility(
      key: ValueKey(widget.controller.id),
      visible: attributes.visible,
      maintainState: attributes.maintainState,
      maintainAnimation: attributes.maintainAnimation,
      maintainSize: attributes.maintainSize,
      maintainSemantics: attributes.maintainSemantics,
      maintainInteractivity: attributes.maintainInteractivity,
      replacementSliver: buildOutOfBoundWidget(
              attributes.replacementSliver, widget.controller.driver, null) ??
          const SliverToBoxAdapter(),
      sliver: attributes.needsBoxAdapter
          ? SliverToBoxAdapter(child: widget.child)
          : widget.child,
    );
  }
}
