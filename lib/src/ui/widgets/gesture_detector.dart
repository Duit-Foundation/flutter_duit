import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/duit_impl/view_context.dart";
import "package:flutter_duit/src/utils/index.dart";

class DuitGestureDetector extends StatefulWidget {
  final Widget child;
  final UIElementController? controller;

  const DuitGestureDetector({super.key, required this.child, this.controller});

  @override
  State<DuitGestureDetector> createState() => _DuitGestureDetectorState();
}

class _DuitGestureDetectorState extends State<DuitGestureDetector>
    with
        ViewControllerChangeListener<DuitGestureDetector,
            GestureDetectorAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  void _performAction(ServerAction? action) {
    widget.controller?.performAction(action);
  }

  @override
  Widget build(BuildContext context) {
    final interceptor = DuitViewContext.of(context).gestureInterceptor;
    return GestureDetector(
      onTap: () {
        _performAction(attributes?.onTap);
        interceptor?.call(GestureType.onTap);
      },
      onTapUp: (info) {
        _performAction(attributes?.onTapUp);
        interceptor?.call(GestureType.onTapUp, gestureInfo: info);
      },
      onTapDown: (info) {
        _performAction(attributes?.onTapDown);
        interceptor?.call(GestureType.onTapDown, gestureInfo: info);
      },
      onTapCancel: () {
        _performAction(attributes?.onTapCancel);
        interceptor?.call(GestureType.onTapCancel);
      },
      onDoubleTap: () {
        _performAction(attributes?.onDoubleTap);
        interceptor?.call(GestureType.onDoubleTap);
      },
      onDoubleTapDown: (info) {
        _performAction(attributes?.onDoubleTapDown);
        interceptor?.call(GestureType.onDoubleTapDown, gestureInfo: info);
      },
      onDoubleTapCancel: () {
        _performAction(attributes?.onDoubleTapCancel);
        interceptor?.call(GestureType.onDoubleTapCancel);
      },
      onLongPress: () {
        _performAction(attributes?.onLongPress);
        interceptor?.call(GestureType.onLongPress);
      },
      onLongPressStart: (info) {
        _performAction(attributes?.onLongPressStart);
        interceptor?.call(GestureType.onLongPressStart, gestureInfo: info);
      },
      onLongPressMoveUpdate: (info) {
        _performAction(attributes?.onLongPressMoveUpdate);
        interceptor?.call(GestureType.onLongPressMoveUpdate, gestureInfo: info);
      },
      onLongPressUp: () {
        _performAction(attributes?.onLongPressUp);
        interceptor?.call(GestureType.onLongPressUp);
      },
      onLongPressEnd: (info) {
        _performAction(attributes?.onLongPressEnd);
        interceptor?.call(GestureType.onLongPressEnd, gestureInfo: info);
      },
      onPanStart: (info) {
        _performAction(attributes?.onPanStart);
        interceptor?.call(GestureType.onPanStart, gestureInfo: info);
      },
      onPanDown: (info) {
        _performAction(attributes?.onPanDown);
        interceptor?.call(GestureType.onPanDown, gestureInfo: info);
      },
      onPanUpdate: (info) {
        _performAction(attributes?.onPanUpdate);
        interceptor?.call(GestureType.onPanUpdate, gestureInfo: info);
      },
      onPanEnd: (info) {
        _performAction(attributes?.onPanEnd);
        interceptor?.call(GestureType.onPanEnd, gestureInfo: info);
      },
      onPanCancel: () {
        _performAction(attributes?.onPanCancel);
        interceptor?.call(GestureType.onPanCancel);
      },
      behavior: attributes?.behavior,
      dragStartBehavior:
          attributes?.dragStartBehavior ?? DragStartBehavior.start,
      excludeFromSemantics: attributes?.excludeFromSemantics ?? false,
      child: widget.child,
    );
  }
}
