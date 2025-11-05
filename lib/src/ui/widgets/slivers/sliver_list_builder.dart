import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/ui/widgets/tile.dart';

class DuitSliverListBuilder extends StatefulWidget {
  final UIElementController controller;

  const DuitSliverListBuilder({
    super.key,
    required this.controller,
  });

  @override
  State<DuitSliverListBuilder> createState() => _DuitSliverListBuilderState();
}

class _DuitSliverListBuilderState extends State<DuitSliverListBuilder>
    with ViewControllerChangeListener, ScrollUtils, OutOfBoundWidgetBuilder {
  @override
  void initState() {
    attachStateToController(widget.controller);
    attachOnScrollCallback(widget.controller);
    super.initState();
  }

  Widget? _buildItem(BuildContext context, int index) {
    final list = attributes.childObjects();
    final item = list[index];

    return buildOutOfBoundWidget(
      item,
      widget.controller.driver,
      (child) => DuitTile(id: item["id"], child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    isEOL = false;
    return SliverList.builder(
      key: Key(widget.controller.id),
      itemBuilder: _buildItem,
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
