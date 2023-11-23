import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:flutter_duit/src/duit_impl/index.dart';
import 'package:flutter_duit/src/duit_impl/widgets_update_set.dart';
import 'package:http/http.dart' as http;

import 'transport.dart';

final class HttpTransport extends Transport {
  final client = http.Client();

  HttpTransport(super.url);

  @override
  Future<Map<String, dynamic>?> connect() async {
    assert(url.isNotEmpty, "Invalid url: $url}");

    final res = await client.get(Uri.parse(url));
    final result =
        jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;

    return result;
  }

  @override
  FutureOr<WidgetsUpdateSet?> execute(action, payload) async {
    String method = switch (action.meta) {
      null => "GET",
      HttpActionMetainfo() => action.meta!.method,
    };

    switch (method) {
      case "GET":
        {
          Uri uri;

          if (payload.isNotEmpty) {
            var urlString = "${action.event}?";
            payload.forEach((key, value) {
              urlString += "$key=$value";
            });
            uri = Uri.parse(urlString);
          } else {
            uri = Uri.parse(action.event);
          }

          await client.get(uri);
        }
      case "POST":
        {}
      case "DELETE":
        {}
      case "PATCH":
        {}
    }

    return null;
  }

  @override
  void dispose() {
    client.close();
  }
}
