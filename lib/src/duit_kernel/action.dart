import 'package:flutter_duit/src/utils/index.dart';

/// Represents the metadata for an HTTP action.
///
/// The [HttpActionMetainfo] class contains information about the HTTP method to be used for the action.
final class HttpActionMetainfo {
  String method;

  HttpActionMetainfo({required this.method});

  static HttpActionMetainfo? fromJson(JSONObject? json) {
    if (json == null) return null;

    return HttpActionMetainfo(method: json["method"] ?? "GET");
  }
}

/// Represents a dependency for a server action.
///
/// The [ActionDependency] class contains information about the dependency target and ID.
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

/// Represents a server action.
///
/// The [ServerAction] class encapsulates information about a server action, including its dependencies, event, and metadata.
final class ServerAction {
  /// The list of dependencies for the server action.
  List<ActionDependency> dependsOn;

  /// The event associated with the server action.
  String event;

  /// The event associated with the server action.
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
