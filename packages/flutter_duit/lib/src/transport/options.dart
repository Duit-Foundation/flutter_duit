import 'package:flutter_duit/src/duit_impl/index.dart';
import 'package:flutter_duit/src/transport/index.dart';

abstract interface class TransportOptions {
  abstract TransportType type;
}

final class HttpTransportOptions extends TransportOptions {
  @override
  TransportType type = TransportType.http;
  String? baseUrl;
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
}
