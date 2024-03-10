import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/attributes/index.dart';

import 'list_view_context.dart';
import 'list_utils.dart';

final class DuitListViewBuilder extends StatefulWidget {
  const DuitListViewBuilder({
    super.key,
  });

  @override
  State<DuitListViewBuilder> createState() => _DuitListViewBuilderState();
}

class _DuitListViewBuilderState extends State<DuitListViewBuilder>
    with ListUtils {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    attachOnScrollCallback(context);
  }

  @override
  Widget build(BuildContext context) {
    final viewCtx = DuitListViewContext.of(context);
    final attrs = viewCtx.controller.attributes!.payload as ListViewAttributes;
    isEOL = false;
    return ListView.builder(
      scrollDirection: attrs.scrollDirection ?? Axis.vertical,
      reverse: attrs.reverse ?? false,
      primary: attrs.primary,
      physics: attrs.physics,
      shrinkWrap: attrs.shrinkWrap ?? false,
      padding: attrs.padding,
      itemExtent: attrs.itemExtent,
      cacheExtent: attrs.cacheExtent,
      semanticChildCount: attrs.semanticChildCount,
      dragStartBehavior: attrs.dragStartBehavior ?? DragStartBehavior.start,
      keyboardDismissBehavior: attrs.keyboardDismissBehavior ??
          ScrollViewKeyboardDismissBehavior.manual,
      clipBehavior: attrs.clipBehavior ?? Clip.hardEdge,
      restorationId: attrs.restorationId,
      addAutomaticKeepAlives: attrs.addAutomaticKeepAlives ?? true,
      addRepaintBoundaries: attrs.addRepaintBoundaries ?? true,
      addSemanticIndexes: attrs.addSemanticIndexes ?? true,
      itemBuilder: buildItem,
      itemCount: viewCtx.childrenArray.length,
      controller: scrollController,
    );
  }
}
