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
  //InkWell spec
  onSecondaryTapDown,
  onSecondaryTapCancel,
  onSecondaryTap,
  onSecondaryTapUp
}

///Properties enum that determine how the interceptor will be invoked
enum GestureInterceptorBehavior {
  ///The interceptor will only be called if [ServerAction] != null
  onlyWithAction,

  ///The interceptor will be called regardless of the presence of [ServerAction]
  always,
}

typedef GestureInterceptor = void Function(
  GestureType type, {
  Object? gestureInfo,
});

abstract class GestureInterceptionLogic {
  abstract final GestureInterceptor? gestureInterceptor;
  abstract final GestureInterceptorBehavior gestureInterceptorBehavior;
}
