import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/ui/widgets/tile.dart';

final class DuitListViewSeparated extends StatefulWidget {
  final UIElementController controller;

  const DuitListViewSeparated({super.key, required this.controller});

  @override
  State<DuitListViewSeparated> createState() => _DuitListViewSeparatedState();
}

class _DuitListViewSeparatedState extends State<DuitListViewSeparated>
    with ViewControllerChangeListener, ScrollUtils, OutOfBoundWidgetBuilder {
  Widget? _separatorView;

  @override
  void initState() {
    attachStateToController(widget.controller);
    attachOnScrollCallback(widget.controller);
    super.initState();
  }

  Widget? buildItem(BuildContext context, int index) {
    final item = attributes["childObjects"]?[index];
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
        buildOutOfBoundWidget(attributes["separator"], driver, null) ??
            const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    isEOL = false;
    return ListView.separated(
      key: Key(widget.controller.id),
      scrollDirection: attributes.axis(),
      reverse: attributes.getBool("reverse", defaultValue: false),
      primary: attributes.tryGetBool("primary"),
      physics: attributes.scrollPhysics(),
      shrinkWrap: attributes.getBool("shrinkWrap", defaultValue: false),
      padding: attributes.edgeInsets(),
      cacheExtent: attributes.tryGetDouble(key: "cacheExtent"),
      dragStartBehavior: attributes.dragStartBehavior(),
      keyboardDismissBehavior: attributes.keyboardDismissBehavior(),
      clipBehavior: attributes.clipBehavior(),
      restorationId: attributes.tryGetString("restorationId"),
      addAutomaticKeepAlives:
          attributes.getBool("addAutomaticKeepAlives", defaultValue: true),
      addRepaintBoundaries:
          attributes.getBool("addRepaintBoundaries", defaultValue: true),
      addSemanticIndexes:
          attributes.getBool("addSemanticIndexes", defaultValue: true),
      itemBuilder: buildItem,
      itemCount: attributes["childObjects"]?.length ?? 0,
      controller: scrollController,
      separatorBuilder: buildSeparator,
    );
  }
}
