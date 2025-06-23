import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/flexible_space_bar_attributes.dart';

class DuitFlexibleSpaceBar extends StatefulWidget with AnimatedAttributes {
  final UIElementController<FlexibleSpaceBarAttributes> controller;

  const DuitFlexibleSpaceBar({
    super.key,
    required this.controller,
  });

  @override
  State<DuitFlexibleSpaceBar> createState() => _DuitFlexibleSpaceBarState();
}

class _DuitFlexibleSpaceBarState extends State<DuitFlexibleSpaceBar>
    with
        ViewControllerChangeListener<DuitFlexibleSpaceBar,
            FlexibleSpaceBarAttributes>,
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
    return buildOutOfBoundWidget(
      child,
      widget.controller.driver,
      null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.mergeWithAttributes(context, attributes);
    return FlexibleSpaceBar(
      key: ValueKey(widget.controller.id),
      title: _build(attrs.title),
      background: _build(attrs.background),
      centerTitle: attrs.centerTitle,
      expandedTitleScale: attrs.expandedTitleScale,
      collapseMode: attrs.collapseMode,
      stretchModes: attrs.stretchModes,
      titlePadding: attrs.titlePadding,
    );
  }
}
