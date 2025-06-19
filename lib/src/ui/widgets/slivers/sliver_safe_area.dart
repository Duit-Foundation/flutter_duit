import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/index.dart';

class DuitSliverSafeArea extends StatelessWidget {
  final ViewAttribute<SliverSafeAreaAttributes> attributes;
  final Widget child;

  const DuitSliverSafeArea({
    super.key,
    required this.attributes,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;

    return SliverSafeArea(
      key: Key(attributes.id),
      left: attrs.left,
      top: attrs.top,
      right: attrs.right,
      bottom: attrs.bottom,
      minimum: attrs.minimum ?? EdgeInsets.zero,
      sliver: attrs.needsBoxAdapter ? SliverToBoxAdapter(child: child) : child,
    );
  }
}

class DuitControlledSliverSafeArea extends StatefulWidget {
  final UIElementController<SliverSafeAreaAttributes> controller;
  final Widget child;

  const DuitControlledSliverSafeArea({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitControlledSliverSafeArea> createState() =>
      _DuitControlledSliverSafeAreaState();
}

class _DuitControlledSliverSafeAreaState
    extends State<DuitControlledSliverSafeArea>
    with
        ViewControllerChangeListener<DuitControlledSliverSafeArea,
            SliverSafeAreaAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverSafeArea(
      key: ValueKey(widget.controller.id),
      left: attributes.left,
      top: attributes.top,
      right: attributes.right,
      bottom: attributes.bottom,
      minimum: attributes.minimum ?? EdgeInsets.zero,
      sliver: attributes.needsBoxAdapter
          ? SliverToBoxAdapter(child: widget.child)
          : widget.child,
    );
  }
}
