import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

const _kTitleIndex = 0, _kBackgroundIndex = 1;

class DuitFlexibleSpaceBar extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;
  final List<Widget?> children;

  const DuitFlexibleSpaceBar({
    required this.attributes,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithDataSource(context, attributes.payload);
    return FlexibleSpaceBar(
      key: ValueKey(attributes.id),
      title: children.elementAtOrNull(_kTitleIndex),
      background: children.elementAtOrNull(_kBackgroundIndex),
      centerTitle: attrs.tryGetBool("centerTitle"),
      expandedTitleScale: attrs.getDouble(
        key: "expandedTitleScale",
        defaultValue: 1.5,
      ),
      collapseMode: attrs.collapseMode(),
      stretchModes: attrs.stretchModes(),
      titlePadding: attrs.edgeInsets(key: "titlePadding"),
    );
  }
}

class DuitControlledFlexibleSpaceBar extends StatefulWidget
    with AnimatedAttributes {
  final UIElementController controller;
  final List<Widget?> children;

  const DuitControlledFlexibleSpaceBar({
    required this.controller,
    required this.children,
    super.key,
  });

  @override
  State<DuitControlledFlexibleSpaceBar> createState() =>
      _DuitControlledFlexibleSpaceBarState();
}

class _DuitControlledFlexibleSpaceBarState
    extends State<DuitControlledFlexibleSpaceBar>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.mergeWithDataSource(context, attributes);
    return FlexibleSpaceBar(
      key: ValueKey(widget.controller.id),
      title: widget.children.elementAtOrNull(_kTitleIndex),
      background: widget.children.elementAtOrNull(_kBackgroundIndex),
      centerTitle: attrs.tryGetBool("centerTitle"),
      expandedTitleScale: attrs.getDouble(
        key: "expandedTitleScale",
        defaultValue: 1.5,
      ),
      collapseMode: attrs.collapseMode(),
      stretchModes: attrs.stretchModes(),
      titlePadding: attrs.edgeInsets(key: "titlePadding"),
    );
  }
}
