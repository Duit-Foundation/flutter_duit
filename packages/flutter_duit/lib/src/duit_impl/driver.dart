import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/controller/index.dart";
import "package:flutter_duit/src/transport/index.dart";
import "package:flutter_duit/src/ui/models/attended_model.dart";
import "package:flutter_duit/src/ui/models/ui_tree.dart";
import "package:flutter_duit/src/utils/index.dart";

import "index.dart";

abstract interface class UIDriver {
  abstract final String layoutSource;
  abstract final TransportType transportType;
  abstract Transport? transport;

  void attachController(String id, UIElementController controller);

  Future<DUITAbstractTree?> init();

  Widget? build();

  Future<void> execute(ServerAction action);

  void dispose();
}

final class DUITDriver implements UIDriver {
  @override
  final String layoutSource;
  @override
  final TransportType transportType;
  @override
  Transport? transport;

  DUITAbstractTree? _layout;
  Map<String, UIElementController> _viewControllers = {};

  DUITDriver({
    required this.layoutSource,
    this.transportType = TransportType.http,
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
          return HttpTransport(layoutSource);
        }
      case TransportType.grpc:
      case TransportType.ws:
        {
          return WSTransport(layoutSource);
        }
      default:
        {
          return WSTransport(layoutSource);
        }
    }
  }

  void _resolveUpdates(JSONObject json) {
    final updates = json["updates"] as Map<String, dynamic>;
    updates.forEach((key, value) {
      updateAttributes(key, value);
    });
  }

  @override
  Future<DUITAbstractTree?> init() async {
    transport = _getTransport(transportType);
    final json = await transport?.connect();
    assert(json != null);

    if (transport is! HttpTransport) {
      final streamer = transport as Streamer;
      streamer.eventStream.listen(_resolveUpdates);
    }

    return _layout = await DUITAbstractTree(json: json!, driver: this).parse();
  }

  @override
  Widget? build() {
    return _layout?.render();
  }

  @override
  Future<void> execute(ServerAction action) async {
    final payload = {};

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

    await transport?.execute(action.event, payload);
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
