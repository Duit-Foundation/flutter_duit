import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";

class DuitLifecycleStateListener extends InheritedWidget
    with WidgetsBindingObserver {
  final UIElementController controller;

  DuitLifecycleStateListener({
    required Widget child,
    required this.controller,
  }) : super(child: child, key: Key(controller.id));

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final attrs = controller.attributes.payload;
    switch (state) {
      case AppLifecycleState.resumed:
        controller.performAction(attrs.getAction("onResumed"));
        break;
      case AppLifecycleState.inactive:
        controller.performAction(attrs.getAction("onInactive"));
        break;
      case AppLifecycleState.paused:
        controller.performAction(attrs.getAction("onPaused"));
        break;
      case AppLifecycleState.detached:
        controller.performAction(attrs.getAction("onDetached"));
        break;
      case AppLifecycleState.hidden:
        controller.performAction(attrs.getAction("onHidden"));
        break;
    }

    controller.performAction(attrs.getAction("onStateChanged"));
    super.didChangeAppLifecycleState(state);
  }

  static DuitLifecycleStateListener of(BuildContext context) {
    final result = context
        .dependOnInheritedWidgetOfExactType<DuitLifecycleStateListener>();
    assert(result != null, "No LifecycleStateListener found in context");
    return result!;
  }

  @override
  bool updateShouldNotify(covariant DuitLifecycleStateListener oldWidget) {
    return this != oldWidget;
  }
}
