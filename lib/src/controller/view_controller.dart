import 'dart:async';

import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_duit/src/utils/invoker.dart';
import 'package:flutter_duit/src/controller/index.dart';

/// The controller for a UI element.
///
/// This class is responsible for managing the state and behavior of a UI element.
/// It implements the [UIElementController] interface and uses the [ChangeNotifier]
/// mixin to provide change notification to listeners.
final class ViewController<T>
    with ChangeNotifier, ActionInvoker
    implements UIElementController {
  /// The attributes associated with the UI element.
  ///
  /// This property holds the attributes of the UI element that the `ViewController` controls.
  /// It can be used to access and modify the attributes of the UI element.
  @override
  ViewAttribute attributes;

  /// The server action associated with the UI element.
  ///
  /// This property holds the server action that is triggered when the UI element is interacted with.
  @override
  ServerAction? action;

  /// The driver that controls the UI element.
  ///
  /// This property holds the driver object that is responsible for interacting with the UI element.
  @override
  UIDriver driver;

  /// The unique identifier of the UI element.
  ///
  /// This property holds the unique identifier that is assigned to the UI element.
  @override
  String id;

  /// The type of the UI element.
  ///
  /// This property holds the type of the UI element that the `ViewController` controls.
  @override
  String type;

  /// The tag associated with the UI element.
  ///
  /// This property holds an optional tag that can be used to further categorize the UI element.
  @override
  String? tag;

  /// Creates a new instance of the `ViewController` class.
  ///
  /// The [id] parameter specifies the unique identifier of the UI element.
  /// The [driver] parameter specifies the driver that controls the UI element.
  /// The [type] parameter specifies the type of the UI element.
  /// The [action] parameter specifies the server action associated with the UI element.
  /// The [attributes] parameter specifies the initial attributes of the UI element.
  /// The [tag] parameter specifies the tag associated with the UI element.
  ViewController({
    required this.id,
    required this.driver,
    required this.type,
    required this.attributes,
    this.action,
    this.tag,
  });

  /// Updates the state of the UI element with new attributes.
  ///
  /// The [newAttrs] parameter specifies the new attributes to be applied to the UI element.
  @override
  void updateState(Map<String, dynamic> newState) {
    attributes.payload.addAll(newState);
    notifyListeners();
  }

  void _perform(ServerAction action) {
    final opts = action.executionOptions;
    if (opts != null) {
      switch (opts.modifier) {
        case ExecutionModifier.throttle:
          throttleWithArgs(
            action.eventName,
            (arg) => driver.execute(arg),
            action,
            duration: opts.duration,
          );
          break;
        case ExecutionModifier.debounce:
          debounceWithArgs(
            action.eventName,
            (arg) => driver.execute(arg),
            action,
            duration: opts.duration,
          );
          break;
        default:
          driver.execute(action);
          break;
      }
    } else {
      driver.execute(action);
    }
  }

  FutureOr<void> _performAsync(ServerAction action) async {
    final opts = action.executionOptions;
    if (opts != null) {
      switch (opts.modifier) {
        case ExecutionModifier.throttle:
          throttleWithArgs(
            action.eventName,
            (arg) async => await driver.execute(arg),
            action,
            duration: opts.duration,
          );
          break;
        case ExecutionModifier.debounce:
          debounceWithArgs(
            action.eventName,
            (arg) async => await driver.execute(arg),
            action,
            duration: opts.duration,
          );
          break;
        default:
          await driver.execute(action);
          break;
      }
    } else {
    } else {
      await driver.execute(action);
    }
    }
  }

  /// Performs the related action of the UI element.
  ///
  /// This method is called when the UI element is interacted with and the associated
  /// server action is not null. It executes the server action using the driver.
  @override
  void performRelatedAction() {
    try {
      if (action != null) {
        _perform(action!);
      }
    } catch (e, s) {
      driver.logger?.error(
        "Error while perform performRelatedAction method",
        error: e,
        stackTrace: s,
      );
    }
  }

  @override
  Future<void> performRelatedActionAsync() async {
    try {
      if (action != null) {
        await _performAsync(action!);
      }
    } catch (e, s) {
      driver.logger?.error(
        "Error while perform performRelatedActionAsync method",
        error: e,
        stackTrace: s,
      );
    }
  }

  @override
  void performAction(ServerAction? action) {
    try {
      if (action != null) {
        _perform(action);
      }
    } catch (e, s) {
      driver.logger?.error(
        "Error while performing performAction method",
        error: e,
        stackTrace: s,
      );
    }
  }

  @override
  Future<void> performActionAsync(ServerAction? action) async {
    try {
      if (action != null) {
        await _performAsync(action);
      }
    } catch (e, s) {
      driver.logger?.error(
        "Error while performing performActionAsync method",
        error: e,
        stackTrace: s,
      );
    }
  }

  @override
  void detach() {
    driver.detachController(id);
    cancelAll();
  }

  @override
  late final StreamController<RemoteCommand> commandChannel;

  @override
  FutureOr<void> emitCommand(RemoteCommand command) async {
    try {
      final specifiedCommand = SpecCommand(command).specify();
      commandChannel.add(specifiedCommand);
    } catch (e, s) {
      driver.logger
          ?.error("Error while emitting command", error: e, stackTrace: s);
    }
  }

  @override
  void removeCommandListener() => commandChannel.close();

  @override
  void listenCommand(CommandListener callback) {
    commandChannel = StreamController<RemoteCommand>()..stream.listen(callback);
  }
}

typedef CommandListener = Future<void> Function(RemoteCommand command);
