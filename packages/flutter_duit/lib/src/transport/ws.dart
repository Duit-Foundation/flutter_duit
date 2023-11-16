import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'streamer.dart';
import 'transport.dart';

final class WSTransport extends Transport implements Streamer {
  StreamController<Map<String, dynamic>> _controller =
      StreamController<Map<String, dynamic>>();
  late final WebSocket ws;

  @override
  Stream<Map<String, dynamic>> get eventStream =>
      _controller.stream.asBroadcastStream();

  WSTransport(super.url);

  @override
  Future<Map<String, dynamic>?> connect() async {
    assert(url.isNotEmpty && url.startsWith("ws"), "Invalid url: $url}");
    ws = await WebSocket.connect(url);

    ws.listen(
      (event) {
        final data = jsonDecode(event) as Map<String, dynamic>;
        _controller.sink.add(data);
      },
      onError: (e) {
        final error = jsonDecode(e) as Map;
        _controller.addError(error);
      },
    );

    await for (final event in _controller.stream) {
      _controller.close();
      _controller = StreamController<Map<String, dynamic>>.broadcast();
      print(event);
      return event;
    }

    return null;
  }

  @override
  FutureOr<void> execute(event, payload) {
    // TODO: implement execute
    throw UnimplementedError();
  }

  @override
  void dispose() {
    ws.close(1000, "disposed");
    _controller.close();
  }
}
