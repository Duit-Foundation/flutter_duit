import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';

class DuitAppBar extends StatefulWidget
    with AnimatedAttributes
    implements PreferredSizeWidget {
  final UIElementController controller;
  const DuitAppBar({
    super.key,
    required this.controller,
  });

  @override
  State<DuitAppBar> createState() => _DuitAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(
        controller.attributes.payload.tryGetDouble(key: "toolbarHeight") ??
            kToolbarHeight,
      );
}

class _DuitAppBarState extends State<DuitAppBar>
    with ViewControllerChangeListener, OutOfBoundWidgetBuilder {
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

    final driver = widget.controller.driver;

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
      leading: buildOutOfBoundWidget(
        attrs["leading"],
        driver,
        null,
      ),
      title: buildOutOfBoundWidget(
        attrs["title"],
        driver,
        null,
      ),
      flexibleSpace: buildOutOfBoundWidget(
        attrs["flexibleSpace"],
        driver,
        null,
      ),
      actions: (attrs["actions"] as List?)
          ?.map(
            (e) => buildOutOfBoundWidget(
              e,
              driver,
              null,
            ),
          )
          .whereType<Widget>()
          .toList(),
      bottom: buildOutOfBoundWidget<PreferredSizeWidget>(
        attrs["bottom"],
        driver,
        null,
      ),
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
