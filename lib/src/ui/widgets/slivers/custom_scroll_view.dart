import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';

class DuitCustomScrollView extends StatelessWidget {
  final ViewAttribute attributes;
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
      scrollDirection: attrs.axis(),
      reverse: attrs.getBool("reverse"),
      primary: attrs.tryGetBool("primary"),
      physics: attrs.scrollPhysics(),
      shrinkWrap: attrs.getBool("shrinkWrap"),
      // center: attrs.tryGetBool("center"),
      anchor: attrs.getDouble(key: "anchor"),
      cacheExtent: attrs.tryGetDouble(key: "cacheExtent"),
      semanticChildCount: attrs.tryGetInt(key: "semanticChildCount"),
      dragStartBehavior: attrs.dragStartBehavior(),
      keyboardDismissBehavior: attrs.keyboardDismissBehavior(),
      clipBehavior: attrs.clipBehavior()!,
      hitTestBehavior: attrs.hitTestBehavior(),
      slivers: children,
    );
  }
}

class DuitControlledCustomScrollView extends StatefulWidget {
  final UIElementController controller;
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
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: ValueKey(widget.controller.id),
      scrollDirection: attributes.axis(),
      reverse: attributes.getBool("reverse"),
      primary: attributes.tryGetBool("primary"),
      physics: attributes.scrollPhysics(),
      shrinkWrap: attributes.getBool("shrinkWrap"),
      // center: attrs.tryGetBool("center"),
      anchor: attributes.getDouble(key: "anchor"),
      cacheExtent: attributes.tryGetDouble(key: "cacheExtent"),
      semanticChildCount: attributes.tryGetInt(key: "semanticChildCount"),
      dragStartBehavior: attributes.dragStartBehavior(),
      keyboardDismissBehavior: attributes.keyboardDismissBehavior(),
      clipBehavior: attributes.clipBehavior()!,
      hitTestBehavior: attributes.hitTestBehavior(),
      slivers: widget.children,
    );
  }
}
