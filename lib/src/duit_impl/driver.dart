import "dart:async";

import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/duit_impl/hooks.dart";
import "package:flutter_duit/src/transport/index.dart";
import "package:flutter_duit/src/ui/models/attended_model.dart";
import "package:flutter_duit/src/ui/models/element_type.dart";
import "package:flutter_duit/src/ui/models/ui_tree.dart";
import "package:flutter_duit/src/utils/index.dart";
import "package:flutter_duit/src/animations/index.dart";

import "event.dart";

final class _DriverFinalizationController {
  final DuitDriver d;

  _DriverFinalizationController(this.d);

  void dispose() {
    d.dispose();
  }
}

final builder = {
  "controlled": true,
  "id": "57c52093-d7cb-4d6b-a26b-c9527fb83435",
  "type": "AnimatedBuilder",
  "child": {
    "type": "Container",
    "id": "cont",
    "controlled": false,
    "attributes": {
      "parentBuilderId": "57c52093-d7cb-4d6b-a26b-c9527fb83435",
      "affectedProperties": ["width"],
      "width": 10,
      "height": 100,
      "color": "#FDDDDD",
    },
  },
};

final data = {
  "controlled": true,
  "action": null,
  "id": "57c52093-d7cb-4d6b-a26b-c9527fb83435",
  "type": "AnimatedSize",
  "attributes": {
    "duration": 3000,
    "reverseDuration": 1500,
    "curve": "easeInOutCubicEmphasized",
  },
  "child": {
    "type": "Container",
    "id": "cont",
    "controlled": true,
    "attributes": {
      "width": 100,
      "height": 100,
      "color": "#FDDDDD",
    },
    "child": {
      "type": "Center",
      "id": "cntr",
      "child": {
        "type": "ElevatedButton",
        "id": "button",
        "action": {
          "executionType": 1,
          "payload": {
            "type": "update",
            "updates": {
              "cont": {
                "height": 300,
                "width": 300,
              },
            },
          },
        },
        "child": {
          "type": "Text",
          "id": "txt",
          "attributes": {
            "text": "Hello",
          },
        },
      }
    }
  }
};

final class DuitDriver with DriverHooks implements UIDriver {
  @protected
  @override
  final String source;

  @override
  Transport? transport;

  @protected
  @override
  TransportOptions transportOptions;

  @protected
  @override
  StreamController<DuitAbstractTree?> streamController =
      StreamController.broadcast();

  @protected
  @override
  late BuildContext buildContext;

  @override
  set context(BuildContext value) {
    buildContext = value;
  }

  DuitAbstractTree? _layout;

  @override
  bool concurrentModeEnabled;

  @protected
  @override
  WorkerPool? workerPool;

  @protected
  @override
  WorkerPoolConfiguration? workerPoolConfiguration;

  final Finalizer<_DriverFinalizationController> _driverFinalizer =
      Finalizer((d) => d.dispose());

  final Map<String, UIElementController> _viewControllers = {};

  @protected
  final ExternalEventHandler? eventHandler;

  @protected
  @override
  DuitScriptRunner? scriptRunner;

  @override
  Stream<DuitAbstractTree?> get stream =>
      streamController.stream.asBroadcastStream();

  @protected
  final Map<String, dynamic>? initialRequestPayload;

  DuitDriver(
    this.source, {
    required this.transportOptions,
    this.eventHandler,
    this.concurrentModeEnabled = false,
    this.workerPool,
    this.workerPoolConfiguration,
    this.initialRequestPayload,
  });

  @protected
  @override
  void attachController(String id, UIElementController controller) {
    final hasController = _viewControllers.containsKey(id);
    assert(!hasController,
        "ViewController with id already exists. You cannot attach controller to driver because it  contains element for id ($id)");

    _viewControllers[id] = controller;
  }

