import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitInkWell extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitInkWell({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  State<DuitInkWell> createState() => _DuitInkWellState();
}

class _DuitInkWellState extends State<DuitInkWell>
    with ViewControllerChangeListener, ActionHandler {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: Key(widget.controller.id),
      focusColor: attributes.tryParseColor(key: "focusColor"),
      hoverColor: attributes.tryParseColor(key: "hoverColor"),
      highlightColor: attributes.tryParseColor(key: "highlightColor"),
      overlayColor: attributes.widgetStateProperty<Color>(key: "overlayColor"),
      splashColor: attributes.tryParseColor(key: "splashColor"),
      radius: attributes.tryGetDouble(key: "radius"),
      borderRadius: attributes.borderRadius(),
      customBorder: attributes.shapeBorder(key: "customBorder"),
      hoverDuration: attributes.duration(key: "hoverDuration"),
      enableFeedback: attributes.getBool(
        "enableFeedback",
        defaultValue: true,
      ),
      excludeFromSemantics: attributes.getBool("excludeFromSemantics"),
      autofocus: attributes.getBool("autofocus"),
      canRequestFocus: attributes.getBool(
        "canRequestFocus",
        defaultValue: true,
      ),
      onTap: performAction(
        context,
        widget.controller,
        attributes.getAction("onTap"),
        type: GestureType.onTap,
      ),
      onDoubleTap: performAction(
        context,
        widget.controller,
        attributes.getAction("onDoubleTap"),
        type: GestureType.onDoubleTap,
      ),
      onLongPress: performAction(
        context,
        widget.controller,
        attributes.getAction("onLongPress"),
        type: GestureType.onLongPress,
      ),
      onTapDown: performAction(
        context,
        widget.controller,
        attributes.getAction("onTapDown"),
        type: GestureType.onTapDown,
      ),
      onTapUp: performAction(
        context,
        widget.controller,
        attributes.getAction("onTapUp"),
        type: GestureType.onTapUp,
      ),
      onTapCancel: performAction(
        context,
        widget.controller,
        attributes.getAction("onTapCancel"),
        type: GestureType.onTapCancel,
      ),
      onSecondaryTapDown: performAction(
        context,
        widget.controller,
        attributes.getAction("onSecondaryTapDown"),
        type: GestureType.onSecondaryTapDown,
      ),
      onSecondaryTapCancel: performAction(
        context,
        widget.controller,
        attributes.getAction("onSecondaryTapCancel"),
        type: GestureType.onSecondaryTapCancel,
      ),
      onSecondaryTap: performAction(
        context,
        widget.controller,
        attributes.getAction("onSecondaryTap"),
        type: GestureType.onSecondaryTap,
      ),
      onSecondaryTapUp: performAction(
        context,
        widget.controller,
        attributes.getAction("onSecondaryTapUp"),
        type: GestureType.onSecondaryTapUp,
      ),
      child: widget.child,
    );
  }
}
