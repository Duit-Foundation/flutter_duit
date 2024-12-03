import "dart:async";

import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
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

final class DuitDriver with DriverHooks implements UIDriver {
  //<editor-fold desc="Properties and Ctor">
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
  StreamController<ElementTree?> streamController =
      StreamController.broadcast();

  @protected
  @override
  late BuildContext buildContext;

  @override
  set context(BuildContext value) {
    buildContext = value;
  }

  ElementTree? _layout;

  final Finalizer<_DriverFinalizationController> _driverFinalizer =
      Finalizer((d) => d.dispose());

  final Map<String, UIElementController> _viewControllers = {};

  @protected
  final ExternalEventHandler? eventHandler;

  @protected
  @override
  ScriptRunner? scriptRunner;

  @override
  Stream<ElementTree?> get stream =>
      streamController.stream.asBroadcastStream();

  @protected
  final Map<String, dynamic>? initialRequestPayload;

  final bool _useStaticContent, _isModule;
  bool _isChannelInitialized = false;

  late final MethodChannel _driverChannel;

  @protected
  Map<String, dynamic>? content;

  DuitDriver(
    this.source, {
    required this.transportOptions,
    this.eventHandler,
    this.initialRequestPayload,
    bool enableDevMetrics = false,
  })  : _useStaticContent = false,
        _isModule = false;

  /// Creates a new instance of [DuitDriver] with the specified [content] without establishing a initial transport connection.
  DuitDriver.static(
    this.content, {
    required this.transportOptions,
    this.eventHandler,
    bool enableDevMetrics = false,
  })  : _useStaticContent = true,
        source = "",
        initialRequestPayload = null,
        _isModule = false;

  /// Creates a new [DuitDriver] instance that is controlled from native code
  DuitDriver.module()
      : _useStaticContent = false,
        source = "",
        initialRequestPayload = null,
        _isModule = true,
        eventHandler = null,
        transportOptions = EmptyTransportOptions(),
        _driverChannel = const MethodChannel("duit:driver");

  //</editor-fold">

  //<editor-fold desc="Controller related methods">
  @protected
  @override
  void attachController(String id, UIElementController controller) {
    final hasController = _viewControllers.containsKey(id);
    assert(!hasController,
        "ViewController with id already exists. You cannot attach controller to driver because it  contains element for id ($id)");

    _viewControllers[id] = controller;
  }

  @protected
  @override
  void detachController(String id) {
    _viewControllers.remove(id)?.dispose();
  }

  @protected
  @override
  UIElementController? getController(String id) {
    return _viewControllers[id];
  }

  //</editor-fold>

  //<editor-fold desc="Lifecycle methods">
  @override
  Future<void> init() async {
    onInit?.call();

    if (_layout != null) {
      await Future.delayed(Duration.zero);
      streamController.sink.add(_layout);
    } else {
      _addParsers();

      if (_isModule && !_isChannelInitialized) {
        await _initMethodChannel();
      }

      transport ??= _getTransport(
        transportOptions.type,
      );

      await scriptRunner?.initWithTransport(transport!);

      Map<String, dynamic>? json;

      if (_useStaticContent) {
        json = content;
      } else {
        json = await transport?.connect(
          initialData: initialRequestPayload,
        );
      }

      if (transport is Streamer) {
        final streamer = transport as Streamer;
        streamer.eventStream.listen(_resolveEvent);
      }

      _layout = DuitTree(json: json!, driver: this);

      try {
        streamController.sink.add(
          await _layout!.parse(),
        );
      } catch (e) {
        streamController.sink.addError(e);
      }

      _driverFinalizer.attach(
        this,
        _DriverFinalizationController(this),
        detach: this,
      );
    }
  }

  @override
  void dispose() {
    onDispose?.call();
    transport?.dispose();
    _viewControllers
      ..forEach((_, c) => c.dispose())
      ..clear();
    _layout = null;
    streamController.close();
    _driverFinalizer.detach(this);
  }

  @override
  Widget? build() {
    return _layout?.render();
  }

  void _addParsers() {
    try {
      ViewAttribute.attributeParser = AttributeParser();
      ServerEvent.eventParser = EventParser();
    } catch (_) {
      //Safely handle the case of assigning parsers during
      //multiple driver initializations as part of running tests
    }
  }

  //</editor-fold>

