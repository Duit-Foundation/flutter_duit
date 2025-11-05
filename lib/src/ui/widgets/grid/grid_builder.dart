import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/duit_impl/view_context.dart';
import 'package:flutter_duit/src/ui/widgets/tile.dart';
import 'package:flutter_duit/src/utils/index.dart';

class DuitGridBuilder extends StatefulWidget {
  final UIElementController controller;

  const DuitGridBuilder({
    super.key,
    required this.controller,
  });

  @override
  State<DuitGridBuilder> createState() => _DuitGridBuilderState();
}

class _DuitGridBuilderState extends State<DuitGridBuilder>
    with ViewControllerChangeListener, ScrollUtils {
  Widget? buildItem(BuildContext context, int index) {
    final item = attributes.childObjects()[index];

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

    final delegateBuilder = viewCtx.sliverGridDelegatesRegistry[
        attributes.getString(key: "sliverGridDelegateKey")];

    if (delegateBuilder != null) {
      delegate = delegateBuilder.call(
        attributes["sliverGridDelegateOptions"] ?? const <String, dynamic>{},
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
      itemCount: attributes.childObjects().length,
      scrollDirection: attributes.axis(),
      reverse: attributes.getBool("reverse"),
      primary: attributes.tryGetBool("primary"),
      physics: attributes.scrollPhysics(),
      shrinkWrap: attributes.getBool("shrinkWrap"),
      padding: attributes.edgeInsets(),
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
      cacheExtent: attributes.tryGetDouble(key: "cacheExtent"),
      dragStartBehavior: attributes.dragStartBehavior(),
      keyboardDismissBehavior: attributes.keyboardDismissBehavior(),
      clipBehavior: attributes.clipBehavior()!,
      restorationId: attributes.tryGetString("restorationId"),
      controller: scrollController,
      hitTestBehavior: attributes.hitTestBehavior(
        defaultValue: HitTestBehavior.opaque,
      ),
      semanticChildCount: attributes.tryGetInt(key: "semanticChildCount"),
    );
  }
}
