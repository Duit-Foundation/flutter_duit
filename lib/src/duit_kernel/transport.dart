import 'dart:async';

import 'action.dart';

/// Base class for transport implementations.
///
/// This class provides a common interface for different transport implementations,
/// such as WebSocket, HTTP, etc. It defines methods and properties that need to be
/// implemented by subclasses.
///
/// Example usage:
/// ```dart
/// class MyTransport extends Transport {
///   // Implement the required methods and properties
/// }
/// ```
abstract class Transport {
  final String url;
  
  /// Constructs a new [Transport] instance with the specified URL.
  ///
  /// The [url] parameter represents the URL for the transport connection.
  Transport(this.url);

  /// Executes a server action with the given payload and returns a server event.
  ///
  /// The [action] parameter represents the server action to execute.
  /// The [payload] parameter contains any additional data required for the action.
  /// Returns a [ServerEvent] object representing the server's response.
  FutureOr<Map<String, dynamic>?> execute(ServerAction action, Map<String, dynamic> payload);

  /// Establishes a connection to the server.
  ///
  /// Returns a [Future] that completes when the connection is established.
  Future<Map<String, dynamic>?> connect();

  /// Disposes of any resources associated with the transport.
  ///
  /// This method should be called when the transport is no longer needed.
  void dispose();
}