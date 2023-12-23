import 'dart:async';

import 'package:flutter/material.dart';

import 'index.dart';

typedef TransportSpawner = Transport Function(TransportOptions options);

abstract interface class UIDriver {
  /// The source url of the UI driver.
  abstract final String source;

  /// The options for the transport used by the UI driver.
  abstract final TransportOptions transportOptions;

  /// The transport used by the UI driver.
  abstract Transport? transport;

  /// The build context associated with the UI driver.
  @protected
  abstract BuildContext buildContext;

  /// The stream controller for the UI driver.
  @protected
  abstract StreamController<DuitAbstractTree?> streamController;

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

  /// Returns the stream of UI abstract trees.
  Stream<DuitAbstractTree?> get stream;

  /// Set the BuildContext.
  set context(BuildContext value);
}
