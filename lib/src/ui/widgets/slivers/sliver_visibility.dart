import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';

class DuitSliverVisibility extends StatelessWidget {
  final ViewAttribute attributes;
  final Widget child;

  const DuitSliverVisibility({
    super.key,
    required this.attributes,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    return SliverVisibility(
      key: ValueKey(attributes.id),
      visible: attrs.getBool(
        "visible",
        defaultValue: true,
      ),
      maintainState: attrs.getBool("maintainState"),
      maintainAnimation: attrs.getBool("maintainAnimation"),
      maintainSize: attrs.getBool("maintainSize"),
      maintainSemantics: attrs.getBool("maintainSemantics"),
      maintainInteractivity: attrs.getBool("maintainInteractivity"),
      sliver: attrs.getBool("needsBoxAdapter")
          ? SliverToBoxAdapter(child: child)
          : child,
    );
  }
}

class DuitControlledSliverVisibility extends StatefulWidget {
  final UIElementController controller;
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
        ViewControllerChangeListener,
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
      visible: attributes.getBool("visible"),
      maintainState: attributes.getBool("maintainState"),
      maintainAnimation: attributes.getBool("maintainAnimation"),
      maintainSize: attributes.getBool("maintainSize"),
      maintainSemantics: attributes.getBool("maintainSemantics"),
      maintainInteractivity: attributes.getBool("maintainInteractivity"),
      replacementSliver: buildOutOfBoundWidget(
            attributes["replacementSliver"],
            widget.controller.driver,
            null,
          ) ??
          const SliverToBoxAdapter(),
      sliver: attributes.getBool("needsBoxAdapter")
          ? SliverToBoxAdapter(child: widget.child)
          : widget.child,
    );
  }
}
