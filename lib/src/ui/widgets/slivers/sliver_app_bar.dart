import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/ui/widgets/utils.dart";

const _kTitleIndex = 0,
    _kLeadingIndex = 1,
    _kFlexibleSpaceIndex = 2,
    _kBottomIndex = 3,
    _kActionsStartIndex = 4;

class DuitSliverAppBar extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;
  final List<Widget?> children;

  const DuitSliverAppBar({
    required this.attributes,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithDataSource(
      context,
      attributes.payload,
    );
    return SliverAppBar(
      key: ValueKey(attributes.id),
      leading: children.elementAtOrNull(_kLeadingIndex),
      title: children.elementAtOrNull(_kTitleIndex),
      flexibleSpace: children.elementAtOrNull(_kFlexibleSpaceIndex),
      bottom: extractPreferredSizeWidget(children, _kBottomIndex),
      actions: children.length > _kActionsStartIndex
          ? children.sublist(_kActionsStartIndex).whereType<Widget>().toList()
          : null,
      automaticallyImplyLeading: attrs.getBool(
        "automaticallyImplyLeading",
        defaultValue: true,
      ),
      excludeHeaderSemantics: attrs.getBool(
        "excludeHeaderSemantics",
      ),
      forceMaterialTransparency: attrs.getBool("forceMaterialTransparency"),
      primary: attrs.getBool("primary", defaultValue: true),
      shape: attrs.shapeBorder(),
      clipBehavior: attrs.clipBehavior(),
      floating: attrs.getBool("floating"),
      pinned: attrs.getBool("pinned"),
      snap: attrs.getBool("snap"),
      stretch: attrs.getBool("stretch"),
      expandedHeight: attrs.tryGetDouble(key: "expandedHeight"),
      backgroundColor: attrs.tryParseColor(key: "backgroundColor"),
      foregroundColor: attrs.tryParseColor(key: "foregroundColor"),
      surfaceTintColor: attrs.tryParseColor(key: "surfaceTintColor"),
      shadowColor: attrs.tryParseColor(key: "shadowColor"),
      elevation: attrs.tryGetDouble(key: "elevation"),
      scrolledUnderElevation: attrs.tryGetDouble(key: "scrolledUnderElevation"),
      toolbarHeight: attrs.getDouble(
        key: "toolbarHeight",
        defaultValue: kToolbarHeight,
      ),
      leadingWidth: attrs.tryGetDouble(key: "leadingWidth"),
      titleSpacing: attrs.tryGetDouble(key: "titleSpacing"),
      centerTitle: attrs.getBool("centerTitle"),
    );
  }
}

class DuitControlledSliverAppBar extends StatefulWidget
    with AnimatedAttributes {
  final UIElementController controller;
  final List<Widget?> children;

  const DuitControlledSliverAppBar({
    required this.controller,
    required this.children,
    super.key,
  });

  @override
  State<DuitControlledSliverAppBar> createState() =>
      _DuitControlledSliverAppBarState();
}

class _DuitControlledSliverAppBarState extends State<DuitControlledSliverAppBar>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.mergeWithDataSource(context, attributes);

    return SliverAppBar(
      key: ValueKey(widget.controller.id),
      leading: widget.children.elementAtOrNull(_kLeadingIndex),
      title: widget.children.elementAtOrNull(_kTitleIndex),
      flexibleSpace: widget.children.elementAtOrNull(_kFlexibleSpaceIndex),
      bottom: extractPreferredSizeWidget(widget.children, _kBottomIndex),
      actions: widget.children.length > _kActionsStartIndex
          ? widget.children
              .sublist(_kActionsStartIndex)
              .whereType<Widget>()
              .toList()
          : null,
      automaticallyImplyLeading: attrs.getBool(
        "automaticallyImplyLeading",
        defaultValue: true,
      ),
      excludeHeaderSemantics: attrs.getBool(
        "excludeHeaderSemantics",
      ),
      forceMaterialTransparency: attrs.getBool("forceMaterialTransparency"),
      primary: attrs.getBool("primary", defaultValue: true),
      shape: attrs.shapeBorder(),
      clipBehavior: attrs.clipBehavior(),
      floating: attrs.getBool("floating"),
      pinned: attrs.getBool("pinned"),
      snap: attrs.getBool("snap"),
      stretch: attrs.getBool("stretch"),
      expandedHeight: attrs.tryGetDouble(key: "expandedHeight"),
      backgroundColor: attrs.tryParseColor(key: "backgroundColor"),
      foregroundColor: attrs.tryParseColor(key: "foregroundColor"),
      surfaceTintColor: attrs.tryParseColor(key: "surfaceTintColor"),
      shadowColor: attrs.tryParseColor(key: "shadowColor"),
      elevation: attrs.tryGetDouble(key: "elevation"),
      scrolledUnderElevation: attrs.tryGetDouble(key: "scrolledUnderElevation"),
      toolbarHeight: attrs.getDouble(
        key: "toolbarHeight",
        defaultValue: kToolbarHeight,
      ),
      leadingWidth: attrs.tryGetDouble(key: "leadingWidth"),
      titleSpacing: attrs.tryGetDouble(key: "titleSpacing"),
      centerTitle: attrs.getBool("centerTitle"),
    );
  }
}
