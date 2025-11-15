import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/duit_impl/index.dart";
import "package:flutter_duit/src/ui/widgets/page_view/command_handler.dart";
import "package:flutter_duit/src/ui/widgets/tile.dart";
import "package:flutter_duit/src/utils/index.dart";

class DuitPageViewBuilder extends StatefulWidget {
  final UIElementController controller;

  const DuitPageViewBuilder({
    required this.controller,
    super.key,
  });

  @override
  State<DuitPageViewBuilder> createState() => _DuitPageViewBuilderState();
}

class _DuitPageViewBuilderState extends State<DuitPageViewBuilder>
    with
        ViewControllerChangeListener,
        OutOfBoundWidgetBuilder,
        PageViewCommandHandler {

  @override
  void initState() {
    attachStateToController(widget.controller);
    initCommandHandler();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    widget.controller.listenCommand(handleCommand);
    super.didChangeDependencies();
  }

  @override
  void disposeCommandHandler() {
    disposeCommandHandler();
    super.disposeCommandHandler();
  }

  Widget? _buildItem(BuildContext context, int index) {
    final item = attributes.childObjects()[index];
    return buildOutOfBoundWidget(
      item,
      widget.controller.driver,
      (child) => DuitTile(
        id: item["id"],
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      key: ValueKey(widget.controller.id),
      scrollDirection: attributes.axis(
        defaultValue: Axis.horizontal,
      ),
      reverse: attributes.getBool("reverse"),
      physics: attributes.scrollPhysics(),
      pageSnapping: attributes.getBool(
        "pageSnapping",
        defaultValue: true,
      ),
      dragStartBehavior: attributes.dragStartBehavior(),
      allowImplicitScrolling: attributes.getBool("allowImplicitScrolling"),
      restorationId: attributes.tryGetString("restorationId"),
      clipBehavior: attributes.clipBehavior(
        defaultValue: Clip.hardEdge,
      )!,
      hitTestBehavior: attributes.hitTestBehavior(
        defaultValue: HitTestBehavior.opaque,
      ),
      padEnds: attributes.getBool(
        "padEnds",
        defaultValue: true,
      ),
      // Related issue: https://github.com/Duit-Foundation/flutter_duit/issues/315
      // scrollBehavior: not implemented
      controller: pageController,
      itemBuilder: _buildItem,
      itemCount: attributes.childObjects().length,
      // onPageChanged: _onChange,
    );
  }
}
