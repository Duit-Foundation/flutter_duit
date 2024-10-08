import 'dart:convert';

import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter_duit/src/animations/animation_command.dart';
import 'package:flutter_duit/src/animations/animation_method.dart';
import 'package:flutter_duit/src/ui/models/ui_tree.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// Represents the type of a server event.
enum ServerEventType {
  update,
  layoutUpdate,
  navigation,
  openUrl,
  custom,
  sequenced,
  grouped,
  animationTrigger,
  timer,
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

    return switch (type) {
      "update" => UpdateEvent.fromJson(json),
      "updateLayout" => LayoutUpdateEvent.fromJson(json, driver),
      "navigation" => NavigationEvent.fromJson(json),
      "openUrl" => OpenUrlEvent.fromJson(json),
      "custom" => CustomEvent.fromJson(json),
      "sequenced" => SequencedEventGroup.fromJson(json),
      "grouped" => CommonEventGroup.fromJson(json),
      "animationTrigger" => AnimationTriggerEvent.fromJson(json),
      "timer" => TimerEvent.fromJson(json),
      String() || Object() || null => null,
    };
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
    final layout = DuitTree(
      json: json is String ? jsonDecode(json["layout"]) : json["layout"],
      driver: driver,
    );
    return LayoutUpdateEvent(layout);
  }
}

final class NavigationEvent extends ServerEvent {
  @override
  ServerEventType type = ServerEventType.navigation;

  final String path;

  final Map<String, dynamic> extra;

  NavigationEvent({
    required this.path,
    required this.extra,
  });

  factory NavigationEvent.fromJson(JSONObject json) {
    return NavigationEvent(
      path: json["path"] ?? "",
      extra: json["extra"] ?? {},
    );
  }
}

final class OpenUrlEvent extends ServerEvent {
  @override
  ServerEventType type = ServerEventType.openUrl;

  final String url;

  OpenUrlEvent({
    required this.url,
  });

  factory OpenUrlEvent.fromJson(JSONObject json) {
    return OpenUrlEvent(
      url: json["url"] ?? "",
    );
  }
}

final class CustomEvent extends ServerEvent {
  @override
  ServerEventType type = ServerEventType.custom;

  final String key;

  final Map<String, dynamic> extra;

  CustomEvent({
    required this.key,
    required this.extra,
  });

  factory CustomEvent.fromJson(JSONObject json) {
    return CustomEvent(
      key: json["key"] ?? "",
      extra: json["extra"] ?? {},
    );
  }
}

final class GroupMember {
  final JSONObject event;

  GroupMember({
    required this.event,
  });
}

final class SequencedGroupMember extends GroupMember {
  final Duration delay;

  SequencedGroupMember({
    required super.event,
    required this.delay,
  });
}

final class CommonEventGroup extends ServerEvent {
  final List<GroupMember> events;

  @override
  ServerEventType type = ServerEventType.grouped;

  CommonEventGroup({
    required this.events,
  });

  factory CommonEventGroup.fromJson(JSONObject json) {
    final list = List.from(json["events"] ?? []);

    final events = list.map((model) => GroupMember(event: model));
    return CommonEventGroup(events: events.toList());
  }
}

final class SequencedEventGroup extends ServerEvent {
  final List<SequencedGroupMember> events;

  @override
  ServerEventType type = ServerEventType.sequenced;

  SequencedEventGroup({
    required this.events,
  });

  factory SequencedEventGroup.fromJson(JSONObject json) {
    final list = List.from(json["events"] ?? []);

    final events = list.map((model) {
      final delay = Duration(milliseconds: model["delay"] ?? 0);

      return SequencedGroupMember(event: model["event"], delay: delay);
    });
    return SequencedEventGroup(events: events.toList());
  }
}

final class AnimationTriggerEvent extends ServerEvent {
  @override
  ServerEventType type = ServerEventType.animationTrigger;

  final AnimationCommand command;

  AnimationTriggerEvent({
    required this.command,
  });

  factory AnimationTriggerEvent.fromJson(JSONObject json) {
    return AnimationTriggerEvent(
      command: AnimationCommand(
        method: switch (json["method"]) {
          0 => AnimationMethod.forward,
          1 => AnimationMethod.repeat,
          2 => AnimationMethod.reverse,
          3 => AnimationMethod.toggle,
          Object() || null => AnimationMethod.forward,
        },
        controllerId: json["controllerId"],
        animatedPropKey: json["animatedPropKey"],
      ),
    );
  }
}

final class TimerEvent extends ServerEvent {
  @override
  ServerEventType type = ServerEventType.timer;

  final Duration timerDelay;
  final JSONObject event;

  TimerEvent({
    required this.timerDelay,
    required this.event,
  });

  factory TimerEvent.fromJson(JSONObject json) {
    return TimerEvent(
      timerDelay: Duration(milliseconds: json["timerDelay"] ?? 0),
      event: json["event"] ?? {},
    );
  }
}
