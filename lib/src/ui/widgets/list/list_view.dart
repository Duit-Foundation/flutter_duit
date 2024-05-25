import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/gestures.dart";
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
    final attrs = attributes.payload as ListViewAttributes;
    return ListView(
      key: Key(attributes.id),
      scrollDirection: attrs.scrollDirection ?? Axis.vertical,
      reverse: attrs.reverse ?? false,
      primary: attrs.primary,
      physics: attrs.physics,
      shrinkWrap: attrs.shrinkWrap ?? false,
      padding: attrs.padding,
      itemExtent: attrs.itemExtent,
      cacheExtent: attrs.cacheExtent,
      semanticChildCount: attrs.semanticChildCount,
      dragStartBehavior: attrs.dragStartBehavior ?? DragStartBehavior.start,
      keyboardDismissBehavior: attrs.keyboardDismissBehavior ??
          ScrollViewKeyboardDismissBehavior.manual,
      clipBehavior: attrs.clipBehavior ?? Clip.hardEdge,
      restorationId: attrs.restorationId,
      addAutomaticKeepAlives: attrs.addAutomaticKeepAlives ?? true,
      addRepaintBoundaries: attrs.addRepaintBoundaries ?? true,
      addSemanticIndexes: attrs.addSemanticIndexes ?? true,
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
    with
        ViewControllerChangeListener<DuitControlledListView,
            ListViewAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: Key(widget.controller.id),
      scrollDirection: attributes.scrollDirection ?? Axis.vertical,
      reverse: attributes.reverse ?? false,
      primary: attributes.primary,
      physics: attributes.physics,
      shrinkWrap: attributes.shrinkWrap ?? false,
      padding: attributes.padding,
      itemExtent: attributes.itemExtent,
      cacheExtent: attributes.cacheExtent,
      semanticChildCount: attributes.semanticChildCount,
      dragStartBehavior:
          attributes.dragStartBehavior ?? DragStartBehavior.start,
      keyboardDismissBehavior: attributes.keyboardDismissBehavior ??
          ScrollViewKeyboardDismissBehavior.manual,
      clipBehavior: attributes.clipBehavior ?? Clip.hardEdge,
      restorationId: attributes.restorationId,
      addAutomaticKeepAlives: attributes.addAutomaticKeepAlives ?? true,
      addRepaintBoundaries: attributes.addRepaintBoundaries ?? true,
      addSemanticIndexes: attributes.addSemanticIndexes ?? true,
      children: widget.children,
    );
  }
}
