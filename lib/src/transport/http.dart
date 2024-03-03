import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/utils/index.dart';
import 'package:http/http.dart' as http;

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
    super.workerPool,
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

    return await _parseJson(res.bodyBytes);
  }

  Future<Map<String, dynamic>> _parseJson(dynamic data) async {
    if (workerPool != null) {
      return await workerPool!.perform(ParseJsonTask(data))
          as Map<String, dynamic>;
    }
    return jsonDecode(utf8.decode(data)) as Map<String, dynamic>;
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
            return await _parseJson(res.bodyBytes);
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
            return await _parseJson(res.bodyBytes);
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
            return await _parseJson(res.bodyBytes);
          } catch (e) {
            rethrow;
          }
        }
      case "PATCH":
        {
          final urlString = _prepareUrl(action.event);
          try {
            final res = await client.patch(
              Uri.parse(urlString),
              body: jsonEncode(payload),
              headers: {
                ...options.defaultHeaders,
              },
            );
            return await _parseJson(res.bodyBytes);
          } catch (e) {
            rethrow;
          }
        }
    }

    return null;
  }

  @override
  FutureOr<Map<String, dynamic>?> request(
    String url,
    Map<String, dynamic> meta,
    Map<String, dynamic> body,
  ) async {
    final method = meta["method"] as String?;

    final httpMethod = switch (method) {
      "POST" => "POST",
      "GET" || null || String() => "GET",
    };

    if (httpMethod == "GET") {
      final res = await client.get(
        Uri.parse(_prepareUrl(url)),
        headers: {
          ...options.defaultHeaders,
        },
      );

      return await _parseJson(res.bodyBytes);
    } else {
      final res = await client.post(
        Uri.parse(_prepareUrl(url)),
        body: jsonEncode(body),
        headers: {
          ...options.defaultHeaders,
        },
      );
      return await _parseJson(res.bodyBytes);
    }
  }

  @override
  void dispose() {
    client.close();
  }
}
