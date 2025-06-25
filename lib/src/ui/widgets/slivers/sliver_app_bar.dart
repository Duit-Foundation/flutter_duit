import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/slivers/sliver_app_bar_attributes.dart';

class DuitSliverAppBar extends StatefulWidget with AnimatedAttributes {
  final UIElementController<SliverAppBarAttributes> controller;

  const DuitSliverAppBar({
    super.key,
    required this.controller,
  });

  @override
  State<DuitSliverAppBar> createState() => _DuitSliverAppBarState();
}

class _DuitSliverAppBarState extends State<DuitSliverAppBar>
    with
        ViewControllerChangeListener<DuitSliverAppBar, SliverAppBarAttributes>,
        OutOfBoundWidgetBuilder {
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
    final attrs = widget.mergeWithAttributes(context, attributes);

    return SliverAppBar(
      key: ValueKey(widget.controller.id),
      automaticallyImplyLeading: attrs.automaticallyImplyLeading,
      excludeHeaderSemantics: attrs.excludeHeaderSemantics,
      forceMaterialTransparency: attrs.forceMaterialTransparency,
      primary: attrs.primary,
      shape: attrs.shape,
      clipBehavior: attrs.clipBehavior,
      floating: attrs.floating,
      pinned: attrs.pinned,
      snap: attrs.snap,
      stretch: attrs.stretch,
      expandedHeight: attrs.expandedHeight,
      leading: _build(attrs.leading),
      title: _build(attrs.title),
      flexibleSpace: _build(attrs.flexibleSpace),
      actions:
          attrs.actions?.map((e) => _build(e)).whereType<Widget>().toList(),
      bottom: _build(attrs.bottom) as PreferredSizeWidget?,
      backgroundColor: attrs.backgroundColor,
      foregroundColor: attrs.foregroundColor,
      surfaceTintColor: attrs.surfaceTintColor,
      shadowColor: attrs.shadowColor,
      elevation: attrs.elevation ?? 4.0,
      scrolledUnderElevation: attrs.scrolledUnderElevation,
      toolbarHeight: attrs.toolbarHeight ?? kToolbarHeight,
      leadingWidth: attrs.leadingWidth,
      titleSpacing: attrs.titleSpacing,
      centerTitle: attrs.centerTitle,
    );
  }
}
