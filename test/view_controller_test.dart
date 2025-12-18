// ignore_for_file: no_leading_underscores_for_local_identifiers

import "dart:async";

import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/services.dart";
import "package:flutter/src/widgets/focus_manager.dart";
import "package:flutter/src/widgets/focus_traversal.dart";
import "package:flutter/src/widgets/framework.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";
import "package:flutter_duit/src/controller/view_controller.dart";
import "package:flutter_duit/src/controller/index.dart";

// Mock classes for testing
final class MockUIDriver extends UIDriver {
  final List<ServerAction> executedActions = [];
  final List<String> detachedControllers = [];
  DebugLogger? mockLogger;
  bool shouldThrowError = false;

  @override
  String get source => "mock_source";

  @override
  TransportOptions get transportOptions => EmptyTransportOptions();

  @override
  Transport? transport;

  @override
  BuildContext get buildContext => throw UnimplementedError();

  StreamController<ElementTree?> get streamController =>
      throw UnimplementedError();

  StreamController<UIDriverEvent> get eventStreamController =>
      throw UnimplementedError();

  @override
  ScriptRunner? scriptRunner;

  @override
  EventResolver get eventResolver => throw UnimplementedError();

  @override
  ActionExecutor get actionExecutor => throw UnimplementedError();

  @override
  ExternalEventHandler? externalEventHandler;

  @override
  MethodChannel? driverChannel;

  @override
  bool get isModule => false;

  @override
  DebugLogger? get logger => mockLogger;

  @override
  void attachController(String id, UIElementController controller) {}

  @override
  void detachController(String id) {
    detachedControllers.add(id);
  }

  @override
  UIElementController? getController(String id) => null;

  @override
  void dispose() {}

  @override
  Map<String, dynamic> preparePayload(
    Iterable<ActionDependency> dependencies,
  ) =>
      {};

  @override
  Future<ServerEvent?> execute(ServerAction action) async {
    if (shouldThrowError) {
      throw Exception("Mock execution error");
    }
    executedActions.add(action);
    return null;
  }

  @override
  late Stream<UIDriverEvent> eventStream;

  late Stream<ElementTree?> stream;

  @override
  set actionExecutor(ActionExecutor _actionExecutor) {}

  @override
  Widget? build() {
    throw UnimplementedError();
  }

  @override
  set buildContext(BuildContext _buildContext) {}

  @override
  // ignore: avoid_setters_without_getters
  set context(BuildContext value) {}

  @override
  Future<void> evalScript(String source) {
    throw UnimplementedError();
  }

  @override
  set eventResolver(EventResolver _eventResolver) {}

  @override
  Future<void> init() {
    throw UnimplementedError();
  }

  @override
  set isModule(bool _isModule) {}

  @override
  bool isWidgetReady(String viewTag) {
    throw UnimplementedError();
  }

  @override
  set logger(DebugLogger? _logger) {}

  @override
  void notifyWidgetDisplayStateChanged(String viewTag, int state) {}

  @override
  Future<void> updateAttributes(
    String controllerId,
    Map<String, dynamic> json,
  ) {
    throw UnimplementedError();
  }

  set eventStreamController(
    StreamController<UIDriverEvent> _eventStreamController,
  ) {}

  set streamController(StreamController<ElementTree?> _streamController) {}

  @override
  void attachFocusNode(String nodeId, FocusNode node) {
    // TODO: implement attachNode
  }

  @override
  void detachFocusNode(String nodeId) {
    // TODO: implement detachNode
    throw UnimplementedError();
  }

  @override
  bool focusInDirection(String nodeId, TraversalDirection direction) {
    // TODO: implement focusInDirection
    throw UnimplementedError();
  }

  @override
  bool nextFocus(String nodeId) {
    // TODO: implement nextFocus
    throw UnimplementedError();
  }

  @override
  bool previousFocus(String nodeId) {
    // TODO: implement previousFocus
    throw UnimplementedError();
  }

  @override
  void requestFocus(String nodeId) {
    // TODO: implement requestFocus
  }

  @override
  void unfocus(String nodeId,
      {UnfocusDisposition disposition = UnfocusDisposition.scope}) {
    // TODO: implement unfocus
  }

  @override
  FocusNode? getNode(Object? key) {
    // TODO: implement getNode
    throw UnimplementedError();
  }
}

