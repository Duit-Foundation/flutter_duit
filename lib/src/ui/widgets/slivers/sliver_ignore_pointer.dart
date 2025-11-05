import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';

class DuitSliverIgnorePointer extends StatelessWidget {
  final ViewAttribute attributes;
  final Widget child;

  const DuitSliverIgnorePointer({
    super.key,
    required this.attributes,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    return SliverIgnorePointer(
      key: ValueKey(attributes.id),
      ignoring: attrs.getBool(
        "ignoring",
        defaultValue: true,
      ),
      sliver: attrs.getBool("needsBoxAdapter")
          ? SliverToBoxAdapter(child: child)
          : child,
    );
  }
}

class DuitControlledSliverIgnorePointer extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitControlledSliverIgnorePointer({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitControlledSliverIgnorePointer> createState() =>
      _DuitControlledSliverIgnorePointerState();
}

class _DuitControlledSliverIgnorePointerState
    extends State<DuitControlledSliverIgnorePointer>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverIgnorePointer(
      key: ValueKey(widget.controller.id),
      ignoring: attributes.getBool(
        "ignoring",
        defaultValue: true,
      ),
      sliver: attributes.getBool("needsBoxAdapter")
          ? SliverToBoxAdapter(child: widget.child)
          : widget.child,
    );
  }
}
