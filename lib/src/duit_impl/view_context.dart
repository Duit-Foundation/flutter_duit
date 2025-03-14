import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/utils/gesture_interceptor.dart";

class DuitViewContext extends InheritedWidget
    implements GestureInterceptionLogic {
  @override
  final GestureInterceptor? gestureInterceptor;

  @override
  final GestureInterceptorBehavior gestureInterceptorBehavior;

  final SliverGridDelegatesRegistry sliverGridDelegatesRegistry;

  final SliverChildListDelegateRegistry sliverChildListDelegateRegistry;

  const DuitViewContext({
    super.key,
    required Widget child,
    required this.gestureInterceptorBehavior,
    required this.sliverGridDelegatesRegistry,
    required this.sliverChildListDelegateRegistry,
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
