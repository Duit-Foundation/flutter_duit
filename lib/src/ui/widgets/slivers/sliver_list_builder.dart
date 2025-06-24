import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/ui/widgets/tile.dart';

final class DuitSliverListBuilder extends StatefulWidget {
  final UIElementController<SliverListAttributes> controller;

  const DuitSliverListBuilder({
    super.key,
    required this.controller,
  });

  @override
  State<DuitSliverListBuilder> createState() => _DuitSliverListBuilderState();
}

class _DuitSliverListBuilderState extends State<DuitSliverListBuilder>
    with
        ViewControllerChangeListener<DuitSliverListBuilder,
            SliverListAttributes>,
        ScrollUtils,
        OutOfBoundWidgetBuilder {
  @override
  void initState() {
    attachStateToController(widget.controller);
    attachOnScrollCallback<SliverListAttributes>(widget.controller);
    super.initState();
  }

  Widget? buildItem(BuildContext context, int index) {
    final list = attributes.childObjects ?? const [];
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
      itemBuilder: buildItem,
      itemCount: attributes.childObjects?.length ?? 0,
      addAutomaticKeepAlives: attributes.addAutomaticKeepAlives,
      addRepaintBoundaries: attributes.addRepaintBoundaries,
      addSemanticIndexes: attributes.addSemanticIndexes,
    );
  }
}
