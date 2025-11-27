import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/ui/widgets/tile.dart";

final class DuitSliverListSeparated extends StatefulWidget {
  final UIElementController controller;

  const DuitSliverListSeparated({required this.controller, super.key});

  @override
  State<DuitSliverListSeparated> createState() =>
      _DuitSliverListSeparatedState();
}

class _DuitSliverListSeparatedState extends State<DuitSliverListSeparated>
    with ViewControllerChangeListener, ScrollUtils, OutOfBoundWidgetBuilder {
  @override
  void initState() {
    attachStateToController(widget.controller);
    attachOnScrollCallback(widget.controller);
    super.initState();
  }

  Widget? buildItem(BuildContext context, int index) {
    final item = attributes.childObjects()[index];
    return buildOutOfBoundWidget(
      item,
      widget.controller.driver,
      (child) => DuitTile(id: item["id"], child: child),
    );
  }

  Widget buildSeparator(BuildContext context, int index) {
    final driver = widget.controller.driver;
    return buildOutOfBoundWidget(attributes["separator"], driver, null) ??
        const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    isEOL = false;
    return SliverList.separated(
      itemBuilder: buildItem,
      separatorBuilder: buildSeparator,
      itemCount: attributes.childObjects().length,
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
    );
  }
}
