import "dart:async";

import "package:flutter/foundation.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/animations/index.dart";

mixin OnAnimationEnd {
  VoidCallback? onEndHandler<T extends ImplicitAnimatable>(
    ServerAction? action,
    FutureOr<void> Function(ServerAction? action) performFn,
  ) {
    if (action == null) {
      return null;
    }

    return () => performFn(action);
  }
}
