import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";

final class DuitListView extends StatelessWidget {
  final ViewAttribute attributes;
  final List<Widget> children;

  const DuitListView({
    super.key,
    required this.attributes,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = DuitDataSource(attributes.payload);
    return ListView(
      key: Key(attributes.id),
      scrollDirection: attrs.axis(),
      reverse: attrs.getBool("reverse", defaultValue: false),
      primary: attrs.tryGetBool("primary"),
      physics: attrs.scrollPhysics(),
      shrinkWrap: attrs.getBool("shrinkWrap", defaultValue: false),
      padding: attrs.edgeInsets(),
      itemExtent: attrs.tryGetDouble(key: "itemExtent"),
      cacheExtent: attrs.tryGetDouble(key: "cacheExtent"),
      semanticChildCount: attrs.tryGetInt(key: "semanticChildCount"),
      dragStartBehavior: attrs.dragStartBehavior(),
      keyboardDismissBehavior: attrs.keyboardDismissBehavior(),
      clipBehavior: attrs.clipBehavior(),
      restorationId: attrs.tryGetString("restorationId"),
      addAutomaticKeepAlives:
          attrs.getBool("addAutomaticKeepAlives", defaultValue: true),
      addRepaintBoundaries:
          attrs.getBool("addRepaintBoundaries", defaultValue: true),
      addSemanticIndexes:
          attrs.getBool("addSemanticIndexes", defaultValue: true),
      children: children,
    );
  }
}

final class DuitControlledListView extends StatefulWidget {
  final UIElementController controller;
  final List<Widget> children;

  const DuitControlledListView({
    super.key,
    required this.controller,
    required this.children,
  });

  @override
  State<DuitControlledListView> createState() => _DuitControlledListViewState();
}

class _DuitControlledListViewState extends State<DuitControlledListView>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: Key(widget.controller.id),
      scrollDirection: attributes.axis(),
      reverse: attributes.getBool("reverse", defaultValue: false),
      primary: attributes.tryGetBool("primary"),
      physics: attributes.scrollPhysics(),
      shrinkWrap: attributes.getBool("shrinkWrap", defaultValue: false),
      padding: attributes.edgeInsets(),
      itemExtent: attributes.tryGetDouble(key: "itemExtent"),
      cacheExtent: attributes.tryGetDouble(key: "cacheExtent"),
      semanticChildCount: attributes.tryGetInt(key: "semanticChildCount"),
      dragStartBehavior: attributes.dragStartBehavior(),
      keyboardDismissBehavior: attributes.keyboardDismissBehavior(),
      clipBehavior: attributes.clipBehavior(),
      restorationId: attributes.tryGetString("restorationId"),
      addAutomaticKeepAlives:
          attributes.getBool("addAutomaticKeepAlives", defaultValue: true),
      addRepaintBoundaries:
          attributes.getBool("addRepaintBoundaries", defaultValue: true),
      addSemanticIndexes:
          attributes.getBool("addSemanticIndexes", defaultValue: true),
      children: widget.children,
    );
  }
}
