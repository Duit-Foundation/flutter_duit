import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";

final class DuitPageView extends StatelessWidget {
  final ViewAttribute<PageViewAttributes> attributes;
  final List<Widget> children;

  const DuitPageView({
    super.key,
    required this.attributes,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    return PageView(
      key: Key(attributes.id),
      scrollDirection: attrs.scrollDirection ?? Axis.horizontal,
      reverse: attrs.reverse ?? false,
      physics: attrs.physics,
      pageSnapping: attrs.pageSnapping ?? true,
      dragStartBehavior: attrs.dragStartBehavior ?? DragStartBehavior.start,
      allowImplicitScrolling: attrs.allowImplicitScrolling ?? false,
      restorationId: attrs.restorationId,
      clipBehavior: attrs.clipBehavior ?? Clip.hardEdge,
      hitTestBehavior: attrs.hitTestBehavior ?? HitTestBehavior.opaque,
      scrollBehavior: attrs.scrollBehavior,
      padEnds: attrs.padEnds ?? true,
      children: children,
    );
  }
}

final class DuitControlledPageView extends StatefulWidget {
  final UIElementController<PageViewAttributes> controller;
  final List<Widget> children;

  const DuitControlledPageView({
    super.key,
    required this.controller,
    required this.children,
  });

  @override
  State<DuitControlledPageView> createState() => _DuitControlledPageViewState();
}

class _DuitControlledPageViewState extends State<DuitControlledPageView>
    with
        ViewControllerChangeListener<DuitControlledPageView,
            PageViewAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      key: Key(widget.controller.id),
      scrollDirection: attributes.scrollDirection ?? Axis.horizontal,
      reverse: attributes.reverse ?? false,
      physics: attributes.physics,
      pageSnapping: attributes.pageSnapping ?? true,
      dragStartBehavior:
          attributes.dragStartBehavior ?? DragStartBehavior.start,
      allowImplicitScrolling: attributes.allowImplicitScrolling ?? false,
      restorationId: attributes.restorationId,
      clipBehavior: attributes.clipBehavior ?? Clip.hardEdge,
      hitTestBehavior: attributes.hitTestBehavior ?? HitTestBehavior.opaque,
      scrollBehavior: attributes.scrollBehavior,
      padEnds: attributes.padEnds ?? true,
      children: widget.children,
    );
  }
}