  //<editor-fold desc="Actions & Events">
  /// Resolves a server event from a JSON object.
  ///
  /// This method takes a [eventData] object representing a server event and converts
  /// it into a [ServerEvent] object. If the [eventData] object is valid and represents
  /// a recognized server event type, it creates an instance of the corresponding
  /// event class and assigns it to the [event] variable.
  ///
  /// Parameters:
  /// - [json]: The JSON object representing a server event.
  ///
  /// Returns: A [Future] that completes with [void].
  FutureOr<void> _resolveEvent(dynamic eventData) async {
    ServerEvent event;

    if (eventData is ServerEvent) {
      event = eventData;
    } else {
      event = ServerEvent.parseEvent(eventData);
    }

    onEventReceived?.call(event);
    switch (event) {
      case UpdateEvent():
        event.updates.forEach((key, value) async {
          await _updateAttributes(key, value);
        });
        break;
      case NavigationEvent():
        assert(
            eventHandler != null, "ExternalEventHandler instance is not set");
        await eventHandler?.handleNavigation(
          buildContext,
          event.path,
          event.extra,
        );
        break;
      case OpenUrlEvent():
        assert(
            eventHandler != null, "ExternalEventHandler instance is not set");
        await eventHandler?.handleOpenUrl(event.url);
        break;
      case CustomEvent():
        if (_isModule) {
          await emitNativeEvent(event.key, event.extra);
        } else {
          await eventHandler?.handleCustomEvent(
            buildContext,
            event.key,
            event.extra,
          );
        }
        break;
      case SequencedEventGroup():
        for (final entry in event.events) {
          await _resolveEvent(entry.event);
          await Future.delayed(entry.delay);
        }
        break;
      case CommonEventGroup():
        for (final entry in event.events) {
          _resolveEvent(entry.event);
        }
        break;
      case AnimationTriggerEvent():
        await _resolveAnimationTrigger(event);
        break;
      case TimerEvent():
        final evt = event;
        Timer(
          evt.timerDelay,
          () async {
            await _resolveEvent(evt.payload);
          },
        );
        break;
    }

    onEventHandled?.call();
  }

  Map<String, dynamic> _preparePayload(Iterable<ActionDependency> deps) {
    final Map<String, dynamic> payload = {};

    if (deps.isNotEmpty) {
      for (final dependency in deps) {
        final controller = _viewControllers[dependency.id];
        if (controller != null) {
          final attribute = controller.attributes.payload;
          if (attribute is AttendedModel) {
            payload[dependency.target] = attribute.collect();
          }
        }
      }
    }

    return payload;
  }

  @override
  Future<void> execute(ServerAction action) async {
    beforeActionCallback?.call(action);

    switch (action) {
      //transport
      case TransportAction():
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
      case LocalAction():
        try {
          await _resolveEvent(action.event);
        } catch (e) {
          debugPrint(e.toString());
        }
        break;
      //script
      case ScriptAction():
        try {
          final body = _preparePayload(action.dependsOn);
          final script = action.script;

          final scriptInvocationResult = await scriptRunner?.runScript(
            script.functionName,
            url: action.eventName,
            meta: action.script.meta,
            body: body,
          );

          await _resolveEvent(scriptInvocationResult);
        } catch (e) {
          debugPrint(e.toString());
        }

        break;
    }

    afterActionCallback?.call();
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
      final component = JsonUtils.mergeWithDataSource(
        description,
        json,
      );

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

      controller.updateState(attributes);
    }
  }

  @protected
  @override
  Future<void> evalScript(String source) async {
    await scriptRunner?.eval(source);
  }

  Future<T?> emitNativeEvent<T>(String event, [Object? data]) async {
    return await _driverChannel.invokeMethod<T>(event, data);
  }

  // </editor-fold>

  //<editor-fold desc="Transport methods">
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
  Transport _getTransport(String type) {
    if (_isModule) {
      return NativeTransport(this);
    }

    switch (type) {
      case TransportType.http:
        {
          return HttpTransport(
            source,
            options: transportOptions as HttpTransportOptions,
          );
        }
      case TransportType.ws:
        {
          return WSTransport(
            source,
            options: transportOptions as WebSocketTransportOptions,
          );
        }
      default:
        {
          return HttpTransport(
            source,
            options: transportOptions as HttpTransportOptions,
          );
        }
    }
  }

  /// Initializes the driver as a module.
  Future<void> _initMethodChannel() async {
    _driverChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "duit_event":
          await _resolveEvent(call.arguments as Map<String, dynamic>);
          break;
        case "duit_layout":
          final json = call.arguments as Map<String, dynamic>;
          _layout = await DuitTree(
            json: json,
            driver: this,
          ).parse();
          streamController.sink.add(_layout);
          break;
        default:
          break;
      }
    });
    _isChannelInitialized = true;
  }

  // </editor-fold">

  //<editor-fold desc="Testing">
  @visibleForTesting
  Future<void> updateTestAttributes(
    String id,
    Map<String, dynamic> json,
  ) =>
      _updateAttributes(
        id,
        json,
      );

  @visibleForTesting
  Future<void> executeTestAction(ServerAction action) async {
    await execute(action);
  }

  @visibleForTesting
  Future<void> resolveTestEvent(dynamic eventData) async {
    await _resolveEvent(eventData);
  }

  @visibleForTesting
  int get controllersCount => _viewControllers.length;
//</editor-fold>
}
