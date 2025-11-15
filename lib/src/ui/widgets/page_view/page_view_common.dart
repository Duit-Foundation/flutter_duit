import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/ui/widgets/page_view/command_handler.dart";

class DuitPageViewCommon extends StatelessWidget {
  final ViewAttribute attributes;
  final List<Widget> children;

  const DuitPageViewCommon({
    required this.attributes,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    return PageView(
      key: ValueKey(attributes.id),
      scrollDirection: attrs.axis(
        defaultValue: Axis.horizontal,
      ),
      reverse: attrs.getBool("reverse"),
      physics: attrs.scrollPhysics(),
      pageSnapping: attrs.getBool(
        "pageSnapping",
        defaultValue: true,
      ),
      dragStartBehavior: attrs.dragStartBehavior(),
      allowImplicitScrolling: attrs.getBool("allowImplicitScrolling"),
      restorationId: attrs.tryGetString("restorationId"),
      clipBehavior: attrs.clipBehavior(
        defaultValue: Clip.hardEdge,
      )!,
      hitTestBehavior: attrs.hitTestBehavior(
        defaultValue: HitTestBehavior.opaque,
      ),
      padEnds: attrs.getBool(
        "padEnds",
        defaultValue: true,
      ),
      children: children,
      // Related issue: https://github.com/Duit-Foundation/flutter_duit/issues/315
      // scrollBehavior: not implemented
      // controller: has no controller at this widget variant
      // onPageChanged: has no callback at this widget variant
    );
  }
}

class DuitControlledPageViewCommon extends StatefulWidget {
  final UIElementController controller;
  final List<Widget> children;

  const DuitControlledPageViewCommon({
    required this.controller,
    required this.children,
    super.key,
  });

  @override
  State<DuitControlledPageViewCommon> createState() =>
      _DuitControlledPageViewCommonState();
}

class _DuitControlledPageViewCommonState
    extends State<DuitControlledPageViewCommon>
    with ViewControllerChangeListener, PageViewCommandHandler {
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
  void dispose() {
    disposeCommandHandler();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
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
      children: widget.children,
      // onPageChanged: _onChange,
    );
  }
}
