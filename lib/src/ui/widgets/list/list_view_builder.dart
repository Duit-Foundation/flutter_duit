import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/ui/widgets/list/list_utils.dart';
import 'package:flutter_duit/src/utils/index.dart';

import 'list_tile.dart';

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
        ListUtils {
  @override
  void initState() {
    attachStateToController(widget.controller);
    attachOnScrollCallback(widget.controller);
    super.initState();
  }

  Widget? buildItem(BuildContext context, int index) {
    final item = attributes.childObjects![index];

    final alreadyParsed = item["alreadyParsed"] == true;
    final driver = widget.controller.driver;

    if (alreadyParsed) {
      driver.detachController(item["id"]);
    }

    final layout = parseLayoutSync(
      item,
      driver,
    );

    item["alreadyParsed"] = true;

    return DisposableListTile(
      id: item["id"],
      driver: driver,
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
