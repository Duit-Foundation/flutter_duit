import "package:flutter/material.dart";
import "package:flutter_duit/src/controller/index.dart";
import "package:flutter_duit/src/transport/index.dart";
import "package:flutter_duit/src/ui/models/ui_tree.dart";
import "package:flutter_duit/src/utils/index.dart";

import "index.dart";

const data = {
  "id": "1",
  "type": "Column",
  "children": [
    {
      "id": "2",
      "type": "Row",
      "children": [
        {"type": "Text", "value": "text1", "id": "3"},
        {"type": "Text", "value": "text2", "id": "4"},
        {
          "type": "SizedBox",
          "id": "10",
          "child": {
            "type": "ColoredBox",
            "id": "5",
            "child": {"type": "Text", "value": "text2", "id": "6"},
          },
        },
      ],
    },
  ],
};

const data2 = {
  "type": "Text",
  "uncontrolled": false,
  "data": "TEST TEXT",
  "id": "4123df",
  "attributes": {"data": "keyany"},
  "action": {},
};

abstract final interface

class UIDriver {
  abstract final String layoutSource;
  abstract final TransportType transportType;
  abstract Transport? transport;

  void attachController(String id, UIElementController controller);

  Future<DUITAbstractTree?> init();

  Widget? build();

  void execute(ServerAction action);

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
    final json = await transport!.connect();
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
  void execute(ServerAction action) {
    final payload = {};

    if (action.dependsOn.isNotEmpty) {
      for (var dependency in action.dependsOn) {
        final controller = _viewControllers[dependency.id];
        if (controller != null) {
          //TODO
          final state = controller.attributes;
          if (state != null) {
            final value = state.payload[dependency.target];
            payload[dependency.target] = value;
          }
        }
      }
    }

    transport?.execute(action.event, payload);
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
      final attributes = AttributeParser.parse(controller.type, json);
      controller.updateState(attributes);
    }
  }
}
