import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:typed_data';
import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/utils/index.dart';
import 'package:http/http.dart' as http;

import 'transport_utils.dart';

/// An HTTP transport implementation for making HTTP requests.
///
/// This class extends the [Transport] class and provides the functionality to
/// make HTTP requests to a server. It uses the `http` package for performing
/// the HTTP operations.
///
/// To use this transport, you need to provide a base URL and [HttpTransportOptions].
///
/// Example usage:
/// ```dart
/// final transport = HttpTransport(
///   'https://api.example.com',
///   options: HttpTransportOptions(),
/// );
/// ```
final class HttpTransport extends Transport {
  final client = http.Client();
  final HttpTransportOptions options;

  HttpTransport(
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
  Future<Map<String, dynamic>?> connect({
    Map<String, dynamic>? initialData,
  }) async {
    assert(url.isNotEmpty, "Invalid url: $url}");

    final urlString = _prepareUrl(url);
    Uri uri;

    final reqInter = options.requestInterceptor;
    final errInter = options.errorInterceptor;

    try {
      ///Try read initial request method from metainfo
      final method = options.initialRequestMetainfo?.method ?? "GET";

      if (method == "POST") {
        uri = Uri.parse(urlString);
      } else {
        uri = objectToURLWithQueryParams(urlString, initialData);
      }

      ///Create new request, add headers and body if needed
      final request = http.Request(method, uri)
        ..headers.addAll(options.defaultHeaders);
      if (method == "POST") {
        request.bodyFields = {
          ...?initialData,
        };
      }

      ///Call request interceptor
      reqInter?.call(request);

      ///Send request and await for response
      final response = await request.send();

      final res = await response.stream.toBytes();

      return await _parseResponse(res);
    } catch (e) {
      ///Call error interceptor
      errInter?.call(e);
      return null;
    }
  }

  Future<Map<String, dynamic>?> _parseResponse(Uint8List data) async {
    if (options.decoder != null) {
      final decodingResult =
          options.decoder!.convert(data) as Map<String, dynamic>;
      return decodingResult;
    }

    ///If concurrency is not enabled, run the task in main isolate
    return jsonDecode(utf8.decode(data)) as Map<String, dynamic>;
  }

  @override
  FutureOr<JSONObject?> execute(action, payload) async {
    if (action is! TransportAction) return null;

    ///Prepare url and method
    String method = switch (action.meta) {
      null => "GET",
      HttpActionMetainfo() => action.meta!.method,
    };

    final urlString = _prepareUrl(action.eventName);
    Uri uri;
    final reqInter = options.requestInterceptor;
    final errInter = options.errorInterceptor;

    try {
      if (method == "POST") {
        uri = Uri.parse(urlString);
      } else {
        uri = objectToURLWithQueryParams(urlString, payload);
      }

      ///Create new request, add headers and body if needed
      final request = http.Request(method, uri)
        ..headers.addAll(options.defaultHeaders);
      if (method == "POST") {
        request.body = options.encoder != null
            ? options.encoder!.convert(payload)
            : jsonEncode(payload);
      }

      ///Call request interceptor
      reqInter?.call(request);

      ///Send request and await for response
      final response = await request.send();

      final byteData = await response.stream.toBytes();
      return await _parseResponse(byteData);
    } catch (e) {
      ///Call error interceptor
      errInter?.call(e);
      return null;
    }
  }

  @override
  FutureOr<Map<String, dynamic>?> request(
    String url,
    Map<String, dynamic> meta,
    Map<String, dynamic> body,
  ) async {
    final method = meta["method"] ?? "GET";

    final urlString = _prepareUrl(url);
    Uri uri;
    final reqInter = options.requestInterceptor;
    final errInter = options.errorInterceptor;

    try {
      if (method == "POST") {
        uri = Uri.parse(urlString);
      } else {
        uri = objectToURLWithQueryParams(urlString, body);
      }

      ///Create new request, add headers and body if needed
      final request = http.Request(method, uri)
        ..headers.addAll(options.defaultHeaders);
      if (method == "POST") {
        request.body = options.encoder != null
            ? options.encoder!.convert(body)
            : jsonEncode(body);
      }

      ///Call request interceptor
      reqInter?.call(request);

      ///Send request and await for response
      final response = await request.send();

      final byteData = await response.stream.toBytes();
      return await _parseResponse(byteData);
    } catch (e) {
      errInter?.call(e);
      return null;
    }
  }

  @override
  void dispose() {
    client.close();
  }
}
