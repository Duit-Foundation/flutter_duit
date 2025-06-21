import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/ui/widgets/tile.dart';

final class DuitSliverListSeparated extends StatefulWidget {
  final UIElementController<SliverListAttributes> controller;

  const DuitSliverListSeparated({super.key, required this.controller});

  @override
  State<DuitSliverListSeparated> createState() =>
      _DuitSliverListSeparatedState();
}

class _DuitSliverListSeparatedState extends State<DuitSliverListSeparated>
    with
        ViewControllerChangeListener<DuitSliverListSeparated,
            SliverListAttributes>,
        ScrollUtils,
        OutOfBoundWidgetBuilder {
  @override
  void initState() {
    attachStateToController(widget.controller);
    attachOnScrollCallback(widget.controller);
    super.initState();
  }

  Widget? buildItem(BuildContext context, int index) {
    final item = attributes.childObjects?[index];
    return buildOutOfBoundWidget(
      item,
      widget.controller.driver,
      (child) => DuitTile(id: item?["id"], child: child),
    );
  }

  Widget buildSeparator(BuildContext context, int index) {
    final driver = widget.controller.driver;
    return buildOutOfBoundWidget(attributes.separator, driver, null) ??
        const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    isEOL = false;
    return SliverList.separated(
      itemBuilder: buildItem,
      separatorBuilder: buildSeparator,
      itemCount: attributes.childObjects?.length ?? 0,
      addAutomaticKeepAlives: attributes.addAutomaticKeepAlives,
      addRepaintBoundaries: attributes.addRepaintBoundaries,
      addSemanticIndexes: attributes.addSemanticIndexes,
    );
  }
}
