import "dart:async";

import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/capabilities/index.dart";
import "package:flutter_duit/src/view_manager/index.dart";
import "package:flutter_duit/src/transport/index.dart";

final class DuitDriver extends UIDriver with DriverHooks {
  @visibleForTesting
  @override
  final String source;

  @visibleForTesting
  @override
  Transport? transport;

  @visibleForTesting
  @override
  TransportOptions transportOptions;

  @visibleForTesting
  @override
  late BuildContext buildContext;

  @override
  // ignore: avoid_setters_without_getters
  set context(BuildContext value) {
    buildContext = value;
  }

  final _eventStreamController = StreamController<UIDriverEvent>.broadcast();

  @override
  Stream<UIDriverEvent> get eventStream => _eventStreamController.stream;

  @visibleForTesting
  @override
  @Deprecated("Will be removed in the next major release.")
  ExternalEventHandler? externalEventHandler;

  @visibleForTesting
  @override
  ScriptRunner? scriptRunner;

  @visibleForTesting
  final Map<String, dynamic>? initialRequestPayload;

  late final bool _useStaticContent;
  bool _isChannelInitialized = false, _isDriverInitialized = false;

  @visibleForTesting
  late final Map<String, dynamic>? content;

  @visibleForTesting
  @override
  @Deprecated("Will be removed in the next major release.")
  late final ActionExecutor actionExecutor;

  @visibleForTesting
  @override
  @Deprecated("Will be removed in the next major release.")
  late final EventResolver eventResolver;

  @visibleForTesting
  @override
  MethodChannel? driverChannel;

  @visibleForTesting
  @override
  late final bool isModule;

  @visibleForTesting
  @override
  DebugLogger? logger;

  late ViewManager _viewManager;

  final FocusCapabilityDelegate _focusNodeManager;
  final ServerActionExecutionCapabilityDelegate _actionManager;
  final UIControllerCapabilityDelegate _controllerManager;

  DuitDriver(
    this.source, {
    required this.transportOptions,
    this.externalEventHandler,
    this.initialRequestPayload,
    this.logger,
    @Deprecated(
      "Will be removed in the next major release. Use [ServerActionExecutionCapabilityDelegate] instead",
    )
    EventResolver? customEventResolver,
    @Deprecated(
      "Will be removed in the next major release. Use [ServerActionExecutionCapabilityDelegate] instead",
    )
    ActionExecutor? customActionExecutor,
    DebugLogger? customLogger,
    bool shared = false,
    FocusCapabilityDelegate? focusCap,
    ServerActionExecutionCapabilityDelegate? actionCap,
    UIControllerCapabilityDelegate? controllerCap,
  })  : _actionManager = actionCap ?? DuitActionManager(),
        _controllerManager = controllerCap ?? DuitControllerManager(),
        _focusNodeManager = focusCap ?? DuitFocusNodeManager() {
    logger = customLogger ?? DefaultLogger.instance;

    _useStaticContent = false;
    isModule = false;
    _viewManager = shared ? MultiViewManager() : SimpleViewManager();

    _focusNodeManager.driver = this;
    _actionManager.driver = this;
    _controllerManager.driver = this;
  }

  /// Creates a new instance of [DuitDriver] with the specified [content] without establishing a initial transport connection.
  DuitDriver.static(
    this.content, {
    required this.transportOptions,
    this.externalEventHandler,
    this.logger,
    @Deprecated(
      "Will be removed in the next major release. Use [ServerActionExecutionCapabilityDelegate] instead",
    )
    EventResolver? customEventResolver,
    @Deprecated(
      "Will be removed in the next major release. Use [ServerActionExecutionCapabilityDelegate] instead",
    )
    ActionExecutor? customActionExecutor,
    DebugLogger? customLogger,
    this.source = "",
    this.initialRequestPayload,
    bool shared = false,
    FocusCapabilityDelegate? focusCap,
    ServerActionExecutionCapabilityDelegate? actionCap,
    UIControllerCapabilityDelegate? controllerCap,
  })  : _actionManager = actionCap ?? DuitActionManager(),
        _controllerManager = controllerCap ?? DuitControllerManager(),
        _focusNodeManager = focusCap ?? DuitFocusNodeManager() {
    logger = customLogger ?? DefaultLogger.instance;

    _useStaticContent = true;
    isModule = false;
    _viewManager = shared ? MultiViewManager() : SimpleViewManager();
    _focusNodeManager.driver = this;
    _actionManager.driver = this;
    _controllerManager.driver = this;
  }

