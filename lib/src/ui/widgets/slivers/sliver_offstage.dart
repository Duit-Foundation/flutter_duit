import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/index.dart';

class DuitSliverOffstage extends StatelessWidget {
  final ViewAttribute<SliverOffstageAttributes> attributes;
  final Widget child;

  const DuitSliverOffstage({
    super.key,
    required this.attributes,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SliverOffstage(
      key: ValueKey(attributes.id),
      offstage: attributes.payload.offstage,
      sliver: attributes.payload.needsBoxAdapter
          ? SliverToBoxAdapter(child: child)
          : child,
    );
  }
}

class DuitControlledSliverOffstage extends StatefulWidget {
  final UIElementController<SliverOffstageAttributes> controller;
  final Widget child;

  const DuitControlledSliverOffstage({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitControlledSliverOffstage> createState() =>
      _DuitControlledSliverOffstageState();
}

class _DuitControlledSliverOffstageState
    extends State<DuitControlledSliverOffstage>
    with
        ViewControllerChangeListener<DuitControlledSliverOffstage,
            SliverOffstageAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverOffstage(
      key: ValueKey(widget.controller.id),
      offstage: attributes.offstage,
      sliver: attributes.needsBoxAdapter
          ? SliverToBoxAdapter(child: widget.child)
          : widget.child,
    );
  }
}
