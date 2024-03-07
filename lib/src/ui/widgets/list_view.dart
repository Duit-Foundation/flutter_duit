import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/utils/index.dart";

final class DuitListView extends StatelessWidget {
  final ViewAttributeWrapper attributes;
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
      scrollDirection: attributes?.scrollDirection ?? Axis.vertical,
      reverse: attributes?.reverse ?? false,
      primary: attributes?.primary,
      physics: attributes?.physics,
      shrinkWrap: attributes?.shrinkWrap ?? false,
      padding: attributes?.padding,
      itemExtent: attributes?.itemExtent,
      cacheExtent: attributes?.cacheExtent,
      semanticChildCount: attributes?.semanticChildCount,
      dragStartBehavior:
          attributes?.dragStartBehavior ?? DragStartBehavior.start,
      keyboardDismissBehavior: attributes?.keyboardDismissBehavior ??
          ScrollViewKeyboardDismissBehavior.manual,
      clipBehavior: attributes?.clipBehavior ?? Clip.hardEdge,
      restorationId: attributes?.restorationId,
      addAutomaticKeepAlives: attributes?.addAutomaticKeepAlives ?? true,
      addRepaintBoundaries: attributes?.addRepaintBoundaries ?? true,
      addSemanticIndexes: attributes?.addSemanticIndexes ?? true,
      children: widget.children,
    );
  }
}

class DuitListViewContext extends InheritedWidget {
  final List<JSONObject> children;

  const DuitListViewContext({
    super.key,
    required this.children,
    required Widget child,
  }) : super(child: child);

  static DuitListViewContext of(BuildContext context) {
    final DuitListViewContext? result =
        context.dependOnInheritedWidgetOfExactType<DuitListViewContext>();
    assert(result != null, 'No DuitListViewContext found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(DuitListViewContext oldWidget) {
    return children != oldWidget.children;
  }
}

class DuitListViewContextProvider extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitListViewContextProvider({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitListViewContextProvider> createState() =>
      _DuitListViewContextProviderState();
}

class _DuitListViewContextProviderState
    extends State<DuitListViewContextProvider>
    with
        ViewControllerChangeListener<DuitListViewContextProvider,
            ListViewAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DuitListViewContext(
      children: const [],
      child: widget.child,
    );
  }
}

class _ListItem extends StatefulWidget {
  const _ListItem();

  @override
  State<_ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<_ListItem> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

final class DuitListViewBuilder extends StatelessWidget {
  final UIElementController controller;
  final List<JSONObject> children;

  const DuitListViewBuilder({
    super.key,
    required this.controller,
    required this.children,
  });

  Widget? _buildItem(BuildContext context, int index) {
    final item = children[index];
    final widget = parseLayout(
      item,
      controller.driver,
    );

    return FutureBuilder(
      future: widget,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.render();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final attrs = controller.attributes!.payload as ListViewAttributes;
    return ListView.builder(
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
      itemBuilder: _buildItem,
    );
  }
}
