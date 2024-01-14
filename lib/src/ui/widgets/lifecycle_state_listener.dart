import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";

class DuitLifecycleStateListener extends InheritedWidget
    with WidgetsBindingObserver {
  final UIElementController controller;

  const DuitLifecycleStateListener({
    super.key,
    required Widget child,
    required this.controller,
  }) : super(child: child);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final attrs = controller.attributes as LifecycleStateListenerAttributes?;
    switch (state) {
      case AppLifecycleState.resumed:
        controller.performAction(attrs?.onResumed);
        break;
      case AppLifecycleState.inactive:
        controller.performAction(attrs?.onInactive);
        break;
      case AppLifecycleState.paused:
        controller.performAction(attrs?.onPaused);
        break;
      case AppLifecycleState.detached:
        controller.performAction(attrs?.onDetached);
        break;
      case AppLifecycleState.hidden:
        controller.performAction(attrs?.onHidden);
        break;
    }

    controller.performAction(attrs?.onStateChanged);
    super.didChangeAppLifecycleState(state);
  }

  static DuitLifecycleStateListener of(BuildContext context) {
    final DuitLifecycleStateListener? result = context
        .dependOnInheritedWidgetOfExactType<DuitLifecycleStateListener>();
    assert(result != null, 'No LifecycleStateListener found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant DuitLifecycleStateListener oldWidget) {
    return this != oldWidget;
  }
}