  /// Returns a transport based on the specified transport type.
  ///
  /// This method is used internally to create and return a transport object based
  /// on the specified [type]. It switches on the [type] parameter and returns an
  /// instance of the corresponding transport class.
  ///
  /// Parameters:
  /// - [type]: The transport type.
  ///
  /// Returns:
  /// - An instance of the transport class based on the specified [type].
  /// - If the [type] is not recognized, it returns an instance of [HttpTransport].
  Transport _getTransport(String type, {WorkerPool? workerPool}) {
    switch (type) {
      case TransportType.http:
        {
          return HttpTransport(
            source,
            concurrencyEnabled: concurrentModeEnabled,
            workerPool: workerPool,
            options: transportOptions as HttpTransportOptions,
          );
        }
      case TransportType.ws:
        {
          return WSTransport(
            source,
            workerPool: workerPool,
            concurrencyEnabled: concurrentModeEnabled,
            options: transportOptions as WebSocketTransportOptions,
          );
        }
      default:
        {
          return HttpTransport(
            source,
            concurrencyEnabled: concurrentModeEnabled,
            workerPool: workerPool,
            options: transportOptions as HttpTransportOptions,
          );
        }
    }
  }

  /// Resolves a server event from a JSON object.
  ///
  /// This method takes a [json] object representing a server event and converts
  /// it into a [ServerEvent] object. If the [json] object is valid and represents
  /// a recognized server event type, it creates an instance of the corresponding
  /// event class and assigns it to the [event] variable.
  ///
  /// Parameters:
  /// - [json]: The JSON object representing a server event.
  ///
  /// Returns: A [Future] that completes with [void].
  FutureOr<void> _resolveEvent(JSONObject? json) async {
    final event = ServerEvent.fromJson(json, this);
    onEventReceived?.call(event);
    if (event != null) {
      switch (event.type) {
        case ServerEventType.update:
          final updEvent = event as UpdateEvent;
          updEvent.updates.forEach((key, value) async {
            await _updateAttributes(key, value);
          });
          break;
        case ServerEventType.layoutUpdate:
          final layoutUpdateEvent = event as LayoutUpdateEvent;
          final newLayout = await layoutUpdateEvent.layout?.parse();

          if (newLayout != null) {
            _layout = newLayout;
            streamController.sink.add(_layout);
          }

          break;
        case ServerEventType.navigation:
          assert(eventHandler != null, "NavigationResolver is not set");
          final navEvent = event as NavigationEvent;
          await eventHandler?.handleNavigation(
            buildContext,
            navEvent.path,
            navEvent.extra,
          );
          break;
        case ServerEventType.openUrl:
          assert(eventHandler != null, "NavigationResolver is not set");
          final urlEvent = event as OpenUrlEvent;
          await eventHandler?.handleOpenUrl(urlEvent.url);
          break;
        case ServerEventType.custom:
          final customEvent = event as CustomEvent;
          await eventHandler?.handleCustomEvent(
            buildContext,
            customEvent.key,
            customEvent.extra,
          );
          break;
        case ServerEventType.sequenced:
          final sequence = event as SequencedEventGroup;
          for (final entry in sequence.events) {
            await _resolveEvent(entry.event);
            await Future.delayed(entry.delay);
          }
          break;
        case ServerEventType.grouped:
          final group = event as CommonEventGroup;
          for (final entry in group.events) {
            _resolveEvent(entry.event);
          }
          break;
        case ServerEventType.animationTrigger:
          final trigger = event as AnimationTriggerEvent;
          await _resolveAnimationTrigger(trigger);
          break;
      }
    }

    onEventHandled?.call();
  }

  Map<String, dynamic> _preparePayload(List<ActionDependency> deps) {
    final Map<String, dynamic> payload = {};

    if (deps.isNotEmpty) {
      for (final dependency in deps) {
        final controller = _viewControllers[dependency.id];
        if (controller != null) {
          if (controller.attributes?.payload is AttendedModel) {
            final model = controller.attributes?.payload as AttendedModel;
            payload[dependency.target] = model.collect();
          }
        }
      }
    }

    return payload;
  }

  Future<WorkerPool?> _getWorkerPool() async {
    if (concurrentModeEnabled) {
      if (workerPool != null) {
        return workerPool!;
      }

      final sharedPool = DuitRegistry.workerPool();
      if (sharedPool != null) {
        return workerPool = sharedPool;
      }

      return null;
    }
    return null;
  }

