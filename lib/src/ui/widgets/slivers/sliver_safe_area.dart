import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';

class DuitSliverSafeArea extends StatelessWidget {
  final ViewAttribute attributes;
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
      left: attrs.getBool("left", defaultValue: true),
      top: attrs.getBool("top", defaultValue: true),
      right: attrs.getBool("right", defaultValue: true),
      bottom: attrs.getBool("bottom", defaultValue: true),
      minimum: attrs.edgeInsets(defaultValue: EdgeInsets.zero)!,
      sliver: attrs.getBool("needsBoxAdapter")
          ? SliverToBoxAdapter(child: child)
          : child,
    );
  }
}

class DuitControlledSliverSafeArea extends StatefulWidget {
  final UIElementController controller;
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
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverSafeArea(
      key: ValueKey(widget.controller.id),
      left: attributes.getBool("left", defaultValue: true),
      top: attributes.getBool("top", defaultValue: true),
      right: attributes.getBool("right", defaultValue: true),
      bottom: attributes.getBool("bottom", defaultValue: true),
      minimum: attributes.edgeInsets(defaultValue: EdgeInsets.zero)!,
      sliver: attributes.getBool("needsBoxAdapter")
          ? SliverToBoxAdapter(child: widget.child)
          : widget.child,
    );
  }
}
