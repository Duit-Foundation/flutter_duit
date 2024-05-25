import 'dart:async';
import 'dart:convert';
import 'dart:core';
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
  final bool concurrencyEnabled;

  HttpTransport(
    super.url, {
    super.workerPool,
    required this.options,
    required this.concurrencyEnabled,
  });

  String _prepareUrl(String url) {
    String urlString = "";
    if (options.baseUrl != null) {
      urlString += options.baseUrl!;
    }

    return urlString += url;
  }

  @override
  Future<Map<String, dynamic>?> connect(
      {Map<String, dynamic>? initialData}) async {
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
      await for (final byteData in response.stream) {
        return await _parseJson(byteData);
      }
    } catch (e) {
      ///Call error interceptor
      errInter?.call(e);
      return null;
    }

    return null;
  }

  Future<Map<String, dynamic>> _parseJson(dynamic data) async {
    ///Check if concurrency is enabled and run the task in isolate
    if (concurrencyEnabled && workerPool != null) {
      final taskResult = await workerPool!.perform(
        (params) {
          return jsonDecode(params);
        },
        utf8.decode(data),
      );
      return taskResult.result as Map<String, dynamic>;
    }

    ///If concurrency is not enabled, run the task in main isolate
    return jsonDecode(utf8.decode(data)) as Map<String, dynamic>;
  }

  @override
  FutureOr<JSONObject?> execute(action, payload) async {
    ///Prepare url and method
    String method = switch (action.meta) {
      null => "GET",
      HttpActionMetainfo() => action.meta!.method,
    };

    final urlString = _prepareUrl(action.event);
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
        request.body = jsonEncode(payload);
      }

      ///Call request interceptor
      reqInter?.call(request);

      ///Send request and await for response
      final response = await request.send();
      await for (final byteData in response.stream) {
        return await _parseJson(byteData);
      }
    } catch (e) {
      ///Call error interceptor
      errInter?.call(e);
      return null;
    }

    return null;
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
        request.body = jsonEncode(body);
      }

      ///Call request interceptor
      reqInter?.call(request);

      ///Send request and await for response
      final response = await request.send();
      await for (final byteData in response.stream) {
        return await _parseJson(byteData);
      }
    } catch (e) {
      errInter?.call(e);
      return null;
    }

    return null;
  }

  @override
  void dispose() {
    client.close();
  }
}
