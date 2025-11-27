import "dart:async";

import "package:flutter_duit/flutter_duit.dart";

final class EmptyTransport implements Transport {
  @override
  Future<Map<String, dynamic>?> connect({Map<String, dynamic>? initialData}) {
    throw UnimplementedError();
  }

  @override
  void dispose() {}

  @override
  FutureOr<Map<String, dynamic>?> execute(
    ServerAction action,
    Map<String, dynamic> payload,
  ) {
    throw UnimplementedError();
  }

  @override
  FutureOr<Map<String, dynamic>?> request(
    String url,
    Map<String, dynamic> meta,
    Map<String, dynamic> body,
  ) {
    throw UnimplementedError();
  }

  @override
  // TODO: implement url
  String get url => throw UnimplementedError();
}