  @override
  Future<void> init() async {
    onInit?.call();
    if (_layout != null) {
      await Future.delayed(Duration.zero);
      streamController.sink.add(_layout);
    } else {
      ViewAttribute.attributeParser = AttributeParser();
      final wp = await _getWorkerPool();

      if (wp != null && wp.initialized == false) {
        assert(
            workerPoolConfiguration != null, "Worker pool is not configured");
        await wp.initWithConfiguration(workerPoolConfiguration!);
      }

      transport ??= _getTransport(
        transportOptions.type,
        workerPool: wp,
      );

      await scriptRunner?.initWithTransport(transport!);

      final json = await transport?.connect(
        initialData: initialRequestPayload,
      );
      assert(json != null);

      if (transport is Streamer) {
        final streamer = transport as Streamer;
        streamer.eventStream.listen(_resolveEvent);
      }

      _layout = DuitTree(json: builder, driver: this);
      streamController.sink.add(await _layout?.parse());

      _driverFinalizer.attach(
        this,
        _DriverFinalizationController(this),
        detach: this,
      );
    }
  }

  @override
  Widget? build() {
    return _layout?.render();
  }

  @override
  Future<void> execute(ServerAction action) async {
    beforeActionCallback?.call(action);

    switch (action.executionType) {
      //transport
      case 0:
        try {
          final payload = _preparePayload(action.dependsOn);

          final event = await transport?.execute(action, payload);
          //case with http request
          if (event != null) {
            await _resolveEvent(event);
          }
        } catch (e) {
          debugPrint(e.toString());
        }

        break;
      //local execution
      case 1:
        try {
          await _resolveEvent(action.payload);
        } catch (e) {
          debugPrint(e.toString());
        }
        break;
      //script
      case 2:
        try {
          final body = _preparePayload(action.dependsOn);
          final script = action.script as DuitScript;

          final scriptInvocationResult = await scriptRunner?.runScript(
            script.functionName,
            url: action.event,
            meta: action.script?.meta,
            body: body,
          );
          _resolveEvent(scriptInvocationResult);
        } catch (e) {
          debugPrint(e.toString());
        }

        break;
    }

    afterActionCallback?.call();
  }

  @override
  void dispose() {
    onDispose?.call();
    transport?.dispose();
    _viewControllers.clear();
    _layout = null;
    streamController.close();
    _driverFinalizer.detach(this);
  }

  Future<void> _resolveAnimationTrigger(AnimationTriggerEvent event) async {
    final controller = _viewControllers[event.command.controllerId];

    if (controller != null) {
      controller.emitCommand(event.command);
    }
  }

  Future<void> _resolveComponentUpdate(
    UIElementController controller,
    JSONObject json,
  ) async {
    final tag = controller.tag;
    final description = DuitRegistry.getComponentDescription(tag!);

    if (description != null) {
      Map<String, dynamic> component;

      if (concurrentModeEnabled) {
        final response = await workerPool!.perform((params) {
          return JsonUtils.fillComponentProperties(
            params["layout"],
            params["data"],
          );
        }, {
          "layout": description.data,
          "data": json,
        });
        component = response.result as Map<String, dynamic>;
      } else {
        component = JsonUtils.fillComponentProperties(
          description.data,
          json,
        );
      }

      final attributes = ViewAttribute.createAttributes(
        ElementType.subtree,
        component,
        tag,
      );

      controller.updateState(attributes);
    }
  }

  /// Updates the attributes of a controller.
  ///
  /// This method is called to update the attributes of a controller based on the
  /// provided [json] object.
  ///
  /// Parameters:
  /// - [id]: The id of the controller.
  /// - [json]: The json object containing the updated attributes.
  Future<void> _updateAttributes(String id, JSONObject json) async {
    final controller = _viewControllers[id];
    if (controller != null) {
      if (controller.type == ElementType.component) {
        await _resolveComponentUpdate(controller, json);
        return;
      }

      final attributes = ViewAttribute.createAttributes(
        controller.type,
        json,
        controller.tag,
      );

      print("ok");

      controller.updateState(attributes);
    }
  }

  @protected
  @override
  Future<void> evalScript(String source) async {
    await scriptRunner?.eval(source);
  }

  @protected
  @override
  void detachController(String id) {
    _viewControllers.remove(id);
  }

  @protected
  @override
  UIElementController? getController(String id) {
    return _viewControllers[id];
  }
}
