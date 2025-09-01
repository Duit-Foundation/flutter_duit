import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/ui/widgets/utils.dart";

class DuitAppBar extends StatelessWidget
    with AnimatedAttributes
    implements PreferredSizeWidget {
  final ViewAttribute attributes;
  final List<Widget?> children;

  const DuitAppBar({
    required this.attributes,
    required this.children,
    super.key,
  });

  @override
  Size get preferredSize => Size.fromHeight(
        attributes.payload.tryGetDouble(key: "toolbarHeight") ?? kToolbarHeight,
      );

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithDataSource(
      context,
      attributes.payload,
    );

    return AppBar(
      key: Key(attributes.id),
      automaticallyImplyLeading: attrs.getBool(
        "automaticallyImplyLeading",
        defaultValue: true,
      ),
      excludeHeaderSemantics: attrs.getBool(
        "excludeHeaderSemantics",
        defaultValue: false,
      ),
      forceMaterialTransparency: attrs.getBool(
        "forceMaterialTransparency",
        defaultValue: false,
      ),
      primary: attrs.getBool("primary", defaultValue: true),
      shape: attrs.shapeBorder(),
      clipBehavior: attrs.clipBehavior(),
      title: children.elementAtOrNull(kTitleIndex),
      leading: children.elementAtOrNull(kLeadingIndex),
      flexibleSpace: children.elementAtOrNull(kFlexibleSpaceIndex),
      bottom: extractPreferredSizeWidget(children, kBottomIndex),
      actions: children.length > kActionsStartIndex
          ? children.sublist(kActionsStartIndex).whereType<Widget>().toList()
          : null,
      backgroundColor: attrs.tryParseColor(key: "backgroundColor"),
      foregroundColor: attrs.tryParseColor(key: "foregroundColor"),
      surfaceTintColor: attrs.tryParseColor(key: "surfaceTintColor"),
      shadowColor: attrs.tryParseColor(key: "shadowColor"),
      elevation: attrs.tryGetDouble(key: "elevation"),
      scrolledUnderElevation: attrs.tryGetDouble(key: "scrolledUnderElevation"),
      toolbarHeight: attrs.tryGetDouble(key: "toolbarHeight"),
      leadingWidth: attrs.tryGetDouble(key: "leadingWidth"),
      titleSpacing: attrs.tryGetDouble(key: "titleSpacing"),
      bottomOpacity: attrs.getDouble(
        key: "bottomOpacity",
        defaultValue: 1.0,
      ),
      centerTitle: attrs.tryGetBool("centerTitle"),
    );
  }
}

class DuitControlledAppBar extends StatefulWidget
    with AnimatedAttributes
    implements PreferredSizeWidget {
  final UIElementController controller;
  final List<Widget?> children;

  const DuitControlledAppBar({
    required this.controller,
    required this.children,
    super.key,
  });

  @override
  State<DuitControlledAppBar> createState() => _DuitControlledAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(
        controller.attributes.payload.tryGetDouble(key: "toolbarHeight") ??
            kToolbarHeight,
      );
}

class _DuitControlledAppBarState extends State<DuitControlledAppBar>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.mergeWithDataSource(
      context,
      attributes,
    );

    final children = widget.children;

    return AppBar(
      key: Key(widget.controller.id),
      automaticallyImplyLeading: attrs.getBool(
        "automaticallyImplyLeading",
        defaultValue: true,
      ),
      excludeHeaderSemantics: attrs.getBool(
        "excludeHeaderSemantics",
        defaultValue: false,
      ),
      forceMaterialTransparency: attrs.getBool(
        "forceMaterialTransparency",
        defaultValue: false,
      ),
      primary: attrs.getBool("primary", defaultValue: true),
      shape: attrs.shapeBorder(),
      clipBehavior: attrs.clipBehavior(),
      title: children.elementAtOrNull(kTitleIndex),
      leading: children.elementAtOrNull(kLeadingIndex),
      flexibleSpace: children.elementAtOrNull(kFlexibleSpaceIndex),
      bottom: extractPreferredSizeWidget(children, kBottomIndex),
      actions: children.length > kActionsStartIndex
          ? children.sublist(kActionsStartIndex).whereType<Widget>().toList()
          : null,
      backgroundColor: attrs.tryParseColor(key: "backgroundColor"),
      foregroundColor: attrs.tryParseColor(key: "foregroundColor"),
      surfaceTintColor: attrs.tryParseColor(key: "surfaceTintColor"),
      shadowColor: attrs.tryParseColor(key: "shadowColor"),
      elevation: attrs.tryGetDouble(key: "elevation"),
      scrolledUnderElevation: attrs.tryGetDouble(key: "scrolledUnderElevation"),
      toolbarHeight: attrs.tryGetDouble(key: "toolbarHeight"),
      leadingWidth: attrs.tryGetDouble(key: "leadingWidth"),
      titleSpacing: attrs.tryGetDouble(key: "titleSpacing"),
      bottomOpacity: attrs.getDouble(
        key: "bottomOpacity",
        defaultValue: 1.0,
      ),
      centerTitle: attrs.tryGetBool("centerTitle"),
    );
  }
}
