import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/ui/widgets/utils.dart";

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
      leading: children.elementAtOrNull(kLeadingIndex),
      title: children.elementAtOrNull(kTitleIndex),
      flexibleSpace: children.elementAtOrNull(kFlexibleSpaceIndex),
      bottom: extractPreferredSizeWidget(children, kBottomIndex),
      actions: children.length > kActionsStartIndex
          ? children.sublist(kActionsStartIndex).cast<Widget>()
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
      leading: widget.children.elementAtOrNull(kLeadingIndex),
      title: widget.children.elementAtOrNull(kTitleIndex),
      flexibleSpace: widget.children.elementAtOrNull(kFlexibleSpaceIndex),
      bottom: extractPreferredSizeWidget(widget.children, kBottomIndex),
      actions: widget.children.length > kActionsStartIndex
          ? widget.children.sublist(kActionsStartIndex).cast<Widget>()
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
