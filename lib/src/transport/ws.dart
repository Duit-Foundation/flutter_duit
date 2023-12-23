import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_duit/src/duit_kernel/index.dart';
import 'package:flutter_duit/src/transport/options.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// A WebSocket transport implementation for streaming data.
///
/// This class extends the [Transport] class and implements the [Streamer] interface.
/// It provides the functionality to establish a WebSocket connection and stream data
/// from the server.
///
/// To use this transport, you need to provide a WebSocket URL and [WebSocketTransportOptions].
///
/// Example usage:
/// ```dart
/// final transport = WSTransport(
///   'wss://example.com/ws',
///   options: WebSocketTransportOptions(),
/// );
/// ```
final class WSTransport extends Transport implements Streamer {
  StreamController<Map<String, dynamic>> _controller =
      StreamController<Map<String, dynamic>>();
  late final WebSocket ws;
  final WebSocketTransportOptions options;

  @override
  Stream<Map<String, dynamic>> get eventStream =>
      _controller.stream.asBroadcastStream();

  WSTransport(
    super.url, {
    required this.options,
  });

  String _prepareUrl(String url) {
    String urlString = "";
    if (options.baseUrl != null) {
      urlString += options.baseUrl!;
    }

    return urlString += url;
  }

  @override
  Future<Map<String, dynamic>?> connect() async {
    final urlString = _prepareUrl(url);

    assert(urlString.isNotEmpty && urlString.startsWith("ws"),
        "Invalid url: $url}");

    ws = await WebSocket.connect(
      urlString,
      headers: options.defaultHeaders,
    );

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
      _controller = StreamController.broadcast();
      return event;
    }

    return null;
  }

  @override
  FutureOr<JSONObject?> execute(action, payload) {
    final data = {
      "event": action.event,
      "payload": payload,
    };

    final str = jsonEncode(data);
    ws.add(str);

    return null;
  }

  @override
  void dispose() {
    ws.close(1000, "disposed");
    _controller.close();
  }
}
