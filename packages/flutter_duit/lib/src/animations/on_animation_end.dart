import "dart:async";

import "package:flutter/foundation.dart";
import "package:flutter_duit/flutter_duit.dart";

mixin OnAnimationEnd {
  VoidCallback? onEndHandler(
    ServerAction? action,
    FutureOr<void> Function(ServerAction? action) performFn,
  ) {
    if (action == null) {
      return null;
    }

    return () => performFn(action);
  }
}