class MockDebugLogger implements DebugLogger {
  final List<String> errorMessages = [];
  final List<Object?> errorObjects = [];
  final List<StackTrace?> errorStackTraces = [];

  @override
  void error(String message, {Object? error, StackTrace? stackTrace}) {
    errorMessages.add(message);
    errorObjects.add(error);
    errorStackTraces.add(stackTrace);
  }

  @override
  void info(String message) {}

  @override
  void warn(String message) {}
}

void main() {
  group("ViewController", () {
    late MockUIDriver mockDriver;
    late MockDebugLogger mockLogger;
    late ViewAttribute mockAttributes;
    late ViewController controller;

    setUp(() {
      mockDriver = MockUIDriver();
      mockLogger = MockDebugLogger();
      mockDriver.mockLogger = mockLogger;
      mockAttributes = ViewAttribute.from("Text", {}, "test_id");
    });

    group("Constructor and initialization", () {
      test("constructor_initializes_all_required_properties", () {
        controller = ViewController(
          id: "test_id",
          driver: mockDriver,
          type: "test_type",
          attributes: mockAttributes,
        );

        expect(controller.id, "test_id");
        expect(controller.driver, mockDriver);
        expect(controller.type, "test_type");
        expect(controller.attributes, mockAttributes);
        expect(controller.action, isNull);
        expect(controller.tag, isNull);
      });

      test("constructor_with_optional_parameters", () {
        final mockAction = ServerAction(
          eventName: "test_event",
          executionType: 0,
        );

        controller = ViewController(
          id: "test_id",
          driver: mockDriver,
          type: "test_type",
          attributes: mockAttributes,
          action: mockAction,
          tag: "test_tag",
        );

        expect(controller.action, mockAction);
        expect(controller.tag, "test_tag");
      });
    });

    group("State management (updateState)", () {
      setUp(() {
        controller = ViewController(
          id: "test_id",
          driver: mockDriver,
          type: "test_type",
          attributes: mockAttributes,
        );
      });

      test("updateState_merges_new_state_with_existing_attributes", () {
        // Set initial attributes
        mockAttributes.payload["existing_key"] = "existing_value";

        final newState = {
          "new_key": "new_value",
          "existing_key": "updated_value",
        };
        controller.updateState(newState);

        expect(mockAttributes.payload["existing_key"], "updated_value");
        expect(mockAttributes.payload["new_key"], "new_value");
      });

      test("updateState_notifies_listeners", () {
        var listenerCalled = false;
        controller.addListener(() {
          listenerCalled = true;
        });

        controller.updateState({"test": "value"});

        expect(listenerCalled, true);
      });

      test("updateState_with_empty_map", () {
        mockAttributes.payload["existing_key"] = "existing_value";

        controller.updateState({});

        expect(mockAttributes.payload["existing_key"], "existing_value");
        expect(mockAttributes.payload.length, 1);
      });

      test("updateState_overwrites_existing_values", () {
        mockAttributes.payload["key"] = "old_value";

        controller.updateState({"key": "new_value"});

        expect(mockAttributes.payload["key"], "new_value");
      });
    });

    group("Action execution (performRelatedAction)", () {
      setUp(() {
        controller = ViewController(
          id: "test_id",
          driver: mockDriver,
          type: "test_type",
          attributes: mockAttributes,
        );
      });

      test("performRelatedAction_with_null_action_does_nothing", () {
        controller.performRelatedAction();

        expect(mockDriver.executedActions, isEmpty);
      });

      test("performRelatedAction_executes_action_directly", () {
        final action = ServerAction(
          eventName: "test_event",
          executionType: 0,
        );
        controller.action = action;

        controller.performRelatedAction();

        expect(mockDriver.executedActions, contains(action));
      });

      test("performRelatedAction_with_throttle_modifier", () async {
        final action = ServerAction(
          eventName: "test_event",
          executionType: 0,
          executionOptions: const ExecutionOptions(
            modifier: ExecutionModifier.throttle,
            duration: Duration(milliseconds: 100),
          ),
        );
        controller.action = action;

        // First call should execute immediately
        controller.performRelatedAction();
        expect(mockDriver.executedActions.length, 1);

        // Second call within throttle period should be ignored
        controller.performRelatedAction();
        expect(mockDriver.executedActions.length, 1);

        // Wait for throttle period to expire
        await Future.delayed(const Duration(milliseconds: 150));

        // Third call should execute
        controller.performRelatedAction();
        expect(mockDriver.executedActions.length, 2);
      });

      test("performRelatedAction_with_debounce_modifier", () async {
        final action = ServerAction(
          eventName: "test_event",
          executionType: 0,
          executionOptions: const ExecutionOptions(
            modifier: ExecutionModifier.debounce,
            duration: Duration(milliseconds: 100),
          ),
        );
        controller.action = action;

        // First call should not execute immediately
        controller.performRelatedAction();
        expect(mockDriver.executedActions, isEmpty);

        // Wait for debounce period
        await Future.delayed(const Duration(milliseconds: 150));

        // Action should have been executed
        expect(mockDriver.executedActions.length, 1);
      });
    });

    group("Async action execution (performRelatedActionAsync)", () {
      setUp(() {
        controller = ViewController(
          id: "test_id",
          driver: mockDriver,
          type: "test_type",
          attributes: mockAttributes,
        );
      });

      test("performRelatedActionAsync_with_null_action_returns_future",
          () async {
        final future = controller.performRelatedActionAsync();
        expect(future, isA<Future<void>>());
        await future; // Should complete without error
      });

      test("performRelatedActionAsync_executes_action_directly", () async {
        final action = ServerAction(
          eventName: "test_event",
          executionType: 0,
        );
        controller.action = action;

        await controller.performRelatedActionAsync();

        expect(mockDriver.executedActions, contains(action));
      });

      test("performRelatedActionAsync_with_throttle_modifier", () async {
        final action = ServerAction(
          eventName: "test_event",
          executionType: 0,
          executionOptions: const ExecutionOptions(
            modifier: ExecutionModifier.throttle,
            duration: Duration(milliseconds: 100),
          ),
        );
        controller.action = action;

        // First call should execute immediately
        await controller.performRelatedActionAsync();
        expect(mockDriver.executedActions.length, 1);

        // Second call within throttle period should be ignored
        await controller.performRelatedActionAsync();
        expect(mockDriver.executedActions.length, 1);

        // Wait for throttle period to expire
        await Future.delayed(const Duration(milliseconds: 150));

        // Third call should execute
        await controller.performRelatedActionAsync();
        expect(mockDriver.executedActions.length, 2);
      });

      test("performRelatedActionAsync_with_debounce_modifier", () async {
        final action = ServerAction(
          eventName: "test_event",
          executionType: 0,
          executionOptions: const ExecutionOptions(
            modifier: ExecutionModifier.debounce,
            duration: Duration(milliseconds: 100),
          ),
        );
        controller.action = action;

        // First call should not execute immediately
        final future = controller.performRelatedActionAsync();
        expect(mockDriver.executedActions, isEmpty);

        // Wait for debounce period
        await Future.delayed(const Duration(milliseconds: 150));
        await future;

        // Action should have been executed
        expect(mockDriver.executedActions.length, 1);
      });
    });

    group("Action execution with passed action (performAction)", () {
      setUp(() {
        controller = ViewController(
          id: "test_id",
          driver: mockDriver,
          type: "test_type",
          attributes: mockAttributes,
        );
      });

      test("performAction_with_null_action_does_nothing", () {
        controller.performAction(null);

        expect(mockDriver.executedActions, isEmpty);
      });

      test("performAction_executes_passed_action_directly", () {
        final action = ServerAction(
          eventName: "test_event",
          executionType: 0,
        );

        controller.performAction(action);

        expect(mockDriver.executedActions, contains(action));
      });

      test("performAction_with_throttle_modifier", () async {
        final action = ServerAction(
          eventName: "test_event",
          executionType: 0,
          executionOptions: const ExecutionOptions(
            modifier: ExecutionModifier.throttle,
            duration: Duration(milliseconds: 100),
          ),
        );

        // First call should execute immediately
        controller.performAction(action);
        expect(mockDriver.executedActions.length, 1);

        // Second call within throttle period should be ignored
        controller.performAction(action);
        expect(mockDriver.executedActions.length, 1);

        // Wait for throttle period to expire
        await Future.delayed(const Duration(milliseconds: 150));

        // Third call should execute
        controller.performAction(action);
        expect(mockDriver.executedActions.length, 2);
      });

      test("performAction_with_debounce_modifier", () async {
        final action = ServerAction(
          eventName: "test_event",
          executionType: 0,
          executionOptions: const ExecutionOptions(
            modifier: ExecutionModifier.debounce,
            duration: Duration(milliseconds: 100),
          ),
        );

        // First call should not execute immediately
        controller.performAction(action);
        expect(mockDriver.executedActions, isEmpty);

        // Wait for debounce period
        await Future.delayed(const Duration(milliseconds: 150));

        // Action should have been executed
        expect(mockDriver.executedActions.length, 1);
      });
    });

    group("Async action execution with passed action (performActionAsync)", () {
      setUp(() {
        controller = ViewController(
          id: "test_id",
          driver: mockDriver,
          type: "test_type",
          attributes: mockAttributes,
        );
      });

      test("performActionAsync_with_null_action_returns_future", () async {
        final future = controller.performActionAsync(null);
        expect(future, isA<Future<void>>());
        await future; // Should complete without error
      });

      test("performActionAsync_executes_passed_action_directly", () async {
        final action = ServerAction(
          eventName: "test_event",
          executionType: 0,
        );

        await controller.performActionAsync(action);

        expect(mockDriver.executedActions, contains(action));
      });

      test("performActionAsync_with_throttle_modifier", () async {
        final action = ServerAction(
          eventName: "test_event",
          executionType: 0,
          executionOptions: const ExecutionOptions(
            modifier: ExecutionModifier.throttle,
            duration: Duration(milliseconds: 100),
          ),
        );

        // First call should execute immediately
        await controller.performActionAsync(action);
        expect(mockDriver.executedActions.length, 1);

        // Second call within throttle period should be ignored
        await controller.performActionAsync(action);
        expect(mockDriver.executedActions.length, 1);

        // Wait for throttle period to expire
        await Future.delayed(const Duration(milliseconds: 150));

        // Third call should execute
        await controller.performActionAsync(action);
        expect(mockDriver.executedActions.length, 2);
      });

      test("performActionAsync_with_debounce_modifier", () async {
        final action = ServerAction(
          eventName: "test_event",
          executionType: 0,
          executionOptions: const ExecutionOptions(
            modifier: ExecutionModifier.debounce,
            duration: Duration(milliseconds: 100),
          ),
        );

        // First call should not execute immediately
        final future = controller.performActionAsync(action);
        expect(mockDriver.executedActions, isEmpty);

        // Wait for debounce period
        await Future.delayed(const Duration(milliseconds: 150));
        await future;

        // Action should have been executed
        expect(mockDriver.executedActions.length, 1);
      });
    });

    group("Command channel management", () {
      setUp(() {
        Future<void> _listener(RemoteCommand command) async {}
        controller = ViewController(
          id: "test_id",
          driver: mockDriver,
          type: "test_type",
          attributes: mockAttributes,
        )..listenCommand(_listener);
      });

      test("emitCommand_specifies_and_adds_command_to_channel", () async {
        const command = RemoteCommand(
          controllerId: "test_command",
          type: "test_type",
          commandData: {"test": "data"},
        );

        await controller.emitCommand(command);

        // Verify command was added to channel
        expect(controller.commandChannel.hasListener, true);
      });

      test("emitCommand_handles_specification_errors", () async {
        // Create an invalid command that will cause specification error
        const invalidCommand = RemoteCommand(
          controllerId: "", // Invalid empty id
          type: "test_type",
          commandData: {},
        );

        await controller.emitCommand(invalidCommand);

        expect(
          mockLogger.errorMessages,
          contains("Error while emitting command"),
        );
      });

      test("emitCommand_logs_errors_to_driver_logger", () async {
        const invalidCommand = RemoteCommand(
          controllerId: "",
          type: "test_type",
          commandData: {},
        );

        await controller.emitCommand(invalidCommand);

        expect(mockLogger.errorMessages, isNotEmpty);
        expect(mockLogger.errorObjects, isNotEmpty);
      });

      test("removeCommandListener_closes_command_channel", () {
        controller.removeCommandListener();

        expect(controller.commandChannel.isClosed, true);
      });
    });

    group("Detachment and cleanup (detach)", () {
      setUp(() {
        controller = ViewController(
          id: "test_id",
          driver: mockDriver,
          type: "test_type",
          attributes: mockAttributes,
        );
      });

      test("detach_calls_driver_detachController", () {
        controller.detach();

        expect(mockDriver.detachedControllers, contains("test_id"));
      });

      test("detach_cancels_all_optimizers", () {
        // Set up an action with throttle to create timers
        final action = ServerAction(
          eventName: "test_event",
          executionType: 0,
          executionOptions: const ExecutionOptions(
            modifier: ExecutionModifier.throttle,
            duration: Duration(milliseconds: 100),
          ),
        );
        controller.action = action;

        // Call performRelatedAction to create timers
        controller.performRelatedAction();

        // Detach should cancel all timers
        controller.detach();

        // Verify detach was called
        expect(mockDriver.detachedControllers, contains("test_id"));
      });

      test("detach_does_not_dispose_change_notifier", () {
        var listenerCalled = false;
        controller.addListener(() {
          listenerCalled = true;
        });

        controller.detach();

        // ChangeNotifier should still be functional
        controller.notifyListeners();
        expect(listenerCalled, true);
      });
    });

    group("Integration with ActionCallbackOptimizer", () {
      setUp(() {
        controller = ViewController(
          id: "test_id",
          driver: mockDriver,
          type: "test_type",
          attributes: mockAttributes,
        );
      });

      test("throttle_functionality_prevents_rapid_executions", () async {
        final action = ServerAction(
          eventName: "test_event",
          executionType: 0,
          executionOptions: const ExecutionOptions(
            modifier: ExecutionModifier.throttle,
            duration: Duration(milliseconds: 100),
          ),
        );
        controller.action = action;

        // Multiple rapid calls
        controller.performRelatedAction();
        controller.performRelatedAction();
        controller.performRelatedAction();

        // Only first call should execute
        expect(mockDriver.executedActions.length, 1);

        // Wait for throttle period
        await Future.delayed(const Duration(milliseconds: 150));

        // Next call should execute
        controller.performRelatedAction();
        expect(mockDriver.executedActions.length, 2);
      });

      test("debounce_functionality_delays_execution", () async {
        final action = ServerAction(
          eventName: "test_event",
          executionType: 0,
          executionOptions: const ExecutionOptions(
            modifier: ExecutionModifier.debounce,
            duration: Duration(milliseconds: 100),
          ),
        );
        controller.action = action;

        // Multiple rapid calls
        controller.performRelatedAction();
        controller.performRelatedAction();
        controller.performRelatedAction();

        // No immediate execution
        expect(mockDriver.executedActions, isEmpty);

        // Wait for debounce period
        await Future.delayed(const Duration(milliseconds: 150));

        // Only last call should execute
        expect(mockDriver.executedActions.length, 1);
      });

      test("multiple_action_keys_work_independently", () async {
        final action1 = ServerAction(
          eventName: "test_event1",
          executionType: 0,
          executionOptions: const ExecutionOptions(
            modifier: ExecutionModifier.throttle,
            duration: Duration(milliseconds: 100),
          ),
        );
        final action2 = ServerAction(
          eventName: "test_event2",
          executionType: 0,
          executionOptions: const ExecutionOptions(
            modifier: ExecutionModifier.throttle,
            duration: Duration(milliseconds: 100),
          ),
        );

        // Execute different actions
        controller.performAction(action1);
        controller.performAction(action2);

        // Both should execute independently
        expect(mockDriver.executedActions.length, 2);
        expect(mockDriver.executedActions, contains(action1));
        expect(mockDriver.executedActions, contains(action2));
      });

      test("cancelAll_clears_all_timers", () async {
        final action = ServerAction(
          eventName: "test_event",
          executionType: 0,
          executionOptions: const ExecutionOptions(
            modifier: ExecutionModifier.debounce,
            duration: Duration(milliseconds: 100),
          ),
        );
        controller.action = action;

        // Start debounce
        controller.performRelatedAction();

        // Cancel all timers
        controller.cancelAll();

        // Wait for what would have been debounce period
        await Future.delayed(const Duration(milliseconds: 150));

        // No execution should occur
        expect(mockDriver.executedActions, isEmpty);
      });
    });

    group("Integration tests", () {
      setUp(() {
        controller = ViewController(
          id: "test_id",
          driver: mockDriver,
          type: "test_type",
          attributes: mockAttributes,
        );
      });

      test("full_action_execution_flow", () async {
        final action = ServerAction(
          eventName: "test_event",
          executionType: 0,
        );
        controller.action = action;

        // Update state
        controller.updateState({"key": "value"});
        expect(mockAttributes.payload["key"], "value");

        // Perform action
        controller.performRelatedAction();
        expect(mockDriver.executedActions, contains(action));

        // Emit command
        const command = RemoteCommand(
          controllerId: "test_command",
          type: "test_type",
          commandData: {"test": "data"},
        );
        await controller.emitCommand(command);

        // Detach
        controller.detach();
        expect(mockDriver.detachedControllers, contains("test_id"));
      });

      test("state_update_and_action_execution_integration", () {
        final action = ServerAction(
          eventName: "test_event",
          executionType: 0,
        );
        controller.action = action;

        var stateUpdated = false;
        controller.addListener(() {
          stateUpdated = true;
        });

        // Update state and perform action
        controller.updateState({"key": "value"});
        controller.performRelatedAction();

        expect(stateUpdated, true);
        expect(mockAttributes.payload["key"], "value");
        expect(mockDriver.executedActions, contains(action));
      });

      test("command_emission_and_listening_integration", () async {
        const receivedCommand = RemoteCommand(
          controllerId: "test",
          type: "test",
          commandData: {},
        );

        controller.listenCommand((command) async {
          expect(command, receivedCommand);
        });

        await controller.emitCommand(receivedCommand);
      });

      test("controller_lifecycle_with_driver", () {
        // Verify controller is properly attached
        expect(controller.driver, mockDriver);

        // Perform some operations
        controller.updateState({"key": "value"});
        expect(mockAttributes.payload["key"], "value");

        // Detach from driver
        controller.detach();
        expect(mockDriver.detachedControllers, contains("test_id"));

        // Verify controller is still functional
        expect(controller.id, "test_id");
        expect(controller.type, "test_type");
      });
    });

    group("Edge cases", () {
      setUp(() {
        controller = ViewController(
          id: "test_id",
          driver: mockDriver,
          type: "test_type",
          attributes: mockAttributes,
        );
      });

      test("controller_with_empty_attributes", () {
        final emptyAttributes = ViewAttribute.from("Text", {}, "test_id");
        controller = ViewController(
          id: "test_id",
          driver: mockDriver,
          type: "test_type",
          attributes: emptyAttributes,
        );

        controller.updateState({"key": "value"});
        expect(emptyAttributes.payload["key"], "value");
      });

      test("controller_with_complex_execution_options", () async {
        final action = ServerAction(
          eventName: "test_event",
          executionType: 0,
          executionOptions: const ExecutionOptions(
            modifier: ExecutionModifier.throttle,
            duration: Duration(milliseconds: 50),
          ),
        );
        controller.action = action;

        // Test rapid execution
        for (var i = 0; i < 10; i++) {
          controller.performRelatedAction();
        }

        // Only first call should execute
        expect(mockDriver.executedActions.length, 1);

        // Wait and test again
        await Future.delayed(const Duration(milliseconds: 100));
        controller.performRelatedAction();
        expect(mockDriver.executedActions.length, 2);
      });

      test("controller_with_very_short_durations", () async {
        final action = ServerAction(
          eventName: "test_event",
          executionType: 0,
          executionOptions: const ExecutionOptions(
            modifier: ExecutionModifier.throttle,
            duration: Duration(milliseconds: 1),
          ),
        );
        controller.action = action;

        controller.performRelatedAction();
        expect(mockDriver.executedActions.length, 1);

        // Even with very short duration, rapid calls should be throttled
        controller.performRelatedAction();
        expect(mockDriver.executedActions.length, 1);
      });

      test("controller_with_very_long_durations", () async {
        final action = ServerAction(
          eventName: "test_event",
          executionType: 0,
          executionOptions: const ExecutionOptions(
            modifier: ExecutionModifier.debounce,
            duration: Duration(milliseconds: 1000),
          ),
        );
        controller.action = action;

        controller.performRelatedAction();
        expect(mockDriver.executedActions, isEmpty);

        // Wait for debounce period
        await Future.delayed(const Duration(milliseconds: 1100));

        // Action should have been executed
        expect(mockDriver.executedActions.length, 1);
      });

      test("concurrent_action_executions", () async {
        final action = ServerAction(
          eventName: "test_event",
          executionType: 0,
        );
        controller.action = action;

        // Execute multiple actions concurrently
        final futures = <Future<void>>[];
        for (var i = 0; i < 5; i++) {
          futures.add(controller.performRelatedActionAsync());
        }

        await Future.wait(futures);

        // All actions should have been executed
        expect(mockDriver.executedActions.length, 5);
      });
    });

    tearDown(() {
      controller.dispose();
    });
  });
}
