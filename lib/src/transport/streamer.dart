/// An abstract interface class for providing a stream of events.
///
/// The `Streamer` class defines a contract for classes that provide a stream
/// of events. Implementing classes should extend this class and provide
/// an implementation for the [eventStream] method.
abstract class Streamer {
  /// Returns a stream of events.
  ///
  /// The [eventStream] method should be implemented by classes that extend
  /// the `Streamer` class. It should return a stream that emits events of
  /// type `Map<String, dynamic>`.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// Streamer myStreamer = MyStreamer();
  ///
  /// Stream<Map<String, dynamic>> events = myStreamer.eventStream;
  /// events.listen((event) {
  ///   // Handle event
  /// });
  /// ```
  Stream<Map<String, dynamic>> get eventStream;
}