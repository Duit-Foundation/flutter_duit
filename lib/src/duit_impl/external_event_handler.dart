import 'dart:async';

import 'package:flutter/cupertino.dart';

///An interface that defines a set of methods that, for some reason,
///cannot be processed by the library and cannot be implemented by the user.
abstract interface class ExternalEventHandler {
  FutureOr<void> handleNavigation(BuildContext context, String path, Object? extra);

  FutureOr<void> handleOpenUrl(String url);
}
