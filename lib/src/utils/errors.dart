/// Exception thrown when attempting to create a component or fragment
/// with a missing tag.
///
/// This exception occurs during JSON parsing of UI element structures
/// when the required `tag` field is `null` for components (type: 3)
/// or fragments (type: 4). The tag is a critically important identifier
/// for registering and creating corresponding widgets in the DUIT system.
///
/// Example usage:
/// ```dart
/// if (element.tag == null) {
///   throw NullTagException("Component tag is null \n json: $json");
/// }
/// ```
///
/// See also:
/// - [DuitElement.fromJson] - where this exception is thrown
/// - [DuitRegistry.getComponentDescription] - requires a valid tag
final class NullTagException implements Exception {
  /// Error message containing details about the problem
  final String message;

  /// Creates a new exception with the specified error message
  NullTagException(this.message);

  @override
  String toString() => message;
}

/// Exception thrown when receiving an invalid event of type [NullEvent]
/// from a data source.
///
/// This exception occurs during server event stream processing when the
/// event parser returns a [NullEvent] instead of a valid event.
/// [NullEvent] represents an "empty" event that should not be processed
/// in the normal application execution flow.
///
/// The exception is thrown in the [DuitDriver.addDataSource] method when
/// a [NullEvent] type is detected in the data stream.
///
/// Example usage:
/// ```dart
/// if (event is NullEvent) {
///   throw NullEventException("NullEvent received from data source");
/// }
/// ```
///
/// See also:
/// - [ServerEvent] - base class for all server events
/// - [NullEvent] - event type that triggers this exception when received
/// - [DuitDriver.addDataSource] - where this exception is thrown
final class NullEventException implements Exception {
  /// Error message describing the reason for the exception
  final String message;

  /// Creates a new exception with the specified error message
  NullEventException(this.message);

  @override
  String toString() => message;
}
