import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'package:flutter_duit/src/transport/transport_utils.dart';
import 'package:web/web.dart' as web;

import 'package:flutter_duit/flutter_duit.dart';
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
  var _controller = StreamController<Map<String, dynamic>>();
  late final web.WebSocket ws;
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

  Future<Map<String, dynamic>> _parseJson(String data) async =>
      jsonDecode(data) as Map<String, dynamic>;

  @override
  Future<Map<String, dynamic>?> connect({
    JSONObject? initialData,
  }) async {
    var urlString = _prepareUrl(url);

    if (initialData != null) {
      urlString = objectToURLWithQueryParams(urlString, initialData).toString();
    }

    assert(urlString.isNotEmpty && urlString.startsWith("ws"),
        "Invalid url: $url}");

    ws = web.WebSocket(urlString);

    ws.onMessage.listen((event) async {
      final eventData = event.data.dartify();
      if (eventData is String) {
        final data = await _parseJson(eventData);
        _controller.sink.add(data);
      }
    }, onError: (e) async {
      final error = await _parseJson(e);
      _controller.addError(error);
    });

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
      "event": action.eventName,
      "payload": payload,
    };
    ws.send(jsonEncode(data).toJS);
    return null;
  }

  @override
  FutureOr<Map<String, dynamic>?> request(
    String url,
    Map<String, dynamic> meta,
    Map<String, dynamic> body,
  ) {
    final data = {
      "event": url,
      "payload": body,
    };
    ws.send(jsonEncode(data).toJS);
    return null;
  }

  @override
  void dispose() {
    ws.close(1000, "disposed");
    _controller.close();
  }
}
