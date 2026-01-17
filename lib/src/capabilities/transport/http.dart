import "dart:async";
import "dart:convert";
import "dart:typed_data";

import "package:duit_kernel/duit_kernel.dart";
import "package:flutter_duit/src/transport/transport_utils.dart";
import "package:http/http.dart" as http;

final class HttpTransportManager with TransportCapabilityDelegate {
  final _client = http.Client();

  final String url, baseUrl, initialRequestMethod;
  final Map<String, String> defaultHeaders;

  /// The interceptor for the HTTP requests.
  final void Function(http.Request request)? requestInterceptor;

  /// The interceptor for the HTTP errors.
  final void Function(Object? error)? errorInterceptor;

  final Converter<Object?, String>? encoder;

  final Converter<Uint8List, Object?>? decoder;

  /// Enable SSE (Server-Sent Events) connection mode.
  final bool useSSEConn;

  HttpTransportManager({
    required this.url,
    this.baseUrl = "",
    this.defaultHeaders = const {},
    this.requestInterceptor,
    this.errorInterceptor,
    this.encoder,
    this.decoder,
    this.initialRequestMethod = "GET",
    this.useSSEConn = false,
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
    } else if (useSSEConn) {
      yield* _connectSSE(initialRequestData);
    } else {
      yield* Stream.fromFuture(
        request(
          url,
          {
            "method": initialRequestMethod,
          },
          initialRequestData ?? const {},
        ).then(
          (value) => value ?? const {},
        ),
      );
    }
  }

  @override
  Future<Map<String, dynamic>?> executeRemoteAction(
    ServerAction action,
    Map<String, dynamic> payload,
  ) async {
    if (action is! TransportAction) {
      throw ArgumentError("Action is not a transport action");
    }

    final method = switch (action.meta) {
      null => "GET",
      HttpActionMetainfo() => action.meta!.method,
    };

    return request(
      action.eventName,
      {
        "method": method,
      },
      payload,
    );
  }

  @override
  Future<Map<String, dynamic>?> request(
    String url,
    Map<String, dynamic> meta,
    Map<String, dynamic> body,
  ) async {
    final method = meta["method"] ?? "GET";

    final urlString = prepareUrl(baseUrl, url);
    Uri uri;

    try {
      if (method == "POST") {
        uri = Uri.parse(urlString);
      } else {
        uri = objectToURLWithQueryParams(urlString, body);
      }

      ///Create new request, add headers and body if needed
      final request = http.Request(method, uri)..headers.addAll(defaultHeaders);
      if (method == "POST") {
        request.body =
            encoder != null ? encoder!.convert(body) : jsonEncode(body);
      }

      ///Call request interceptor
      requestInterceptor?.call(request);

      ///Send request and await for response
      final response = await _client.send(request);

      final byteData = await response.stream.toBytes();
      return parseResponse(
        byteData,
        customDecoder: decoder,
      );
    } catch (e) {
      errorInterceptor?.call(e);
      return const {};
    }
  }

  /// Establishes SSE connection and returns a stream of parsed events.
  Stream<Map<String, dynamic>> _connectSSE(
    Map<String, dynamic>? initialRequestData,
  ) async* {
    final urlString = prepareUrl(baseUrl, url);
    Uri uri;

    try {
      if (initialRequestData != null && initialRequestData.isNotEmpty) {
        uri = objectToURLWithQueryParams(urlString, initialRequestData);
      } else {
        uri = Uri.parse(urlString);
      }

      final request = http.Request(initialRequestMethod, uri)
        ..headers.addAll({
          ...defaultHeaders,
          "Accept": "text/event-stream",
          "Cache-Control": "no-cache",
        });

      if (initialRequestData != null && initialRequestMethod == "POST") {
        request.body = encoder != null
            ? encoder!.convert(initialRequestData)
            : jsonEncode(initialRequestData);
      }

      requestInterceptor?.call(request);

      final response = await _client.send(request);

      if (response.statusCode != 200) {
        errorInterceptor?.call(
          "SSE connection failed with status ${response.statusCode}",
        );
        return;
      }

      yield* response.stream
          .transform(const Utf8Decoder())
          .transform(const LineSplitter())
          .transform(
            _SSETransformer(
              decoder: decoder,
            ),
          );
    } catch (e) {
      errorInterceptor?.call(e);
    }
  }

  @override
  void releaseResources() {
    _client.close();
  }
}

/// Transformer for parsing SSE (Server-Sent Events) stream.
class _SSETransformer
    extends StreamTransformerBase<String, Map<String, dynamic>> {
  final Converter<Uint8List, Object?>? decoder;

  const _SSETransformer({this.decoder});

  @override
  Stream<Map<String, dynamic>> bind(Stream<String> stream) =>
      Stream.eventTransformed(
        stream,
        (sink) => _SSEEventSink(sink, decoder: decoder),
      );
}

/// Event sink for parsing SSE events.
class _SSEEventSink implements EventSink<String> {
  final EventSink<Map<String, dynamic>> _outputSink;
  final Converter<Uint8List, Object?>? decoder;
  final StringBuffer _dataBuffer = StringBuffer();

  _SSEEventSink(this._outputSink, {this.decoder});

  @override
  void add(String line) {
    if (line.isEmpty) {
      // Empty line indicates end of event
      if (_dataBuffer.isNotEmpty) {
        _processEvent();
      }
      return;
    }

    if (line.startsWith(":")) {
      // Comment line, ignore
      return;
    }

    if (line.startsWith("data:")) {
      // Extract data after "data:" prefix
      final data = line.substring(5).trim();
      if (_dataBuffer.isNotEmpty) {
        _dataBuffer.write("\n");
      }
      _dataBuffer.write(data);
    }
    // Other SSE fields like "event:", "id:", "retry:" can be handled here if needed
  }

  void _processEvent() {
    final data = _dataBuffer.toString();
    _dataBuffer.clear();

    if (data.isEmpty) return;

    try {
      final parsed = parseResponse(
        data,
        customDecoder: decoder,
      );

      _outputSink.add(parsed);
    } catch (e) {
      _outputSink.addError(e);
    }
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) =>
      _outputSink.addError(error, stackTrace);

  @override
  void close() {
    // Process any remaining data
    if (_dataBuffer.isNotEmpty) {
      _processEvent();
    }
    _outputSink.close();
  }
}
