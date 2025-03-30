import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/duit_impl/view_context.dart';

extension type ActionUtils(Map<String, dynamic> json) {
  ServerAction? parseAction(String key) {
    final Map<String, dynamic>? action = json[key];
    if (action == null) return null;
    return ServerAction.parse(action);
  }
}

mixin ActionHandler {
  void Function([Object? gestureInfo])? performAction(
    BuildContext context,
    UIElementController controller,
    ServerAction? action, {
    required GestureType type,
    bool performActionAsync = false,
  }) {
    if (action == null) return null;

    void performer([Object? gestureInfo]) {
      final viewCtx = DuitViewContext.of(context);

      if (viewCtx.gestureInterceptorBehavior ==
          GestureInterceptorBehavior.onlyWithAction) {
        viewCtx.gestureInterceptor?.call(type, gestureInfo: gestureInfo);

        performActionAsync
            ? controller.performActionAsync(action)
            : controller.performAction(action);
        return;
      }

      viewCtx.gestureInterceptor?.call(type, gestureInfo: gestureInfo);
      performActionAsync
          ? controller.performActionAsync(action)
          : controller.performAction(action);
    }

    return performer;
  }
}
