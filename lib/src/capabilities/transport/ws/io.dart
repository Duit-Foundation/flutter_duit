import "dart:async";
import "dart:convert";
import "dart:io";
import "dart:typed_data";

import "package:duit_kernel/duit_kernel.dart";
import "package:flutter_duit/src/transport/transport_utils.dart";

final class WSTransportManager with TransportCapabilityDelegate {
  late final WebSocket _ws;
  late final StreamSubscription _sub;
  final _controller = StreamController<Map<String, dynamic>>();

  final String url, baseUrl;
  final Map<String, String> defaultHeaders;
  final Converter<Object?, String>? encoder;
  final Converter<Uint8List, Object?>? decoder;

  WSTransportManager({
    required this.url,
    this.baseUrl = "",
    this.defaultHeaders = const {},
    this.encoder,
    this.decoder,
  });

  @override
  void linkDriver(UIDriver driver) {}

  @override
  Stream<Map<String, dynamic>> connect({
    Map<String, dynamic>? initialRequestData,
    Map<String, dynamic>? staticContent,
  }) async* {
    if (staticContent != null) {
      yield staticContent;
    }

    var urlString = prepareUrl(baseUrl, url);

    if (initialRequestData != null) {
      urlString =
          objectToURLWithQueryParams(urlString, initialRequestData).toString();
    }

    assert(
      urlString.isNotEmpty && urlString.startsWith("ws"),
      "Invalid url: $url}",
    );

    _ws = await WebSocket.connect(
      urlString,
      headers: defaultHeaders,
    );

    _sub = _ws
        .asyncMap(
      (event) => parseResponse(
        event,
        customDecoder: decoder,
      ),
    )
        .listen(
      _controller.add,
      onError: (e) {
        _controller.addError(e);
      },
    );

    yield* _controller.stream;
  }

  @override
  Future<Map<String, dynamic>?> executeRemoteAction(
    ServerAction action,
    Map<String, dynamic> payload,
  ) async {
    final data = {
      "event": action.eventName,
      "payload": payload,
    };

    final eventData =
        encoder != null ? encoder!.convert(data) : jsonEncode(data);
    _ws.add(eventData);

    return null;
  }

  @override
  void releaseResources() {
    _ws.close(1000, "disposed");
    _sub.cancel();
    _controller.close();
  }

  @override
  Future<Map<String, dynamic>?> request(
    String url,
    Map<String, dynamic> meta,
    Map<String, dynamic> body,
  ) async {
    final data = {
      "event": url,
      "payload": body,
    };
    final eventData =
        encoder != null ? encoder!.convert(data) : jsonEncode(data);
    _ws.add(eventData);
    return null;
  }
}
