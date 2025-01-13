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

final class _DriverFinalizationController {
  final DuitDriver d;

  _DriverFinalizationController(this.d);

  void dispose() {
    d.dispose();
  }
}

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

  @override
  ExternalEventHandler? externalEventHandler;

  @override
  ScriptRunner? scriptRunner;

  @override
  Stream<ElementTree?> get stream =>
      streamController.stream.asBroadcastStream();

  @protected
  final Map<String, dynamic>? initialRequestPayload;

  late final bool _useStaticContent;
  bool _isChannelInitialized = false;

  late final Map<String, dynamic>? content;

  @override
  late final ActionExecutor actionExecutor;

  @override
  late final EventResolver eventResolver;

  @override
  MethodChannel? driverChannel;

  @override
  late final bool isModule;

  @override
  late DebugLogger? logger;

  DuitDriver(
    this.source, {
    required this.transportOptions,
    this.externalEventHandler,
    this.initialRequestPayload,
    this.logger,
    EventResolver? customEventResolver,
    ActionExecutor? customActionExecutor,
    DebugLogger? customLogger,
    bool enableDevMetrics = false,
  }) {
    logger = customLogger ?? DefaultLogger.instance;

    _useStaticContent = false;
    actionExecutor = customActionExecutor ??
        DefaultActionExecutor(
          driver: this,
          logger: logger,
        );
    eventResolver = customEventResolver ??
        DefaultEventResolver(
          driver: this,
          logger: logger,
        );
    isModule = false;
  }

  /// Creates a new instance of [DuitDriver] with the specified [content] without establishing a initial transport connection.
  DuitDriver.static(
    this.content, {
    required this.transportOptions,
    this.externalEventHandler,
    this.logger,
    EventResolver? customEventResolver,
    ActionExecutor? customActionExecutor,
    DebugLogger? customLogger,
    bool enableDevMetrics = false,
    this.source = "",
    this.initialRequestPayload,
  }) {
    logger = customLogger ?? DefaultLogger.instance;

    _useStaticContent = true;
    isModule = false;
    eventResolver = customEventResolver ??
        DefaultEventResolver(
          driver: this,
          logger: logger,
        );
    actionExecutor = customActionExecutor ??
        DefaultActionExecutor(
          driver: this,
          logger: logger,
        );
  }

  /// Creates a new [DuitDriver] instance that is controlled from native code
  DuitDriver.module()
      : _useStaticContent = false,
        source = "",
        initialRequestPayload = null,
        isModule = true,
        externalEventHandler = null,
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
  void detachController(String id) => _viewControllers.remove(id)?.dispose();

  @protected
  @override
  UIElementController? getController(String id) => _viewControllers[id];

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

      if (isModule && !_isChannelInitialized) {
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
        try {
        json = await transport?.connect(
          initialData: initialRequestPayload,
        );
        } catch (e, s) {
          logger?.error(
            "Failed conneting to server",
            error: e,
            stackTrace: s,
          );
          streamController.sink.addError(e);
        }
      }

      if (transport is Streamer) {
        final streamer = transport as Streamer;
        streamer.eventStream.listen(
          (d) async {
            try {
              if (buildContext.mounted) {
                await eventResolver.resolveEvent(buildContext, d);
              }
            } catch (e, s) {
              logger?.error(
                "Error while processing event from transport stream",
                error: e,
                stackTrace: s,
              );
              streamController.sink.addError(e);
            }
          },
        );
      }

      _layout = DuitTree(json: json!, driver: this);

      try {
        streamController.sink.add(
          await _layout!.parse(),
        );
      } catch (e, s) {
        logger?.error(
          "Layout parse failed",
          error: e,
          stackTrace: s,
        );
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
      ViewAttribute.attributeParser = DefaultAttributeParser();
      ServerAction.setActionParser(DefaultActionParser());
      ServerEvent.eventParser = DefaultEventParser();
    } catch (_) {
      //Safely handle the case of assigning parsers during
      //multiple driver initializations as part of running tests
    }
  }

  //</editor-fold>

  //<editor-fold desc="Actions & Events">

  @override
  Future<void> execute(ServerAction action) async {
    beforeActionCallback?.call(action);

        try {
      final event = await actionExecutor.executeAction(
        action,
      );

          if (event != null) {
        eventResolver.resolveEvent(buildContext, event);
          }
        } catch (e) {
      logger?.error(
        "Error executing action",
        error: e,
      );
    } finally {
    afterActionCallback?.call();
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

  @protected
  @override
  Future<void> evalScript(String source) async {
    await scriptRunner?.eval(source);
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
    if (isModule) {
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
    driverChannel?.setMethodCallHandler((call) async {
      switch (call.method) {
        case "duit_event":
          await eventResolver.resolveEvent(
            buildContext,
            call.arguments as Map<String, dynamic>,
          );
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
      updateAttributes(
        id,
        json,
      );

  @visibleForTesting
  Future<void> executeTestAction(ServerAction action) async {
    await execute(action);
  }

  @visibleForTesting
  Future<void> resolveTestEvent(dynamic eventData) async {
    await eventResolver.resolveEvent(buildContext, eventData);
  }

  @visibleForTesting
  int get controllersCount => _viewControllers.length;

  @override
  Map<String, dynamic> preparePayload(
    Iterable<ActionDependency> dependencies,
  ) {
    final Map<String, dynamic> payload = {};

    if (dependencies.isNotEmpty) {
      for (final dependency in dependencies) {
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
  Future<void> updateAttributes(
    String controllerId,
    Map<String, dynamic> json,
  ) async {
    final controller = _viewControllers[controllerId];
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
//</editor-fold>
}
