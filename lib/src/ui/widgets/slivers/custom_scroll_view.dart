import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/index.dart';

class DuitCustomScrollView extends StatelessWidget {
  final ViewAttribute<CustomScrollViewAttributes> attributes;
  final List<Widget> children;

  const DuitCustomScrollView({
    super.key,
    required this.attributes,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    return CustomScrollView(
      key: ValueKey(attributes.id),
      scrollDirection: attrs.scrollDirection,
      reverse: attrs.reverse,
      primary: attrs.primary,
      physics: attrs.physics,
      shrinkWrap: attrs.shrinkWrap,
      center: attrs.center,
      anchor: attrs.anchor,
      cacheExtent: attrs.cacheExtent,
      semanticChildCount: attrs.semanticChildCount,
      dragStartBehavior: attrs.dragStartBehavior,
      keyboardDismissBehavior: attrs.keyboardDismissBehavior,
      clipBehavior: attrs.clipBehavior,
      hitTestBehavior: attrs.hitTestBehavior,
      slivers: children,
    );
  }
}

class DuitControlledCustomScrollView extends StatefulWidget {
  final UIElementController<CustomScrollViewAttributes> controller;
  final List<Widget> children;

  const DuitControlledCustomScrollView({
    super.key,
    required this.controller,
    required this.children,
  });

  @override
  State<DuitControlledCustomScrollView> createState() =>
      _DuitControlledCustomScrollViewState();
}

class _DuitControlledCustomScrollViewState
    extends State<DuitControlledCustomScrollView>
    with
        ViewControllerChangeListener<DuitControlledCustomScrollView,
            CustomScrollViewAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: ValueKey(widget.controller.id),
      scrollDirection: attributes.scrollDirection,
      reverse: attributes.reverse,
      primary: attributes.primary,
      physics: attributes.physics,
      shrinkWrap: attributes.shrinkWrap,
      center: attributes.center,
      anchor: attributes.anchor,
      cacheExtent: attributes.cacheExtent,
      semanticChildCount: attributes.semanticChildCount,
      dragStartBehavior: attributes.dragStartBehavior,
      keyboardDismissBehavior: attributes.keyboardDismissBehavior,
      clipBehavior: attributes.clipBehavior,
      hitTestBehavior: attributes.hitTestBehavior,
      slivers: widget.children,
    );
  }
}
