import "dart:async";

import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/capabilities/index.dart";

final class DuitDriverCompat extends UIDriver with DriverHooks {
  @override
  @Deprecated("Will be removed in the next major release.")
  late final String source;

  @override
  @Deprecated("Will be removed in the next major release.")
  late final Transport? transport;

  @override
  @Deprecated("Will be removed in the next major release.")
  late final TransportOptions transportOptions;

  @override
  @Deprecated("Will be removed in the next major release.")
  late final ExternalEventHandler? externalEventHandler;

  @override
  @Deprecated(
    "Will be removed in the next major release. Use [ScriptingCapabilityDelegate] instead",
  )
  late final ScriptRunner? scriptRunner;

  @override
  @Deprecated("Will be removed in the next major release.")
  late final ActionExecutor actionExecutor;

  @override
  @Deprecated("Will be removed in the next major release.")
  late final EventResolver eventResolver;

  @override
  @Deprecated("Use [LoggingCapabilityDelegate] instead")
  late final DebugLogger? logger;

  @override
  BuildContext get buildContext => _viewManager.buildContext;

  @override
  set context(BuildContext value) => _viewManager.context = value;

  @override
  Stream<UIDriverEvent> get eventStream => _viewManager.eventStream;

  final Map<String, dynamic>? initialRequestPayload;

  bool _isDriverInitialized = false;

  late final Map<String, dynamic>? content;

  @override
  @Deprecated("Will be removed in the next major release.")
  late final MethodChannel? driverChannel;

  @override
  late final bool isModule;

  final FocusCapabilityDelegate _focusNodeManager;
  final ServerActionExecutionCapabilityDelegate _actionManager;
  final UIControllerCapabilityDelegate _controllerManager;
  final ViewModelCapabilityDelegate _viewManager;
  final TransportCapabilityDelegate _transportManager;
  final ScriptingCapabilityDelegate _scriptingManager;
  final LoggingCapabilityDelegate _loggingManager;
  late final NativeModuleCapabilityDelegate _nativeModuleManager;

  late final StreamSubscription _transportSubscription;

  DuitDriverCompat({
    required TransportCapabilityDelegate transportManager,
    this.initialRequestPayload,
    this.content,
    this.isModule = false,
    FocusCapabilityDelegate? focusManager,
    ServerActionExecutionCapabilityDelegate? actionManager,
    UIControllerCapabilityDelegate? controllerManager,
    ViewModelCapabilityDelegate? viewManager,
    ScriptingCapabilityDelegate? scriptingManager,
    LoggingCapabilityDelegate? loggingManager,
    NativeModuleCapabilityDelegate? nativeModuleManager,
    Parser<ServerAction>? actionParser,
    Parser<ServerEvent>? eventParser,
  })  : _actionManager = actionManager ?? DuitActionManager(),
        _controllerManager = controllerManager ?? DuitControllerManager(),
        _focusNodeManager = focusManager ?? DuitFocusNodeManager(),
        _viewManager = viewManager ?? DuitViewManager(),
        _transportManager = transportManager,
        _scriptingManager = scriptingManager ?? DuitStubScriptingManager(),
        _loggingManager = loggingManager ?? const LoggingManager() {
    ServerAction.setActionParser(actionParser ?? const DefaultActionParser());
    ServerEvent.eventParser = eventParser ?? const DefaultEventParser();

    _focusNodeManager.linkDriver(this);
    _actionManager.linkDriver(this);
    _controllerManager.linkDriver(this);
    _viewManager.linkDriver(this);
    _transportManager.linkDriver(this);
    _scriptingManager.linkDriver(this);

    if (isModule) {
      _nativeModuleManager = nativeModuleManager ?? DuitNativeModuleManager();
      _nativeModuleManager.linkDriver(this);
    }
  }

  @override
  Future<void> init() async {
    if (!_isDriverInitialized) {
      _isDriverInitialized = true;
    } else {
      return;
    }

    onInit?.call();

    if (isModule) {
      await _nativeModuleManager.initNativeModule();
    }

    await _scriptingManager.initScriptingCapability();

    _transportSubscription = _transportManager
        .connect(
      initialRequestData: initialRequestPayload,
      staticContent: content,
    )
        .listen(
      (data) async {
        try {
          if (LayoutStructValidator.isValidViewStruct(data)) {
            final view = await _viewManager.prepareLayout(data);

            if (view != null) {
              _viewManager.addUIDriverEvent(
                UIDriverViewEvent(view),
              );
            } else {
              throw FormatException(
                "Invalid layout structure. Received map keys: ${data.keys}",
              );
            }
          } else {
            if (_viewManager.buildContext.mounted) {
              await _actionManager.resolveEvent(
                _viewManager.buildContext,
                data,
              );
            }
          }
        } catch (e, s) {
          logError(
            "Error while processing event from transport stream",
            e,
            s,
          );
          _viewManager.addUIDriverError(
            UIDriverErrorEvent(
              "Error while processing event from transport stream",
              error: e,
              stackTrace: s,
            ),
            s,
          );
        }
      },
      onError: (e, s) {
        logError(
          "Failed conneting to server",
          e,
          s,
        );
        _viewManager.addUIDriverError(
          UIDriverErrorEvent(
            "Failed conneting to server",
            error: e,
            stackTrace: s,
          ),
          s,
        );
      },
      onDone: () {
        logInfo(
          "Transport connection closed",
        );
      },
    );
  }

