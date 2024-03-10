import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/controller/index.dart";
import "package:flutter_duit/src/ui/widgets/index.dart";
import "package:flutter_duit/src/utils/index.dart";

import "list_tile.dart";

mixin ListUtils<T extends StatefulWidget> on State<T> {
  //<editor-fold desc="Properties and getters">
  late final ScrollController _scrollController;
  bool _isExecuting = false, _isEOL = false;
  Widget? _separatorView;

  ScrollController get scrollController => _scrollController;

  set isEOL(bool value) => _isEOL = value;

  //</editor-fold>

  //<editor-fold desc="Lifecycle methods">
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  //</editor-fold>

  //<editor-fold desc="Methods">
  void attachOnScrollCallback(BuildContext context) {
    final viewCtx = DuitListViewContext.of(context);
    final attrs = viewCtx.controller.attributes!.payload as ListViewAttributes;
    final extent = attrs.scrollEndReachedThreshold ?? 150;
    _scrollController.addListener(() async {
      if (_scrollController.position.maxScrollExtent -
              _scrollController.offset <=
          extent) {
        if (!_isExecuting && !_isEOL) {
          _isExecuting = true;
          final controller = viewCtx.controller as ViewController;
          await controller.performRelatedActionAsync();
          _isEOL = true;
          _isExecuting = false;
        }
      }
    });
  }

  Widget? buildItem(BuildContext context, int index) {
    final viewCtx = DuitListViewContext.of(context);
    final item = viewCtx.childrenArray[index];

    final alreadyParsed = item["alreadyParsed"] == true;
    final driver = viewCtx.controller.driver;

    if (alreadyParsed) {
      driver.detachController(item["id"]);
    }

    final layout = parseLayout(
      item,
      driver,
    );

    item["alreadyParsed"] = true;

    return DuitDisposableListTile(
      driver: driver,
      id: item["id"],
      layout: layout,
    );
  }

  Widget buildSeparator(BuildContext context, int index) {
    if (_separatorView != null) {
      return _separatorView!;
    }

    final viewCtx = DuitListViewContext.of(context);
    final attrs = viewCtx.controller.attributes!.payload as ListViewAttributes;
    final driver = viewCtx.controller.driver;

    final layout = parseLayout(
      attrs.separator!,
      driver,
    );

    return _separatorView = DuitListTile(
      driver: driver,
      layout: layout,
    );
  }
//</editor-fold>
}
