import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";

class DuitGestureDetector extends StatefulWidget {
  final Widget child;
  final UIElementController<GestureDetectorAttributes> controller;

  const DuitGestureDetector({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<DuitGestureDetector> createState() => _DuitGestureDetectorState();
}

class _DuitGestureDetectorState extends State<DuitGestureDetector>
    with
        ViewControllerChangeListener<DuitGestureDetector,
            GestureDetectorAttributes>,
        ActionHandler {
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
        attributes.onTap,
        type: GestureType.onTap,
      ),
      onTapUp: performAction(
        context,
        widget.controller,
        attributes.onTapUp,
        type: GestureType.onTapUp,
      ),
      onTapDown: performAction(
        context,
        widget.controller,
        attributes.onTapDown,
        type: GestureType.onTapDown,
      ),
      onTapCancel: performAction(
        context,
        widget.controller,
        attributes.onTapCancel,
        type: GestureType.onTapCancel,
      ),
      onDoubleTap: performAction(
        context,
        widget.controller,
        attributes.onDoubleTap,
        type: GestureType.onDoubleTap,
      ),
      onDoubleTapDown: performAction(
        context,
        widget.controller,
        attributes.onDoubleTap,
        type: GestureType.onDoubleTapDown,
      ),
      onDoubleTapCancel: performAction(
        context,
        widget.controller,
        attributes.onDoubleTapCancel,
        type: GestureType.onDoubleTapCancel,
      ),
      onLongPress: performAction(
        context,
        widget.controller,
        attributes.onLongPress,
        type: GestureType.onLongPress,
      ),
      onLongPressStart: performAction(
        context,
        widget.controller,
        attributes.onLongPressStart,
        type: GestureType.onLongPressStart,
      ),
      onLongPressMoveUpdate: performAction(
        context,
        widget.controller,
        attributes.onLongPressMoveUpdate,
        type: GestureType.onLongPressMoveUpdate,
      ),
      onLongPressUp: performAction(
        context,
        widget.controller,
        attributes.onLongPressUp,
        type: GestureType.onLongPressUp,
      ),
      onLongPressEnd: performAction(
        context,
        widget.controller,
        attributes.onLongPressEnd,
        type: GestureType.onLongPressEnd,
      ),
      onPanStart: performAction(
        context,
        widget.controller,
        attributes.onPanStart,
        type: GestureType.onPanStart,
      ),
      onPanDown: performAction(
        context,
        widget.controller,
        attributes.onPanDown,
        type: GestureType.onPanDown,
      ),
      onPanUpdate: performAction(
        context,
        widget.controller,
        attributes.onPanUpdate,
        type: GestureType.onPanUpdate,
      ),
      onPanEnd: performAction(
        context,
        widget.controller,
        attributes.onPanEnd,
        type: GestureType.onPanEnd,
      ),
      onPanCancel: performAction(
        context,
        widget.controller,
        attributes.onPanCancel,
        type: GestureType.onPanCancel,
      ),
      behavior: attributes.behavior,
      dragStartBehavior: attributes.dragStartBehavior,
      excludeFromSemantics: attributes.excludeFromSemantics ?? false,
      child: widget.child,
    );
  }
}
