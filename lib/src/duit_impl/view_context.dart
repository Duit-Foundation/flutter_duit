import "package:flutter/material.dart";
import "package:flutter_duit/src/utils/gesture_interceptor.dart";

class DuitViewContext extends InheritedWidget {
  final GestureInterceptor? gestureInterceptor;

  const DuitViewContext({
    super.key,
    required Widget child,
    this.gestureInterceptor,
  }) : super(child: child);

  static DuitViewContext of(BuildContext context) {
    final DuitViewContext? result =
        context.dependOnInheritedWidgetOfExactType<DuitViewContext>();
    assert(result != null, 'No ViewContext found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(DuitViewContext oldWidget) {
    return this != oldWidget;
  }
}
