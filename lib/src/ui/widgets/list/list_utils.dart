import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/ui/widgets/index.dart";
import "package:flutter_duit/src/utils/index.dart";

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
    //TODO
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent -
              _scrollController.offset <=
          150) {
        if (!_isExecuting && !_isEOL) {
          _isExecuting = true;
          _isEOL = true;
          viewCtx.controller.performRelatedAction();
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

    return FutureBuilder(
      future: layout,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.render();
        } else if (snapshot.hasError) {
          return kDebugMode
              ? Text(snapshot.error.toString())
              : const SizedBox.shrink();
        } else {
          return const SizedBox.shrink();
        }
      },
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

    return FutureBuilder(
      future: layout,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _separatorView = snapshot.data!.render();
        } else if (snapshot.hasError) {
          return kDebugMode
              ? Text(snapshot.error.toString())
              : const SizedBox.shrink();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
//</editor-fold>
}
