import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/duit_impl/view_context.dart';
import 'package:flutter_duit/src/ui/widgets/tile.dart';
import 'package:flutter_duit/src/utils/index.dart';

class DuitGridBuilder extends StatefulWidget {
  final UIElementController<GridViewAttributes> controller;

  const DuitGridBuilder({
    super.key,
    required this.controller,
  });

  @override
  State<DuitGridBuilder> createState() => _DuitGridBuilderState();
}

class _DuitGridBuilderState extends State<DuitGridBuilder>
    with
        ViewControllerChangeListener<DuitGridBuilder, GridViewAttributes>,
        ScrollUtils {
  Widget? buildItem(BuildContext context, int index) {
    final item = attributes.childObjects![index];

    final driver = widget.controller.driver;

    final layout = parseLayoutSync(
      item,
      driver,
    );

    return DuitTile(
      id: item["id"],
      child: layout.render(),
    );
  }

  @override
  void initState() {
    attachStateToController(widget.controller);
    attachOnScrollCallback(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SliverGridDelegate delegate;
    final viewCtx = DuitViewContext.of(context);

    final delegateBuilder =
        viewCtx.sliverGridDelegatesRegistry[attributes.sliverGridDelegateKey];

    if (delegateBuilder != null) {
      delegate = delegateBuilder.call(
        attributes.sliverGridDelegateOptions,
      );
    } else {
      throw ArgumentError(
        "SliverGridDelegate builder not found in DuitViewContext",
      );
    }

    isEOL = false;
    return GridView.builder(
      key: Key(widget.controller.id),
      gridDelegate: delegate,
      itemBuilder: buildItem,
      itemCount: attributes.childObjects?.length ?? 0,
      scrollDirection: attributes.scrollDirection,
      reverse: attributes.reverse,
      primary: attributes.primary,
      physics: attributes.physics,
      shrinkWrap: attributes.shrinkWrap,
      padding: attributes.padding,
      addAutomaticKeepAlives: attributes.addAutomaticKeepAlives,
      addRepaintBoundaries: attributes.addRepaintBoundaries,
      addSemanticIndexes: attributes.addSemanticIndexes,
      cacheExtent: attributes.cacheExtent,
      dragStartBehavior: attributes.dragStartBehavior,
      keyboardDismissBehavior: attributes.keyboardDismissBehavior,
      clipBehavior: attributes.clipBehavior,
      restorationId: attributes.restorationId,
      controller: scrollController,
      // hitTestBehavior: attributes.hitTestBehavior,
      semanticChildCount: attributes.semanticChildCount,
    );
  }
}
