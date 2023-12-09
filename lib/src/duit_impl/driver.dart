import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/transport/index.dart";
import "package:flutter_duit/src/ui/models/attended_model.dart";
import "package:flutter_duit/src/ui/models/ui_tree.dart";
import "package:flutter_duit/src/utils/index.dart";

import "event.dart";

abstract interface class UIDriver {
  /// The source url of the UI driver.
  abstract final String source;

  /// The options for the transport used by the UI driver.
  abstract final TransportOptions transportOptions;

  /// The transport used by the UI driver.
  abstract Transport? transport;

  /// The build context associated with the UI driver.
  abstract BuildContext _context;

  /// The stream controller for the UI driver.
  abstract StreamController<DUITAbstractTree?> _streamController;

  /// Attaches a controller to the UI driver.
  ///
  /// Parameters:
  /// - [id]: The ID of the controller.
  /// - [controller]: The UI element controller to attach.
  void attachController(String id, UIElementController controller);

  /// Initializes the UI driver.
  ///
  /// This method initializes the UI driver by performing any necessary setup or
  /// configuration. It can be called before using the UI driver to ensure that
  /// it is ready to perform its intended tasks.
  ///
  /// Returns: A [Future] that completes when the initialization is done. If the
  /// initialization is successful, the [Future] completes successfully. If there
  /// is an error during initialization, the [Future] completes with an error.
  Future<void> init();

  /// Builds the UI.
  ///
  /// This method is responsible for building the user interface (UI) based on the
  /// current state of the UI driver. It creates and returns a widget that represents
  /// the UI to be rendered on the screen.
  ///
  /// Returns: The widget representing the UI.
  Widget? build();

  /// Executes a server action and handles the response event.
  ///
  /// If [dependencies] is not empty, it collects the data from the controllers
  /// associated with each dependency and adds it to the payload. The payload is
  /// then passed to the server action.
  ///
  /// This method is called when a server action needs to be executed.
  ///
  /// Parameters:
  /// - [action]: The server action to be executed.
  /// - [dependencies]: A list of dependencies for the server action.
  Future<void> execute(ServerAction action);

  /// Disposes of the driver and releases any resources.
  ///
  /// This method is called when the driver is no longer needed.
  void dispose();

  /// Sets the build context for the UI driver.
  set context(BuildContext value);

  /// Returns the stream of UI abstract trees.
  Stream<DUITAbstractTree?> get stream;
}

final class DUITDriver implements UIDriver {
  @override
  final String source;
  @override
  Transport? transport;
  @override
  TransportOptions transportOptions;
  @override
  StreamController<DUITAbstractTree?> _streamController = StreamController();
  @override
  late BuildContext _context;

  DUITAbstractTree? _layout;
  Map<String, UIElementController> _viewControllers = {};

  @override
  set context(BuildContext value) {
    _context = value;
  }

  @override
  Stream<DUITAbstractTree?> get stream => _streamController.stream;

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
  Transport _getTransport(TransportType type) {
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
  FutureOr<void> _resolveEventFromJson(JSONObject? json) async {
    final event = ServerEvent.fromJson(json);

    if (event != null) {
      switch (event.type) {
        case ServerEventType.update:
          final updEvent = event as UpdateEvent;
          updEvent.updates.forEach((key, value) {
            _updateAttributes(key, value);
          });
          break;
      }
    }
  }

  /// Resolves a server event.
  ///
  /// This method takes a [ServerEvent] object representing a server event and
  /// performs the appropriate handling based on the event type. It switches on
  /// the [type] of the event and executes the corresponding logic for each event
  /// type.
  ///
  /// Parameters:
  /// - [event]: The server event to be resolved.
  FutureOr<void> _resolveEvent(ServerEvent event) async {
    switch (event.type) {
      case ServerEventType.update:
        final updEvent = event as UpdateEvent;
        updEvent.updates.forEach((key, value) {
          _updateAttributes(key, value);
        });
        break;
    }
  }

  @override
  Future<void> init() async {
    transport = _getTransport(transportOptions.type);
    final json = await transport?.connect();
    assert(json != null);

    if (transport is Streamer) {
      final streamer = transport as Streamer;
      streamer.eventStream.listen(_resolveEventFromJson);
    }

    _layout = await DUITAbstractTree(json: json!, driver: this).parse();
    _streamController.sink.add(_layout);
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

    final event = await transport?.execute(action, payload);
    //case with http request
    if (event != null) {
      _resolveEvent(event);
    }
  }

  @override
  void dispose() {
    transport?.dispose();
    _viewControllers = {};
    _layout = null;
    _streamController.close();
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
