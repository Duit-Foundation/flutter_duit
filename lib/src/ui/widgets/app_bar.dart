import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/index.dart';

class DuitAppBar extends StatefulWidget
    with AnimatedAttributes
    implements PreferredSizeWidget {
  final UIElementController<AppBarAttributes> controller;
  const DuitAppBar({
    super.key,
    required this.controller,
  });

  @override
  State<DuitAppBar> createState() => _DuitAppBarState();
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _DuitAppBarState extends State<DuitAppBar>
    with
        ViewControllerChangeListener<DuitAppBar, AppBarAttributes>,
        OutOfBoundWidgetBuilder {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.mergeWithAttributes(
      context,
      attributes,
    );

    final driver = widget.controller.driver;

    return AppBar(
      key: Key(widget.controller.id),
      automaticallyImplyLeading: attrs.automaticallyImplyLeading,
      excludeHeaderSemantics: attrs.excludeHeaderSemantics,
      forceMaterialTransparency: attrs.forceMaterialTransparency,
      primary: attrs.primary,
      shape: attrs.shape,
      clipBehavior: attrs.clipBehavior,
      leading: buildOutOfBoundWidget(
        attrs.leading,
        driver,
        null,
      ),
      title: buildOutOfBoundWidget(
        attrs.title,
        driver,
        null,
      ),
      flexibleSpace: buildOutOfBoundWidget(
        attrs.flexibleSpace,
        driver,
        null,
      ),
      actions: attrs.actions
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
        attrs.bottom,
        driver,
        null,
      ),
      backgroundColor: attrs.backgroundColor,
      foregroundColor: attrs.foregroundColor,
      surfaceTintColor: attrs.surfaceTintColor,
      shadowColor: attrs.shadowColor,
      elevation: attrs.elevation,
      scrolledUnderElevation: attrs.scrolledUnderElevation,
      toolbarHeight: attrs.toolbarHeight,
      leadingWidth: attrs.leadingWidth,
      titleSpacing: attrs.titleSpacing,
      bottomOpacity: attrs.bottomOpacity,
      centerTitle: attrs.centerTitle,
    );
  }
}
