enum GestureType {
  onTap,
  onTapDown,
  onTapUp,
  onTapCancel,
  onDoubleTap,
  onDoubleTapDown,
  onDoubleTapCancel,
  onLongPressDown,
  onLongPressCancel,
  onLongPress,
  onLongPressStart,
  onLongPressMoveUpdate,
  onLongPressUp,
  onLongPressEnd,
  onPanStart,
  onPanDown,
  onPanUpdate,
  onPanEnd,
  onPanCancel,
}

typedef GestureInterceptor = void Function(
  GestureType type, {
  Object? gestureInfo,
});