  /// Creates a new [DuitDriver] instance that is controlled from native code
  DuitDriver.module()
      : _useStaticContent = false,
        source = "",
        initialRequestPayload = null,
        isModule = true,
        transportOptions = EmptyTransportOptions(),
        driverChannel = const MethodChannel("duit:driver"),
        _viewManager = SimpleViewManager(),
        _actionManager = DuitActionManager(),
        _controllerManager = DuitControllerManager(),
        _focusNodeManager = DuitFocusNodeManager() {
    _focusNodeManager.driver = this;
    _actionManager.driver = this;
    _controllerManager.driver = this;
  }

  Future<Map<String, dynamic>> _connect() async {
    Map<String, dynamic>? json;

    try {
      if (_useStaticContent) {
        assert(content != null && content!.isNotEmpty);
        json = content!;
      } else {
        json = await transport?.connect(
          initialData: initialRequestPayload,
        );
      }
    } catch (e, s) {
      logger?.error(
        "Failed conneting to server",
        error: e,
        stackTrace: s,
      );
      _eventStreamController.addError(e);
    }

    if (transport is Streamer) {
      final streamer = transport! as Streamer;
      streamer.eventStream.listen(
        (d) async {
          try {
            if (buildContext.mounted) {
              await resolveEvent(buildContext, d);
            }
          } catch (e, s) {
            logger?.error(
              "Error while processing event from transport stream",
              error: e,
              stackTrace: s,
            );
            _eventStreamController.addError(e);
          }
        },
      );
    }

    return json ?? {};
  }

  @override
  Future<void> init() async {
    if (!_isDriverInitialized) {
      _isDriverInitialized = true;
    } else {
      return;
    }

    _viewManager.driver = this;
    _addParsers();

    onInit?.call();

    if (isModule && !_isChannelInitialized) {
      await _initMethodChannel();
    }

    transport ??= _getTransport(
      transportOptions.type,
    );

    await scriptRunner?.initWithTransport(transport!);

    final json = await _connect();

    try {
      final view = await _viewManager.prepareLayout(json);

      if (view != null) {
        _eventStreamController.add(
          UIDriverViewEvent(view),
        );
      } else {
        final err = FormatException(
          "Invalid layout structure. Received map keys: ${json.keys}",
        );
        throw err;
      }
    } catch (e, s) {
      logger?.error(
        "Layout parse failed",
        error: e,
        stackTrace: s,
      );
      _eventStreamController.addError(
        UIDriverErrorEvent(
          "Layout parse failed",
          error: e,
          stackTrace: s,
        ),
      );
    }
  }

  @override
  void releaseResources() {
    _focusNodeManager.releaseResources();
    _controllerManager.releaseResources();
    _actionManager.releaseResources();
  }

  @override
  void dispose() {
    onDispose?.call();
    transport?.dispose();
    _eventStreamController.close();
    releaseResources();
  }

  @override
  Widget? build() {
    return _viewManager.build();
  }

  void _addParsers() {
    try {
      ServerAction.setActionParser(const DefaultActionParser());
      ServerEvent.eventParser = const DefaultEventParser();
    } catch (e) {
      //Safely handle the case of assigning parsers during
      //multiple driver initializations as part of running tests
      logger?.warn(
        e.toString(),
      );
    }
  }

  @visibleForTesting
  @override
  Future<void> evalScript(String source) async => scriptRunner?.eval(source);

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
    if (isModule) {
      return NativeTransport(this);
    }

