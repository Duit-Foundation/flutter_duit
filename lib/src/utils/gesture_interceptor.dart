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
  onVerticalDragStart,
  onVerticalDragDown,
  onVerticalDragUpdate,
  onVerticalDragEnd,
  onHorizontalDragStart,
  onHorizontalDragUpdate,
  onHorizontalDragEnd,
  onHorizontalDragCancel,
  onVerticalDragCancel,
  onPanStart,
  onPanDown,
  onPanUpdate,
  onPanEnd,
  onPanCancel,
  onScaleStart,
  onScaleUpdate,
  onScaleEnd
}

typedef GestureInterceptor = void Function(
  GestureType type, {
  Object? gestureInfo,
});
