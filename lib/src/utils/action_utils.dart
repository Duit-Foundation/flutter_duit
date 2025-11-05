import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/duit_impl/view_context.dart';

/// Utility functions for handling actions in Flutter Duit.
///
/// This library provides utilities for managing and executing actions
/// within the Flutter Duit framework. It includes functionality for
/// action handling, gesture processing, and action execution.
///
/// Example usage:
/// ```dart
/// // Using ActionHandler mixin
/// class MyWidget extends StatefulWidget with ActionHandler {
///   @override
///   Widget build(BuildContext context) {
///     return GestureDetector(
///       onTap: performAction(
///         context,
///         controller,
///         action,
///         type: GestureType.tap,
///       ),
///       child: Container(),
///     );
///   }
/// }
/// ```
///
/// The [ActionHandler] mixin provides a convenient way to handle actions
/// with gesture interception and async execution support.

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
