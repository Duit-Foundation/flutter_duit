import 'package:flutter_duit/src/utils/index.dart';

final class HttpActionMetainfo {
  String method;

  HttpActionMetainfo({required this.method});

  static HttpActionMetainfo? fromJson(JSONObject? json) {
    if (json == null) return null;

    return HttpActionMetainfo(method: json["method"] ?? "GET");
  }
}

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
  HttpActionMetainfo? meta;

  ServerAction({
    required this.event,
    this.dependsOn = const [],
    this.meta,
  });

   static ServerAction? fromJSON(JSONObject? json) {
     if (json == null) return null;

    List<ActionDependency> deps = [];

    if (json["dependsOn"] != null) {
      json["dependsOn"].forEach((el) {
        final it = ActionDependency.fromJSON(el);
        deps.add(it);
      });
    }

    return ServerAction(
      event: json["event"] ?? "",
      dependsOn: deps,
      meta: HttpActionMetainfo.fromJson(json["meta"]),
    );
  }

  @override
  String toString() {
    return 'ServerAction{dependsOn: $dependsOn, event: $event, meta: $meta}';
  }
}
