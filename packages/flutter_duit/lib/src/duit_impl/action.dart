import 'package:flutter_duit/src/utils/index.dart';

final class ActionDependency {
  String id;
  String target;

  ActionDependency({
    required this.target,
    required this.id,
  });

  factory ActionDependency.fromJSON(JSONObject json) {
    return ActionDependency(
      target: json["target"],
      id: json["id"],
    );
  }
}

final class ServerAction {
  List<ActionDependency> dependsOn;
  String event;

  ServerAction({
    required this.event,
    this.dependsOn = const [],
  });

  factory ServerAction.fromJSON(JSONObject? json) {
    List<ActionDependency> deps = [];

    if (json?["dependsOn"] != null) {
      json?["dependsOn"].forEach((el) {
        final it = ActionDependency.fromJSON(el);
        deps.add(it);
      });
    }

    return ServerAction(
      event: json?["event"] ?? "",
      dependsOn: deps,
    );
  }
}
