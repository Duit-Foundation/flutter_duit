import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/duit_impl/event.dart';
import 'package:flutter_duit/src/utils/index.dart';
import 'package:http/http.dart' as http;

import 'transport.dart';

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
    final result = jsonDecode(res.body) as Map<String, dynamic>;
    return result;
  }

  @override
  FutureOr<ServerEvent?> execute(action, payload, headers) async {
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
              ...headers ?? {},
            });
            final data = jsonDecode(res.body) as Map<String, dynamic>;
            return ServerEvent.fromJson(data);
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
                ...headers ?? {},
              },
            );
            final data = jsonDecode(res.body) as Map<String, dynamic>;
            return ServerEvent.fromJson(data);
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
                ...headers ?? {},
              },
            );
            final data = jsonDecode(res.body) as Map<String, dynamic>;
            return ServerEvent.fromJson(data);
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
                ...headers ?? {},
              },
            );
            final data = jsonDecode(json.body) as JSONObject;
            return ServerEvent.fromJson(data);
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