    return switch (type) {
      TransportType.http => HttpTransport(
          source,
          options: transportOptions as HttpTransportOptions,
        ),
      TransportType.ws => WSTransport(
          source,
          options: transportOptions as WebSocketTransportOptions,
        ),
      _ => EmptyTransport(),
    };
  }

  /// Initializes the driver as a module.
  Future<void> _initMethodChannel() async {
    driverChannel?.setMethodCallHandler((call) async {
      switch (call.method) {
        case "duit_event":
          await resolveEvent(
            buildContext,
            call.arguments as Map<String, dynamic>,
          );
          break;
        case "duit_layout":
          final json = call.arguments as Map<String, dynamic>;
          final view = await _viewManager.prepareLayout(json);
          if (view != null) {
            _eventStreamController.add(
              UIDriverViewEvent(view),
            );
          }
          break;
        default:
          break;
      }
    });
    _isChannelInitialized = true;
  }

  @override
  void notifyWidgetDisplayStateChanged(
    String viewTag,
    int state,
  ) {
    _viewManager.notifyWidgetDisplayStateChanged(viewTag, state);
    logger?.info(
      "Widget with tag ${viewTag.isEmpty ? "*root*" : viewTag} state changed to $state",
    );
  }

  @override
  bool isWidgetReady(String viewTag) {
    return _viewManager.isWidgetReady(viewTag);
  }

  @override
  @preferInline
  void attachFocusNode(String nodeId, FocusNode node) =>
      _focusNodeManager.attachFocusNode(nodeId, node);

  @override
  @preferInline
  void detachFocusNode(String nodeId) =>
      _focusNodeManager.detachFocusNode(nodeId);

  @override
  @preferInline
  bool focusInDirection(String nodeId, TraversalDirection direction) =>
      _focusNodeManager.focusInDirection(nodeId, direction);

  @override
  @preferInline
  bool nextFocus(String nodeId) => _focusNodeManager.nextFocus(nodeId);

  @override
  @preferInline
  bool previousFocus(String nodeId) => _focusNodeManager.previousFocus(nodeId);

  @override
  @preferInline
  void requestFocus(String nodeId, {String? targetNodeId}) =>
      _focusNodeManager.requestFocus(
        nodeId,
        targetNodeId: targetNodeId,
      );

  @override
  @preferInline
  void unfocus(
    String nodeId, {
    UnfocusDisposition disposition = UnfocusDisposition.scope,
  }) =>
      _focusNodeManager.unfocus(
        nodeId,
        disposition: disposition,
      );

  @override
  @preferInline
  FocusNode? getNode(Object? key) => _focusNodeManager.getNode(key);

  @visibleForTesting
  @override
  Future<void> execute(ServerAction action) async {
    beforeActionCallback?.call(action);

    try {
      await _actionManager.execute(action);
    } catch (e) {
      logger?.error(
        "Error executing action",
        error: e,
      );
    } finally {
      afterActionCallback?.call();
    }
  }

  @visibleForTesting
  @override
  Future<void> resolveEvent(BuildContext context, eventData) async =>
      _actionManager.resolveEvent(
        context,
        eventData,
      );

  @override
  @preferInline
  Map<String, dynamic> preparePayload(
    Iterable<ActionDependency> dependencies,
  ) =>
      _actionManager.preparePayload(
        dependencies,
      );

  /// Adds an event stream to be listened to and processed by the driver.
  ///
  /// Each element of the stream must be a Map<String, dynamic>, which will be converted into a [ServerEvent].
  /// If the event is a [NullEvent], a [MissingFocusNodeException] will be thrown.
  /// For all other events, eventResolver.resolveEvent is called with the current [buildContext].
  ///
  /// The stream subscription is stored in the internal [_dataSources] list for lifecycle management.
  ///
  /// [stream] - the stream of events coming from the server or another data source.
  @override
  @preferInline
  void addExternalEventStream(
    Stream<Map<String, dynamic>> stream,
  ) =>
      _actionManager.addExternalEventStream(
        stream,
      );

  @override
  @preferInline
  Future<void> updateAttributes(
    String controllerId,
    Map<String, dynamic> json,
  ) async =>
      _controllerManager.updateAttributes(
        controllerId,
        json,
      );

  @override
  @preferInline
  void attachController(String id, UIElementController controller) =>
      _controllerManager.attachController(id, controller);

  @override
  @preferInline
  void detachController(String id) => _controllerManager.detachController(id);

  @override
  @preferInline
  UIElementController? getController(String id) =>
      _controllerManager.getController(id);

  @override
  @preferInline
  int get controllersCount => _controllerManager.controllersCount;

  @override
  @preferInline
  void attachExternalHandler(
    UserDefinedHandlerKind type,
    UserDefinedEventHandler handle,
  ) =>
      _actionManager.attachExternalHandler(
        type,
        handle,
      );
}
