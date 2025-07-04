import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';

class DuitSliverAppBar extends StatefulWidget with AnimatedAttributes {
  final UIElementController controller;

  const DuitSliverAppBar({
    super.key,
    required this.controller,
  });

  @override
  State<DuitSliverAppBar> createState() => _DuitSliverAppBarState();
}

class _DuitSliverAppBarState extends State<DuitSliverAppBar>
    with ViewControllerChangeListener, OutOfBoundWidgetBuilder {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  Widget? _build(NonChildWidget? child) {
    if (child == null) {
      return null;
    }
    return buildOutOfBoundWidget(child, widget.controller.driver, null);
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.mergeWithDataSource(context, attributes);

    return SliverAppBar(
      key: ValueKey(widget.controller.id),
      automaticallyImplyLeading:
          attrs.getBool("automaticallyImplyLeading", defaultValue: true),
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
      leading: _build(attrs["leading"]),
      title: _build(attrs["title"]),
      flexibleSpace: _build(attrs["flexibleSpace"]),
      actions: (attrs["actions"] as List?)
          ?.map((e) => _build(e))
          .whereType<Widget>()
          .toList(),
      bottom: _build(attrs["bottom"]) as PreferredSizeWidget?,
      backgroundColor: attrs.tryParseColor(key: "backgroundColor"),
      foregroundColor: attrs.tryParseColor(key: "foregroundColor"),
      surfaceTintColor: attrs.tryParseColor(key: "surfaceTintColor"),
      shadowColor: attrs.tryParseColor(key: "shadowColor"),
      elevation: attrs.tryGetDouble(key: "elevation"),
      scrolledUnderElevation: attrs.tryGetDouble(key: "scrolledUnderElevation"),
      toolbarHeight:
          attrs.getDouble(key: "toolbarHeight", defaultValue: kToolbarHeight),
      leadingWidth: attrs.tryGetDouble(key: "leadingWidth"),
      titleSpacing: attrs.tryGetDouble(key: "titleSpacing"),
      centerTitle: attrs.getBool("centerTitle"),
    );
  }
}
