import "dart:async";

import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/widgets.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitActionManager with ServerActionExecutionCapabilityDelegate {
  late final UIDriver _driver;
  final _dataSources = <int, StreamSubscription<ServerEvent>>{};
  UserDefinedEventHandler? _navigationHandler,
      _openUrlHandler,
      _customEventHandler;

  Future<ServerEvent?> _executeAction(
    ServerAction action,
  ) async {
    switch (action) {
      //transport
      case TransportAction(
          :final dependsOn,
        ):
        try {
          final payload = _driver.preparePayload(dependsOn);
          final res = await _driver.executeRemoteAction(action, payload);

          if (res != null) {
            return ServerEvent.parseEvent(res);
          }
          return null;
        } catch (e, s) {
          _driver.logError(
            "[Error while executing transport action]",
            e,
            s,
          );
        }
        break;
      //local execution
      case LocalAction(
          :final event,
        ):
        return event;
      //script
      case ScriptAction(
          :final dependsOn,
          :final script,
          :final eventName,
        ):
        try {
          final body = _driver.preparePayload(dependsOn);

          final scriptInvocationResult = await _driver.scriptRunner?.runScript(
            script.functionName,
            url: eventName,
            meta: action.script.meta,
            body: body,
          );

          if (scriptInvocationResult != null) {
            return ServerEvent.parseEvent(scriptInvocationResult);
          }
          return null;
        } catch (e, s) {
          _driver.logError(
            "[Error while executing script action]",
            e,
            s,
          );
        }
        break;
    }
    return null;
  }

  @override
  Map<String, dynamic> preparePayload(
    Iterable<ActionDependency> dependencies,
  ) {
    final payload = <String, dynamic>{};

    if (dependencies.isNotEmpty) {
      for (final dependency in dependencies) {
        final controller = _driver.getController(dependency.id);
        if (controller != null) {
          final attribute = controller.attributes.payload;
          payload[dependency.target] = attribute["value"];
        }
      }
    }
    return payload;
  }

  @override
  Future<void> resolveEvent(BuildContext context, eventData) async {
    ServerEvent event;

    if (eventData is ServerEvent) {
      event = eventData;
    } else {
      event = ServerEvent.parseEvent(eventData);
    }

    try {
      switch (event) {
        case UpdateEvent(
            :final updates,
          ):
          for (final MapEntry(:key, :value) in updates.entries) {
            _driver.updateAttributes(key, value);
          }
          break;
        case NavigationEvent(
            :final path,
            :final extra,
          ):
          if (_navigationHandler != null) {
            await _navigationHandler!(context, path, extra);
          } else {
            _driver.logWarning(
              "NavigationEvent received but no handler attached",
            );
          }
          break;
        case OpenUrlEvent(
            :final url,
          ):
          if (_openUrlHandler != null) {
            await _openUrlHandler!(context, url, const {});
          } else {
            _driver.logWarning(
              "OpenUrlEvent received but no handler attached",
            );
          }
          break;
        case CustomEvent(
            :final key,
            :final extra,
          ):
          if (_driver.isModule) {
            await _driver.driverChannel?.invokeMethod<Map<String, dynamic>>(
              key,
              extra,
            );
          } else {
            if (_customEventHandler != null) {
              await _customEventHandler!(context, key, extra);
            } else {
              _driver.logWarning(
                "CustomEvent received but no handler attached",
              );
            }
          }
          break;
        case SequencedEventGroup(
            :final events,
          ):
          for (final entry in events) {
            if (context.mounted) {
              await resolveEvent(context, entry.event);
              await Future.delayed(entry.delay);
            }
          }
          break;
        case CommonEventGroup(
            :final events,
          ):
          for (final entry in events) {
            await resolveEvent(context, entry.event);
          }
          break;
        case CommandEvent(
            :final command,
          ):
          final c = _driver.getController(command.controllerId);
          await c?.emitCommand(command);
          break;
        case TimerEvent(
            :final timerDelay,
            :final payload,
          ):
          Future.delayed(
            timerDelay,
            () async {
              if (context.mounted) {
                await resolveEvent(context, payload);
              }
            },
          );
          break;
        default:
          break;
      }
    } catch (e, s) {
      _driver.logError(
        "Error while resolving ${event.type} event",
        e,
        s,
      );
    }
  }

  @override
  Future<void> execute(ServerAction action) async {
    try {
      final event = await _executeAction(
        action,
      );

      final ctx = _driver.buildContext;
      if (event != null && ctx.mounted) {
        resolveEvent(ctx, event);
      }
    } catch (e, s) {
      _driver.logError(
        "Error executing action",
        e,
        s,
      );
    }
  }

  @override
  void addExternalEventStream(
    Stream<Map<String, dynamic>> stream,
  ) {
    final id = stream.hashCode;

    _dataSources[id] = stream.map(ServerEvent.parseEvent).listen(
      (event) {
        if (event is NullEvent) {
          throw const NullEventException("NullEvent received from data source");
        }
        resolveEvent(
          // ignore: use_build_context_synchronously
          _driver.buildContext,
          event,
        );
      },
      onDone: () => _cancelSub(id),
      onError: (e, s) => _cancelSub(id),
    );
  }

  @preferInline
  void _cancelSub(int code) => _dataSources.remove(code)?.cancel();

  @override
  void releaseResources() {
    for (final subscription in _dataSources.values) {
      subscription.cancel();
    }
    _dataSources.clear();
  }

  @override
  void attachExternalHandler(
    UserDefinedHandlerKind type,
    UserDefinedEventHandler handle,
  ) {
    switch (type) {
      case UserDefinedHandlerKind.navigation:
        _navigationHandler = handle;
        break;
      case UserDefinedHandlerKind.openUrl:
        _openUrlHandler = handle;
        break;
      case UserDefinedHandlerKind.custom:
        _customEventHandler = handle;
        break;
    }
  }

  @override
  void linkDriver(UIDriver driver) => _driver = driver;
}
