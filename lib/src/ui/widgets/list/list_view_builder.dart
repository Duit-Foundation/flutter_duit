import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/ui/widgets/tile.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class DuitListViewBuilder extends StatefulWidget {
  final UIElementController<ListViewAttributes> controller;

  const DuitListViewBuilder({
    super.key,
    required this.controller,
  });

  @override
  State<DuitListViewBuilder> createState() => _DuitListViewBuilderState();
}

class _DuitListViewBuilderState extends State<DuitListViewBuilder>
    with
        ViewControllerChangeListener<DuitListViewBuilder, ListViewAttributes>,
        ScrollUtils,
        OutOfBoundWidgetBuilder {
  @override
  void initState() {
    attachStateToController(widget.controller);
    attachOnScrollCallback<ListViewAttributes>(widget.controller);
    super.initState();
  }

  Widget? buildItem(BuildContext context, int index) {
    final item = attributes.childObjects![index];

    final driver = widget.controller.driver;

    final layout = parseLayoutSync(
      item,
      driver,
    );

    return DuitTile(
      id: item["id"],
      child: layout.render(),
    );
  }

  @override
  Widget build(BuildContext context) {
    isEOL = false;
    return ListView.builder(
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
      itemBuilder: buildItem,
      itemCount: attributes.childObjects?.length ?? 0,
      controller: scrollController,
    );
  }
}
