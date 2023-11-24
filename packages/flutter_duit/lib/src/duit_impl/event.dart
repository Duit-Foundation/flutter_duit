import 'package:flutter_duit/src/utils/index.dart';

class WidgetsUpdateSet {
  Map<String, dynamic> updates;

  WidgetsUpdateSet({
    required this.updates,
  });

  static WidgetsUpdateSet? fromJson(JSONObject? json) {
    if (json == null) return null;

    return WidgetsUpdateSet(updates: json["updates"]);
  }
}

enum ServerEventType {
  update,
  // navigate,
  // openUrl,
}

abstract class ServerEvent {
  abstract ServerEventType type;

  static ServerEvent? fromJson(JSONObject? json) {
    if (json == null) return null;

    final type = json["type"] as String;

    final event = switch (type) {
      "update" => UpdateEvent.fromJson(json),
      // "navigate" => NavigateEvent.fromJson(json),
      // "openUrl" => OpenUrlEvent.fromJson(json),
      String() => null,
    };

    if (event != null) {
      return event;
    }

    return null;
  }
}

final class UpdateEvent extends ServerEvent {
  @override
  ServerEventType type = ServerEventType.update;

  Map<String, dynamic> updates;

  UpdateEvent({
    required this.updates,
  });

  factory UpdateEvent.fromJson(JSONObject json) {
    return UpdateEvent(updates: json["updates"]);
  }
}

// final class NavigateEvent extends ServerEvent {
//   @override
//   ServerEventType type = ServerEventType.navigate;
//
//   String url;
//
//   Map<String, dynamic>? params;
//
//   NavigateEvent({
//     required this.url,
//     this.params,
//   });
//
//   factory NavigateEvent.fromJson(JSONObject json) {
//     return NavigateEvent(
//       url: json["url"],
//       params: json["params"],
//     );
//   }
// }

// final class OpenUrlEvent {
//   @override
//   ServerEventType type = ServerEventType.openUrl;
//
//   String url;
//
//   OpenUrlEvent({
//     required this.url,
//   });
//
//   factory OpenUrlEvent.fromJson(JSONObject json) {
//     return OpenUrlEvent(
//       url: json["url"],
//     );
//   }
// }
