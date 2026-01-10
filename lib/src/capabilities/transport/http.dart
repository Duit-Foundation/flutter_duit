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

  HttpTransportManager({
    required this.url,
    this.baseUrl = "",
    this.defaultHeaders = const {},
    this.requestInterceptor,
    this.errorInterceptor,
    this.encoder,
    this.decoder,
    this.initialRequestMethod = "GET",
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

  @override
  void releaseResources() {
    _client.close();
  }
}
