import 'package:flutter_duit/src/duit_impl/index.dart';
import 'package:flutter_duit/src/transport/index.dart';

abstract interface class TransportOptions {
  abstract TransportType type;
  abstract String? baseUrl;
  abstract Map<String, String> defaultHeaders;
}

final class HttpTransportOptions extends TransportOptions {
  @override
  TransportType type = TransportType.http;
  @override
  String? baseUrl;
  @override
  Map<String, String> defaultHeaders;
  HttpActionMetainfo? initialRequestMetainfo;

  HttpTransportOptions({
    this.initialRequestMetainfo,
    this.defaultHeaders = const {},
    this.baseUrl,
  });
}

final class WebSocketTransportOptions extends TransportOptions {
  @override
  TransportType type = TransportType.ws;

  @override
  String? baseUrl;

  @override
  Map<String, String> defaultHeaders;

  WebSocketTransportOptions({
    this.baseUrl,
    this.defaultHeaders = const {},
  });
}
