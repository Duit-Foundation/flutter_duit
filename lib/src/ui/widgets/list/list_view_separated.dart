import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/attributes/index.dart';

import 'list_view_context.dart';
import 'list_utils.dart';

final class DuitListViewSeparated extends StatefulWidget {
  const DuitListViewSeparated({
    super.key,
  });

  @override
  State<DuitListViewSeparated> createState() => _DuitListViewSeparatedState();
}

class _DuitListViewSeparatedState extends State<DuitListViewSeparated>
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
    return ListView.separated(
      scrollDirection: attrs.scrollDirection ?? Axis.vertical,
      reverse: attrs.reverse ?? false,
      primary: attrs.primary,
      physics: attrs.physics,
      shrinkWrap: attrs.shrinkWrap ?? false,
      padding: attrs.padding,
      cacheExtent: attrs.cacheExtent,
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
      separatorBuilder: buildSeparator,
    );
  }
}
