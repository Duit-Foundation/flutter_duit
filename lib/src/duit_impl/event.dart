import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter_duit/src/animations/animation_command.dart';
import 'package:flutter_duit/src/animations/animation_method.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class EventParser implements Parser<ServerEvent> {
  @override
  ServerEvent parse(JSONObject json) {
    final type = json["type"];

    return switch (type) {
      "update" => UpdateEvent.fromJson(json),
      "navigation" => NavigationEvent.fromJson(json),
      "openUrl" => OpenUrlEvent.fromJson(json),
      "custom" => CustomEvent.fromJson(json),
      "sequenced" => SequencedEventGroup.fromJson(json),
      "grouped" => CommonEventGroup.fromJson(json),
      "animationTrigger" => AnimationTriggerEvent.fromJson(json),
      "timer" => TimerEvent.fromJson(json),
      String() || Object() || null => NullEvent(),
    };
  }
}

final class NullEvent extends ServerEvent {
  NullEvent() : super(type: "null_event");
}

/// Represents an update event.
final class UpdateEvent extends ServerEvent {
  /// The updates associated with the event.
  Map<String, dynamic> updates;

  /// Constructs an [UpdateEvent] object with the specified updates.
  ///
  /// The [updates] parameter is a map of key-value pairs representing the updates.
  UpdateEvent({
    required this.updates,
  }) : super(type: "update");

  /// Creates an [UpdateEvent] object from a JSON object.
  ///
  /// The [json] parameter is a JSON object representing the update event.
  /// Returns an [UpdateEvent] object if the JSON object is valid, otherwise throws an exception.
  factory UpdateEvent.fromJson(JSONObject json) {
    return UpdateEvent(updates: json["updates"]);
  }
}

final class NavigationEvent extends ServerEvent {
  final String path;

  final Map<String, dynamic> extra;

  NavigationEvent({
    required this.path,
    required this.extra,
  }) : super(type: "navigation");

  factory NavigationEvent.fromJson(JSONObject json) {
    return NavigationEvent(
      path: json["path"] ?? "",
      extra: json["extra"] ?? {},
    );
  }
}

final class OpenUrlEvent extends ServerEvent {
  final String url;

  OpenUrlEvent({
    required this.url,
  }) : super(type: "openUrl");

  factory OpenUrlEvent.fromJson(JSONObject json) {
    return OpenUrlEvent(
      url: json["url"] ?? "",
    );
  }
}

final class CustomEvent extends ServerEvent {
  final String key;

  final Map<String, dynamic> extra;

  CustomEvent({
    required this.key,
    required this.extra,
  }) : super(type: "custom");

  factory CustomEvent.fromJson(JSONObject json) {
    return CustomEvent(
      key: json["key"] ?? "",
      extra: json["extra"] ?? {},
    );
  }
}

final class GroupMember {
  final ServerEvent event;

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

  CommonEventGroup({
    required this.events,
  }) : super(type: "grouped");

  factory CommonEventGroup.fromJson(JSONObject json) {
    final list = List.from(json["events"] ?? []);

    final events = list.map(
      (model) => GroupMember(event: ServerEvent.parseEvent(model)),
    );
    return CommonEventGroup(events: events.toList());
  }
}

final class SequencedEventGroup extends ServerEvent {
  final List<SequencedGroupMember> events;

  SequencedEventGroup({
    required this.events,
  }) : super(type: "sequenced");

  factory SequencedEventGroup.fromJson(JSONObject json) {
    final list = List.from(json["events"] ?? []);

    final events = list.map((model) {
      final delay = Duration(milliseconds: model["delay"] ?? 0);

      return SequencedGroupMember(
        event: ServerEvent.parseEvent(model["event"]),
        delay: delay,
      );
    });
    return SequencedEventGroup(events: events.toList());
  }
}

final class AnimationTriggerEvent extends ServerEvent {
  final AnimationCommand command;

  AnimationTriggerEvent({
    required this.command,
  }) : super(type: "animationTrigger");

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
  final Duration timerDelay;
  final ServerEvent payload;

  TimerEvent({
    required this.timerDelay,
    required this.payload,
  }) : super(type: "timer");

  factory TimerEvent.fromJson(JSONObject json) {
    return TimerEvent(
      timerDelay: Duration(milliseconds: json["timerDelay"] ?? 0),
      payload: ServerEvent.parseEvent(json["event"]),
    );
  }
}
