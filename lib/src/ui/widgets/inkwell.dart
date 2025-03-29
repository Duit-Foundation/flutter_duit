import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/index.dart';

class DuitInkWell extends StatefulWidget {
  final UIElementController<InkWellAttributes> controller;
  final Widget child;

  const DuitInkWell({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitInkWell> createState() => _DuitInkWellState();
}

class _DuitInkWellState extends State<DuitInkWell>
    with
        ViewControllerChangeListener<DuitInkWell, InkWellAttributes>,
        ActionHandler {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: Key(widget.controller.id),
      focusColor: attributes.focusColor,
      hoverColor: attributes.hoverColor,
      highlightColor: attributes.highlightColor,
      overlayColor: attributes.overlayColor,
      splashColor: attributes.splashColor,
      radius: attributes.radius,
      borderRadius: attributes.borderRadius,
      customBorder: attributes.customBorder,
      hoverDuration: attributes.hoverDuration,
      enableFeedback: attributes.enableFeedback,
      excludeFromSemantics: attributes.excludeFromSemantics,
      autofocus: attributes.autofocus,
      canRequestFocus: attributes.canRequestFocus,
      onTap: performAction(
        context,
        widget.controller,
        attributes.onTap,
        type: GestureType.onTap,
      ),
      onDoubleTap: performAction(
        context,
        widget.controller,
        attributes.onDoubleTap,
        type: GestureType.onDoubleTap,
      ),
      onLongPress: performAction(
        context,
        widget.controller,
        attributes.onLongPress,
        type: GestureType.onLongPress,
      ),
      onTapDown: performAction(
        context,
        widget.controller,
        attributes.onTapDown,
        type: GestureType.onTapDown,
      ),
      onTapUp: performAction(
        context,
        widget.controller,
        attributes.onTapUp,
        type: GestureType.onTapUp,
      ),
      onTapCancel: performAction(
        context,
        widget.controller,
        attributes.onTapCancel,
        type: GestureType.onTapCancel,
      ),
      onSecondaryTapDown: performAction(
        context,
        widget.controller,
        attributes.onSecondaryTapDown,
        type: GestureType.onSecondaryTapDown,
      ),
      onSecondaryTapCancel: performAction(
        context,
        widget.controller,
        attributes.onSecondaryTapCancel,
        type: GestureType.onSecondaryTapCancel,
      ),
      onSecondaryTap: performAction(
        context,
        widget.controller,
        attributes.onSecondaryTap,
        type: GestureType.onSecondaryTap,
      ),
      onSecondaryTapUp: performAction(
        context,
        widget.controller,
        attributes.onSecondaryTapUp,
        type: GestureType.onSecondaryTapUp,
      ),
      child: widget.child,
    );
  }
}
