import 'dart:async';
import 'dart:convert';
import 'dart:core';
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
  FutureOr<void> execute(event, payload) {
    // TODO: implement execute
    throw UnimplementedError();
  }

  @override
  void dispose() {
    client.close();
  }
}
