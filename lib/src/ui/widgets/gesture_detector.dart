import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/duit_impl/view_context.dart";

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
      onTap: attributes.onTap != null
          ? () {
              _performAction(
                attributes.onTap,
                type: GestureType.onTap,
              );
            }
          : null,
      onTapUp: attributes.onTapUp != null
          ? (info) {
              _performAction(
                attributes.onTapUp,
                type: GestureType.onTapUp,
                gestureInfo: info,
              );
            }
          : null,
      onTapDown: attributes.onTapDown != null
          ? (info) {
              _performAction(
                attributes.onTapDown,
                type: GestureType.onTapDown,
                gestureInfo: info,
              );
            }
          : null,
      onTapCancel: attributes.onTapCancel != null
          ? () {
              _performAction(
                attributes.onTapCancel,
                type: GestureType.onTapCancel,
              );
            }
          : null,
      onDoubleTap: attributes.onDoubleTap != null
          ? () {
              _performAction(
                attributes.onDoubleTap,
                type: GestureType.onDoubleTap,
              );
            }
          : null,
      onDoubleTapDown: attributes.onDoubleTapDown != null
          ? (info) {
              _performAction(
                attributes.onDoubleTapDown,
                type: GestureType.onDoubleTapDown,
                gestureInfo: info,
              );
            }
          : null,
      onDoubleTapCancel: attributes.onDoubleTapCancel != null
          ? () {
              _performAction(
                attributes.onDoubleTapCancel,
                type: GestureType.onDoubleTapCancel,
              );
            }
          : null,
      onLongPress: attributes.onLongPress != null
          ? () {
              _performAction(
                attributes.onLongPress,
                type: GestureType.onLongPress,
              );
            }
          : null,
      onLongPressStart: attributes.onLongPressStart != null
          ? (info) {
              _performAction(
                attributes.onLongPressStart,
                type: GestureType.onLongPressStart,
                gestureInfo: info,
              );
            }
          : null,
      onLongPressMoveUpdate: attributes.onLongPressMoveUpdate != null
          ? (info) {
              _performAction(
                attributes.onLongPressMoveUpdate,
                type: GestureType.onLongPressMoveUpdate,
                gestureInfo: info,
              );
            }
          : null,
      onLongPressUp: attributes.onLongPressUp != null
          ? () {
              _performAction(
                attributes.onLongPressUp,
                type: GestureType.onLongPressUp,
              );
            }
          : null,
      onLongPressEnd: attributes.onLongPressEnd != null
          ? (info) {
              _performAction(
                attributes.onLongPressEnd,
                type: GestureType.onLongPressEnd,
                gestureInfo: info,
              );
            }
          : null,
      onPanStart: attributes.onPanStart != null
          ? (info) {
              _performAction(
                attributes.onPanStart,
                type: GestureType.onPanStart,
                gestureInfo: info,
              );
            }
          : null,
      onPanDown: attributes.onPanDown != null
          ? (info) {
              _performAction(
                attributes.onPanDown,
                type: GestureType.onPanDown,
                gestureInfo: info,
              );
            }
          : null,
      onPanUpdate: attributes.onPanUpdate != null
          ? (info) {
              _performAction(
                attributes.onPanUpdate,
                type: GestureType.onPanUpdate,
                gestureInfo: info,
              );
            }
          : null,
      onPanEnd: attributes.onPanEnd != null
          ? (info) {
              _performAction(
                attributes.onPanEnd,
                type: GestureType.onPanEnd,
                gestureInfo: info,
              );
            }
          : null,
      onPanCancel: attributes.onPanCancel != null
          ? () {
              _performAction(
                attributes.onPanCancel,
                type: GestureType.onPanCancel,
              );
            }
          : null,
      behavior: attributes.behavior,
      dragStartBehavior: attributes.dragStartBehavior,
      excludeFromSemantics: attributes.excludeFromSemantics ?? false,
      child: widget.child,
    );
  }
}
