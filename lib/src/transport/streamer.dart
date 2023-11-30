abstract interface class Streamer {
  Stream<Map<String, dynamic>> get eventStream;
}