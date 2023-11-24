import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/controller/index.dart";
import "package:flutter_duit/src/transport/index.dart";
import "package:flutter_duit/src/transport/options.dart";
import "package:flutter_duit/src/ui/models/attended_model.dart";
import "package:flutter_duit/src/ui/models/ui_tree.dart";
import "package:flutter_duit/src/utils/index.dart";

import "index.dart";
import "event.dart";

abstract interface class UIDriver {
  abstract final String source;
  abstract final TransportOptions transportOptions;
  abstract Transport? transport;

  void attachController(String id, UIElementController controller);

  Future<DUITAbstractTree?> init();

  Widget? build();

  Future<void> execute(ServerAction action);

  void dispose();
}

final class DUITDriver implements UIDriver {
  @override
  final String source;
  @override
  Transport? transport;
  @override
  TransportOptions transportOptions;

  DUITAbstractTree? _layout;
  Map<String, UIElementController> _viewControllers = {};
  late BuildContext _context;

  set context(BuildContext value) {
    _context = value;
  }

  DUITDriver(
    this.source, {
    required this.transportOptions,
  });

  @override
  void attachController(String id, UIElementController controller) {
    final hasController = _viewControllers.containsKey(id);
    assert(!hasController,
        "ViewController with id already exists. You cannot attach controller to driver because it  contains element for id ($id)");

    _viewControllers[id] = controller;
  }

  Transport _getTransport(TransportType type) {
    switch (type) {
      case TransportType.http:
        {
          return HttpTransport(source);
        }
      case TransportType.grpc:
      case TransportType.ws:
        {
          return WSTransport(source);
        }
      default:
        {
          return WSTransport(source);
        }
    }
  }

  FutureOr<void> _resolveEvent(JSONObject? json) async {
    final event = ServerEvent.fromJson(json);

    if (event != null) {
      switch (event.type) {
        case ServerEventType.update:
          final updEvent = event as UpdateEvent;
          updEvent.updates.forEach((key, value) {
            updateAttributes(key, value);
          });
          break;
      }
    }
  }

  @override
  Future<DUITAbstractTree?> init() async {
    transport = _getTransport(transportOptions.type);
    final json = await transport?.connect();
    assert(json != null);

    if (transport is Streamer) {
      final streamer = transport as Streamer;
      streamer.eventStream.listen(_resolveEvent);
    }

    return _layout = await DUITAbstractTree(json: json!, driver: this).parse();
  }

  @override
  Widget? build() {
    return _layout?.render();
  }

  @override
  Future<void> execute(ServerAction action) async {
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

    Map<String, dynamic> headers = {};

    if (transportOptions is HttpTransportOptions) {
      final opts = transportOptions as HttpTransportOptions;
      headers = opts.defaultHeaders;
    }

    await transport?.execute(action, payload, headers);
    //TODO: event handling
  }

  @override
  void dispose() {
    transport?.dispose();
    _viewControllers = {};
    _layout = null;
  }

  void updateAttributes(String id, JSONObject json) {
    final controller = _viewControllers[id];
    if (controller != null) {
      final attributes =
          ViewAttributeWrapper.createAttributes(controller.type, json);
      controller.updateState(attributes);
    }
  }
}
