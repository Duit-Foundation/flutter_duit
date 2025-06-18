import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/index.dart';

class DuitSliverIgnorePointer extends StatelessWidget {
  final ViewAttribute<SliverIgnorePointerAttributes> attributes;
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
      ignoring: attrs.ignoring,
      sliver: attrs.needsBoxAdapter ? SliverToBoxAdapter(child: child) : child,
    );
  }
}

class DuitControlledSliverIgnorePointer extends StatefulWidget {
  final UIElementController<SliverIgnorePointerAttributes> controller;
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
    with
        ViewControllerChangeListener<DuitControlledSliverIgnorePointer,
            SliverIgnorePointerAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = attributes;
    return SliverIgnorePointer(
      key: ValueKey(widget.controller.id),
      ignoring: attrs.ignoring,
      sliver: attrs.needsBoxAdapter
          ? SliverToBoxAdapter(child: widget.child)
          : widget.child,
    );
  }
}
