import "dart:async";

import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/duit_impl/hooks.dart";
import "package:flutter_duit/src/transport/index.dart";
import "package:flutter_duit/src/ui/models/attended_model.dart";
import "package:flutter_duit/src/ui/models/ui_tree.dart";
import "package:flutter_duit/src/utils/index.dart";

import "event.dart";
import "navigation_resolver.dart";

final class DuitDriver with DriverHooks implements UIDriver {
  @override
  final String source;
  @override
  Transport? transport;
  @override
  TransportOptions transportOptions;
  @override
  StreamController<DuitAbstractTree?> streamController =
      StreamController.broadcast();
  @override
  late BuildContext buildContext;

  @override
  set context(BuildContext value) {
    buildContext = value;
  }

  DuitAbstractTree? _layout;

  Map<String, UIElementController> _viewControllers = {};

  @protected
  final ExternalEventHandler? eventHandler;

  @override
  Stream<DuitAbstractTree?> get stream =>
      streamController.stream.asBroadcastStream();

  DuitDriver(
    this.source, {
    required this.transportOptions,
    this.eventHandler,
  });

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
  Transport _getTransport(String type) {
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
          updEvent.updates.forEach((key, value) {
            _updateAttributes(key, value);
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
            navEvent.path,
            navEvent.extra,
          );
          break;
        case ServerEventType.openUrl:
          assert(eventHandler != null, "NavigationResolver is not set");
          final urlEvent = event as OpenUrlEvent;
          await eventHandler?.handleOpenUrl(urlEvent.url);
          break;
      }
    }

    onEventHandled?.call();
  }

  @override
  Future<void> init() async {
    onInit?.call();
    if (_layout != null) {
      await Future.delayed(Duration.zero);
      streamController.sink.add(_layout);
    } else {
      ViewAttributeWrapper.attributeParser = AttributeParser();
      transport ??= _getTransport(transportOptions.type);

      final json = await transport?.connect();
      assert(json != null);

      if (transport is Streamer) {
        final streamer = transport as Streamer;
        streamer.eventStream.listen(_resolveEvent);
      }

      _layout = DuitTree(json: json!, driver: this);
      streamController.sink.add(await _layout?.parse());
    }
  }

  @override
  Widget? build() {
    return _layout?.render();
  }

  @override
  Future<void> execute(ServerAction action) async {
    beforeActionCallback?.call(action);
    final Map<String, dynamic> payload = {};

    final dependencies = action.dependsOn;

    if (dependencies.isNotEmpty) {
      for (final dependency in dependencies) {
        final controller = _viewControllers[dependency.id];
        if (controller != null) {
          if (controller.attributes?.payload is AttendedModel) {
            final model = controller.attributes?.payload as AttendedModel;
            payload[dependency.target] = model.collect();
          }
        }
      }
    }

    final event = await transport?.execute(action, payload);
    //case with http request
    if (event != null) {
      _resolveEvent(event);
    }

    afterActionCallback?.call();
  }

  @override
  void dispose() {
    onDispose?.call();
    transport?.dispose();
    _viewControllers = {};
    _layout = null;
    streamController.close();
  }

  /// Updates the attributes of a controller.
  ///
  /// This method is called to update the attributes of a controller based on the
  /// provided [json] object.
  ///
  /// Parameters:
  /// - [id]: The id of the controller.
  /// - [json]: The json object containing the updated attributes.
  void _updateAttributes(String id, JSONObject json) {
    final controller = _viewControllers[id];
    if (controller != null) {
      final attributes = ViewAttributeWrapper.createAttributes(
        controller.type,
        json,
        controller.tag,
      );
      controller.updateState(attributes);
    }
  }
}
