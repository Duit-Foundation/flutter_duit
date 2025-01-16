import "package:flutter/foundation.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/animations/index.dart";

mixin OnAnimationEnd {
  VoidCallback? onEndHandler<T extends ImplicitAnimatable>(
    UIElementController<T> controller,
  ) {
    final action = controller.attributes.payload.onEnd;

    if (action == null) {
      return null;
    }

    return () => controller.performAction(action);
  }
}