  @override
  void releaseResources() {
    _focusNodeManager.releaseResources();
    _controllerManager.releaseResources();
    _actionManager.releaseResources();
    _viewManager.releaseResources();
    _transportManager.releaseResources();
    _scriptingManager.releaseResources();
    if (isModule) {
      _nativeModuleManager.releaseResources();
    }
  }

  @override
  void dispose() {
    onDispose?.call();
    _transportSubscription.cancel();
    releaseResources();
  }

  @override
  @Deprecated("Will be removed in the next major release.")
  Widget? build() => null;

  @override
  @preferInline
  void notifyWidgetDisplayStateChanged(
    String viewTag,
    int state,
  ) =>
      _viewManager.notifyWidgetDisplayStateChanged(viewTag, state);

  @override
  @preferInline
  bool isWidgetReady(String viewTag) => _viewManager.isWidgetReady(viewTag);

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
  void requestFocus(String nodeId) => _focusNodeManager.requestFocus(nodeId);

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

  @override
  Future<void> execute(ServerAction action) async {
    beforeActionCallback?.call(action);

    try {
      await _actionManager.execute(action);
    } catch (e, s) {
      logError(
        "Error executing action",
        e,
        s,
      );
    } finally {
      afterActionCallback?.call();
    }
  }

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

  @override
  @preferInline
  (Map<String, dynamic>, int) preparePayloadWithDataHash(
    Iterable<ActionDependency> dependencies,
  ) =>
      _actionManager.preparePayloadWithDataHash(
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

  @override
  @preferInline
  void addUIDriverError(Object error, [StackTrace? stackTrace]) =>
      _viewManager.addUIDriverError(
        error,
        stackTrace,
      );

  @override
  @preferInline
  void addUIDriverEvent(UIDriverEvent event) =>
      _viewManager.addUIDriverEvent(event);

  @override
  @preferInline
  Future<DuitView?> prepareLayout(Map<String, dynamic> json) =>
      _viewManager.prepareLayout(json);

  @override
  @preferInline
  DuitView? get currentView => _viewManager.currentView;

  @override
  void linkDriver(UIDriver driver) => throw UnimplementedError();

  @override
  @preferInline
  Stream<Map<String, dynamic>> connect({
    Map<String, dynamic>? initialRequestData,
    Map<String, dynamic>? staticContent,
  }) async* {
    yield* _transportManager.connect(
      initialRequestData: initialRequestData,
      staticContent: staticContent,
    );
  }

  @override
  @preferInline
  Future<Map<String, dynamic>?> executeRemoteAction(
    ServerAction action,
    Map<String, dynamic> payload,
  ) async =>
      _transportManager.executeRemoteAction(action, payload);

  @override
  @preferInline
  Future<Map<String, dynamic>?> request(
    String url,
    Map<String, dynamic> meta,
    Map<String, dynamic> body,
  ) async =>
      _transportManager.request(url, meta, body);

  @override
  @preferInline
  Future<Map<String, dynamic>?> execScript(
    String functionName, {
    String? url,
    Map<String, dynamic>? meta,
    Map<String, dynamic>? body,
  }) async =>
      _scriptingManager.execScript(
        functionName,
        url: url,
        meta: meta,
        body: body,
      );

  @override
  @preferInline
  Future<void> initScriptingCapability() async =>
      _scriptingManager.initScriptingCapability();

  @override
  @preferInline
  Future<void> evalScript(String source) async =>
      _scriptingManager.evalScript(source);

  @override
  @preferInline
  void logCritical(message, [Object? exception, StackTrace? stackTrace]) =>
      _loggingManager.logCritical(message, exception, stackTrace);

  @override
  @preferInline
  void logDebug(message, [Object? exception, StackTrace? stackTrace]) =>
      _loggingManager.logDebug(message, exception, stackTrace);

  @override
  @preferInline
  void logError(message, [Object? exception, StackTrace? stackTrace]) =>
      _loggingManager.logError(message, exception, stackTrace);

  @override
  @preferInline
  void logInfo(message, [Object? exception, StackTrace? stackTrace]) =>
      _loggingManager.logInfo(message, exception, stackTrace);

  @override
  @preferInline
  void logVerbose(message, [Object? exception, StackTrace? stackTrace]) =>
      _loggingManager.logVerbose(message, exception, stackTrace);

  @override
  @preferInline
  void logWarning(message, [Object? exception, StackTrace? stackTrace]) =>
      _loggingManager.logWarning(message, exception, stackTrace);

  @override
  @preferInline
  Future<void> initNativeModule() async =>
      _nativeModuleManager.initNativeModule();

  @override
  @preferInline
  Future<T?> invokeNativeMethod<T>(String method, [arguments]) =>
      _nativeModuleManager.invokeNativeMethod<T>(method, arguments);
}
