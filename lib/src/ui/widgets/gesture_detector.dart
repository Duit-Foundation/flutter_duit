import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitGestureDetector extends StatefulWidget {
  final Widget child;
  final UIElementController controller;

  const DuitGestureDetector({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<DuitGestureDetector> createState() => _DuitGestureDetectorState();
}

class _DuitGestureDetectorState extends State<DuitGestureDetector>
    with ViewControllerChangeListener, ActionHandler {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: Key(widget.controller.id),
      onTap: performAction(
        context,
        widget.controller,
        attributes.getAction("onTap"),
        type: GestureType.onTap,
      ),
      onTapUp: performAction(
        context,
        widget.controller,
        attributes.getAction("onTapUp"),
        type: GestureType.onTapUp,
      ),
      onTapDown: performAction(
        context,
        widget.controller,
        attributes.getAction("onTapDown"),
        type: GestureType.onTapDown,
      ),
      onTapCancel: performAction(
        context,
        widget.controller,
        attributes.getAction("onTapCancel"),
        type: GestureType.onTapCancel,
      ),
      onDoubleTap: performAction(
        context,
        widget.controller,
        attributes.getAction("onDoubleTap"),
        type: GestureType.onDoubleTap,
      ),
      onDoubleTapDown: performAction(
        context,
        widget.controller,
        attributes.getAction("onDoubleTap"),
        type: GestureType.onDoubleTapDown,
      ),
      onDoubleTapCancel: performAction(
        context,
        widget.controller,
        attributes.getAction("onDoubleTapCancel"),
        type: GestureType.onDoubleTapCancel,
      ),
      onLongPress: performAction(
        context,
        widget.controller,
        attributes.getAction("onLongPress"),
        type: GestureType.onLongPress,
      ),
      onLongPressStart: performAction(
        context,
        widget.controller,
        attributes.getAction("onLongPressStart"),
        type: GestureType.onLongPressStart,
      ),
      onLongPressMoveUpdate: performAction(
        context,
        widget.controller,
        attributes.getAction("onLongPressMoveUpdate"),
        type: GestureType.onLongPressMoveUpdate,
      ),
      onLongPressUp: performAction(
        context,
        widget.controller,
        attributes.getAction("onLongPressUp"),
        type: GestureType.onLongPressUp,
      ),
      onLongPressEnd: performAction(
        context,
        widget.controller,
        attributes.getAction("onLongPressEnd"),
        type: GestureType.onLongPressEnd,
      ),
      onPanStart: performAction(
        context,
        widget.controller,
        attributes.getAction("onPanStart"),
        type: GestureType.onPanStart,
      ),
      onPanDown: performAction(
        context,
        widget.controller,
        attributes.getAction("onPanDown"),
        type: GestureType.onPanDown,
      ),
      onPanUpdate: performAction(
        context,
        widget.controller,
        attributes.getAction("onPanUpdate"),
        type: GestureType.onPanUpdate,
      ),
      onPanEnd: performAction(
        context,
        widget.controller,
        attributes.getAction("onPanEnd"),
        type: GestureType.onPanEnd,
      ),
      onPanCancel: performAction(
        context,
        widget.controller,
        attributes.getAction("onPanCancel"),
        type: GestureType.onPanCancel,
      ),
      behavior: attributes.hitTestBehavior(),
      dragStartBehavior: attributes.dragStartBehavior(),
      excludeFromSemantics: attributes.getBool("excludeFromSemantics"),
      child: widget.child,
    );
  }
}
