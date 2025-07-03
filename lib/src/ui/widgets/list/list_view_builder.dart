import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/ui/widgets/tile.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class DuitListViewBuilder extends StatefulWidget {
  final UIElementController controller;

  const DuitListViewBuilder({
    super.key,
    required this.controller,
  });

  @override
  State<DuitListViewBuilder> createState() => _DuitListViewBuilderState();
}

class _DuitListViewBuilderState extends State<DuitListViewBuilder>
    with ViewControllerChangeListener, ScrollUtils, OutOfBoundWidgetBuilder {
  @override
  void initState() {
    attachStateToController(widget.controller);
    attachOnScrollCallback(widget.controller);
    super.initState();
  }

  Widget? buildItem(BuildContext context, int index) {
    final item = attributes.childObjects()[index];

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
      scrollDirection: attributes.axis(),
      reverse: attributes.getBool("reverse"),
      primary: attributes.tryGetBool("primary"),
      physics: attributes.scrollPhysics(),
      shrinkWrap: attributes.getBool("shrinkWrap"),
      padding: attributes.edgeInsets(),
      itemExtent: attributes.tryGetDouble(key: "itemExtent"),
      cacheExtent: attributes.tryGetDouble(key: "cacheExtent"),
      semanticChildCount: attributes.tryGetInt(key: "semanticChildCount"),
      dragStartBehavior: attributes.dragStartBehavior(),
      keyboardDismissBehavior: attributes.keyboardDismissBehavior(),
      clipBehavior: attributes.clipBehavior()!,
      restorationId: attributes.tryGetString("restorationId"),
      addAutomaticKeepAlives: attributes.getBool(
        "addAutomaticKeepAlives",
        defaultValue: true,
      ),
      addRepaintBoundaries: attributes.getBool(
        "addRepaintBoundaries",
        defaultValue: true,
      ),
      addSemanticIndexes: attributes.getBool(
        "addSemanticIndexes",
        defaultValue: true,
      ),
      itemBuilder: buildItem,
      itemCount: attributes.childObjects().length,
      controller: scrollController,
    );
  }
}
