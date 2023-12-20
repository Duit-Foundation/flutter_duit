import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/duit_impl/event.dart';
import 'package:flutter_duit/src/utils/index.dart';
import 'package:http/http.dart' as http;

import 'transport.dart';

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
  Future<Map<String, dynamic>?> connect() async {
    assert(url.isNotEmpty, "Invalid url: $url}");

    final urlString = _prepareUrl(url);

    final res =
        await client.get(Uri.parse(urlString), headers: options.defaultHeaders);
    return jsonDecode(res.body) as Map<String, dynamic>;
  }

  @override
  FutureOr<JSONObject?> execute(action, payload) async {
    String method = switch (action.meta) {
      null => "GET",
      HttpActionMetainfo() => action.meta!.method,
    };

    switch (method) {
      case "GET":
        {
          Uri uri;
          var urlString = _prepareUrl(action.event);

          if (payload.isNotEmpty) {
            urlString += "?";
            payload.forEach((key, value) {
              urlString += "$key=$value";
            });
            uri = Uri.parse(urlString);
          } else {
            uri = Uri.parse(urlString);
          }

          try {
            final res = await client.get(uri, headers: {
              ...options.defaultHeaders,
            });
            return jsonDecode(res.body) as Map<String, dynamic>;
          } catch (e) {
            rethrow;
          }
        }
      case "POST":
        {
          final urlString = _prepareUrl(action.event);
          try {
            final res = await client.post(
              Uri.parse(urlString),
              body: jsonEncode(payload),
              headers: {
                ...options.defaultHeaders,
              },
            );
            return jsonDecode(res.body) as Map<String, dynamic>;
          } catch (e) {
            rethrow;
          }
        }
      case "DELETE":
        {
          final urlString = _prepareUrl(action.event);
          try {
            final res = await client.delete(
              Uri.parse(urlString),
              body: jsonEncode(payload),
              headers: {
                ...options.defaultHeaders,
              },
            );
            return jsonDecode(res.body) as Map<String, dynamic>;
          } catch (e) {
            rethrow;
          }
        }
      case "PATCH":
        {
          final urlString = _prepareUrl(action.event);
          try {
            final json = await client.patch(
              Uri.parse(urlString),
              body: jsonEncode(payload),
              headers: {
                ...options.defaultHeaders,
              },
            );
            return jsonDecode(json.body) as JSONObject;
          } catch (e) {
            rethrow;
          }
        }
    }

    return null;
  }

  @override
  void dispose() {
    client.close();
  }
}
