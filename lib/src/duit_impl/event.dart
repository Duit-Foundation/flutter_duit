import 'dart:convert';

import 'package:flutter_duit/src/duit_impl/index.dart';
import 'package:flutter_duit/src/ui/models/ui_tree.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// Represents the type of a server event.
enum ServerEventType {
  update,
  layoutUpdate,
  // navigate,
  // openUrl,
}

/// Represents a server response event.
abstract class ServerEvent {
  /// The type of the server event.
  abstract ServerEventType type;

  /// Creates a [ServerEvent] object from a JSON object.
  ///
  /// The [json] parameter is a JSON object representing the server event.
  /// Returns a [ServerEvent] object if the JSON object is valid and represents
  /// a recognized server event type, otherwise returns `null`.
  static ServerEvent? fromJson(JSONObject? json, UIDriver driver) {
    if (json == null) return null;

    final type = json["type"];

    final event = switch (type) {
      "update" => UpdateEvent.fromJson(json),
      "updateLayout" => LayoutUpdateEvent.fromJson(json, driver),
      // "navigate" => NavigateEvent.fromJson(json),
      // "openUrl" => OpenUrlEvent.fromJson(json),
      String() || Object() || null => null,
    };

    if (event != null) {
      return event;
    }

    return null;
  }
}

/// Represents an update event.
final class UpdateEvent extends ServerEvent {
  @override
  ServerEventType type = ServerEventType.update;

  /// The updates associated with the event.
  Map<String, dynamic> updates;

  /// Constructs an [UpdateEvent] object with the specified updates.
  ///
  /// The [updates] parameter is a map of key-value pairs representing the updates.
  UpdateEvent({
    required this.updates,
  });

  /// Creates an [UpdateEvent] object from a JSON object.
  ///
  /// The [json] parameter is a JSON object representing the update event.
  /// Returns an [UpdateEvent] object if the JSON object is valid, otherwise throws an exception.
  factory UpdateEvent.fromJson(JSONObject json) {
    return UpdateEvent(updates: json["updates"]);
  }
}

final class LayoutUpdateEvent extends ServerEvent {
  @override
  ServerEventType type = ServerEventType.layoutUpdate;

  DuitAbstractTree? layout;

  LayoutUpdateEvent(this.layout);

  /// Creates an [LayoutUpdateEvent] object from a JSON object.
  ///
  /// The [json] parameter is a JSON object representing the update event.
  /// Returns an [LayoutUpdateEvent] object if the JSON object is valid, otherwise throws an exception.
  factory LayoutUpdateEvent.fromJson(JSONObject json, UIDriver driver) {
    final layout = DuitAbstractTree(
      json: jsonDecode(json["layout"]),
      driver: driver,
    );
    return LayoutUpdateEvent(layout);
  }
}

//<editor-fold desc="unimplemented">
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
//</editor-fold>
