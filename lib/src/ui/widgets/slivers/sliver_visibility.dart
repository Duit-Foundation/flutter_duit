import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';

class DuitSliverVisibility extends StatelessWidget {
  final ViewAttribute attributes;
  final List<Widget> children;

  const DuitSliverVisibility({
    super.key,
    required this.attributes,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    final [sliver, replacementSliver] = children;
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
      replacementSliver: replacementSliver,
      sliver: attrs.getBool("needsBoxAdapter")
          ? SliverToBoxAdapter(child: sliver)
          : sliver,
    );
  }
}

class DuitControlledSliverVisibility extends StatefulWidget {
  final UIElementController controller;
  final List<Widget> children;

  const DuitControlledSliverVisibility({
    super.key,
    required this.controller,
    required this.children,
  });

  @override
  State<DuitControlledSliverVisibility> createState() =>
      _DuitControlledSliverVisibilityState();
}

class _DuitControlledSliverVisibilityState
    extends State<DuitControlledSliverVisibility>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final [sliver, replacementSliver] = widget.children;
    return SliverVisibility(
      key: ValueKey(widget.controller.id),
      visible: attributes.getBool("visible"),
      maintainState: attributes.getBool("maintainState"),
      maintainAnimation: attributes.getBool("maintainAnimation"),
      maintainSize: attributes.getBool("maintainSize"),
      maintainSemantics: attributes.getBool("maintainSemantics"),
      maintainInteractivity: attributes.getBool("maintainInteractivity"),
      replacementSliver: replacementSliver,
      sliver: attributes.getBool("needsBoxAdapter")
          ? SliverToBoxAdapter(child: sliver)
          : sliver,
    );
  }
}
