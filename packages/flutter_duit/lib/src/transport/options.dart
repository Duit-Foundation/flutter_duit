import 'package:flutter_duit/src/duit_impl/index.dart';
import 'package:flutter_duit/src/transport/index.dart';

abstract interface class TransportOptions {
  abstract TransportType type;
}

final class HttpTransportOptions extends TransportOptions {
  @override
  TransportType type = TransportType.http;
  Map<String, dynamic> defaultHeaders;
  HttpActionMetainfo initialRequestMetainfo;

  HttpTransportOptions({
    required this.initialRequestMetainfo,
    this.defaultHeaders = const {},
  });
}

final class WebSocketTransportOptions extends TransportOptions {
  @override
  TransportType type = TransportType.ws;
}
