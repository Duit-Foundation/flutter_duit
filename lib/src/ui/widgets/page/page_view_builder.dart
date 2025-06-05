import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/ui/widgets/tile.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class DuitPageViewBuilder extends StatefulWidget {
  final UIElementController<PageViewAttributes> controller;

  const DuitPageViewBuilder({
    super.key,
    required this.controller,
  });

  @override
  State<DuitPageViewBuilder> createState() =>
      _DuitPageViewBuilderState();
}

class _DuitPageViewBuilderState
    extends State<DuitPageViewBuilder>
    with
        ViewControllerChangeListener<DuitPageViewBuilder,
            PageViewAttributes>,
        ScrollUtils,
        OutOfBoundWidgetBuilder {
  @override
  void initState() {
    attachStateToController(widget.controller);
    attachOnScrollCallback<PageViewAttributes>(widget.controller);
    super.initState();
  }

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
  Widget build(BuildContext context) {
    isEOL = false;
    return PageView.builder(
      key: Key(widget.controller.id),
      scrollDirection: attributes.scrollDirection ?? Axis.horizontal,
      reverse: attributes.reverse ?? false,
      physics: attributes.physics,
      pageSnapping: attributes.pageSnapping ?? true,
      itemBuilder: buildItem,
      itemCount: attributes.childObjects?.length ?? 0,
      dragStartBehavior:
          attributes.dragStartBehavior ?? DragStartBehavior.start,
      allowImplicitScrolling: attributes.allowImplicitScrolling ?? false,
      restorationId: attributes.restorationId,
      clipBehavior: attributes.clipBehavior ?? Clip.hardEdge,
      hitTestBehavior: attributes.hitTestBehavior ?? HitTestBehavior.opaque,
      scrollBehavior: attributes.scrollBehavior,
      padEnds: attributes.padEnds ?? true,
    );
  }
}
