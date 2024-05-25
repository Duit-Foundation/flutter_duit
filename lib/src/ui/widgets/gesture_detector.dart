import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/duit_impl/view_context.dart";

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
    with
        ViewControllerChangeListener<DuitGestureDetector,
            GestureDetectorAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  void _performAction(
    ServerAction? action, {
    required GestureType type,
    Object? gestureInfo,
  }) {
    final viewCtx = DuitViewContext.of(context);

    if (viewCtx.gestureInterceptorBehavior ==
        GestureInterceptorBehavior.onlyWithAction) {
      if (action != null) {
        viewCtx.gestureInterceptor?.call(type, gestureInfo: gestureInfo);
      }

      widget.controller.performAction(action);
      return;
    }

    viewCtx.gestureInterceptor?.call(type, gestureInfo: gestureInfo);
    widget.controller.performAction(action);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: Key(widget.controller.id),
      onTap: () {
        _performAction(
          attributes.onTap,
          type: GestureType.onTap,
        );
      },
      onTapUp: (info) {
        _performAction(
          attributes.onTapUp,
          type: GestureType.onTapUp,
          gestureInfo: info,
        );
      },
      onTapDown: (info) {
        _performAction(
          attributes.onTapDown,
          type: GestureType.onTapDown,
          gestureInfo: info,
        );
      },
      onTapCancel: () {
        _performAction(
          attributes.onTapCancel,
          type: GestureType.onTapCancel,
        );
      },
      onDoubleTap: () {
        _performAction(
          attributes.onDoubleTap,
          type: GestureType.onDoubleTap,
        );
      },
      onDoubleTapDown: (info) {
        _performAction(
          attributes.onDoubleTapDown,
          type: GestureType.onDoubleTapDown,
          gestureInfo: info,
        );
      },
      onDoubleTapCancel: () {
        _performAction(
          attributes.onDoubleTapCancel,
          type: GestureType.onDoubleTapCancel,
        );
      },
      onLongPress: () {
        _performAction(
          attributes.onLongPress,
          type: GestureType.onLongPress,
        );
      },
      onLongPressStart: (info) {
        _performAction(
          attributes.onLongPressStart,
          type: GestureType.onLongPressStart,
          gestureInfo: info,
        );
      },
      onLongPressMoveUpdate: (info) {
        _performAction(
          attributes.onLongPressMoveUpdate,
          type: GestureType.onLongPressMoveUpdate,
          gestureInfo: info,
        );
      },
      onLongPressUp: () {
        _performAction(
          attributes.onLongPressUp,
          type: GestureType.onLongPressUp,
        );
      },
      onLongPressEnd: (info) {
        _performAction(
          attributes.onLongPressEnd,
          type: GestureType.onLongPressEnd,
          gestureInfo: info,
        );
      },
      onPanStart: (info) {
        _performAction(
          attributes.onPanStart,
          type: GestureType.onPanStart,
          gestureInfo: info,
        );
      },
      onPanDown: (info) {
        _performAction(
          attributes.onPanDown,
          type: GestureType.onPanDown,
          gestureInfo: info,
        );
      },
      onPanUpdate: (info) {
        _performAction(
          attributes.onPanUpdate,
          type: GestureType.onPanUpdate,
          gestureInfo: info,
        );
      },
      onPanEnd: (info) {
        _performAction(
          attributes.onPanEnd,
          type: GestureType.onPanEnd,
          gestureInfo: info,
        );
      },
      onPanCancel: () {
        _performAction(
          attributes.onPanCancel,
          type: GestureType.onPanCancel,
        );
      },
      behavior: attributes.behavior,
      dragStartBehavior: attributes.dragStartBehavior,
      excludeFromSemantics: attributes.excludeFromSemantics ?? false,
      child: widget.child,
    );
  }
}
