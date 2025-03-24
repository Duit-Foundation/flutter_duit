import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/ui/widgets/tile.dart';

final class DuitListViewSeparated extends StatefulWidget {
  final UIElementController<ListViewAttributes> controller;

  const DuitListViewSeparated({super.key, required this.controller});

  @override
  State<DuitListViewSeparated> createState() => _DuitListViewSeparatedState();
}

class _DuitListViewSeparatedState extends State<DuitListViewSeparated>
    with
        ViewControllerChangeListener<DuitListViewSeparated, ListViewAttributes>,
        ScrollUtils,
        OutOfBoundWidgetBuilder {
  Widget? _separatorView;

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
      (child) => DuitTile(
        id: item?["id"],
        child: child,
      ),
    );
  }

  Widget buildSeparator(BuildContext context, int index) {
    if (_separatorView != null) {
      return _separatorView!;
    }

    final driver = widget.controller.driver;
    return _separatorView =
        buildOutOfBoundWidget(attributes.separator, driver, null) ??
            const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    isEOL = false;
    return ListView.separated(
      key: Key(widget.controller.id),
      scrollDirection: attributes.scrollDirection ?? Axis.vertical,
      reverse: attributes.reverse ?? false,
      primary: attributes.primary,
      physics: attributes.physics,
      shrinkWrap: attributes.shrinkWrap ?? false,
      padding: attributes.padding,
      cacheExtent: attributes.cacheExtent,
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
      separatorBuilder: buildSeparator,
    );
  }
}
