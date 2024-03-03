import 'dart:convert';
import 'dart:typed_data';

import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter_duit/src/utils/index.dart';

class TaskHandler {
  static (int, Object?) perform(Task? message) {
    if (message == null) return (0, null);

    switch (message.key) {
      case "parseJson":
        final res = switch (message.payload) {
          String() => jsonDecode(message.payload) as Map<String, dynamic>,
          Uint8List() =>
            jsonDecode(utf8.decode(message.payload)) as Map<String, dynamic>,
          Map() => message.payload,
          Object() || null => null,
        };

        return (message.taskId, res);
      case "fillComponentProperties":
        final res = JsonUtils.fillComponentProperties(
          message.payload["layout"],
          message.payload["data"],
        );

        return (message.taskId, res);
    }
    return (0, null);
  }
}
