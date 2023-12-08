import 'package:flutter_duit/src/duit_impl/index.dart';
import 'package:flutter_duit/src/transport/index.dart';

/// The base options for configuring a transport.
abstract interface class TransportOptions {
  /// The type of the transport.
  abstract TransportType type;

  /// The base URL for the transport.
  abstract String? baseUrl;

  /// The default headers to be included in the transport requests.
  abstract Map<String, String> defaultHeaders;
}

/// The options for configuring the HTTP transport.
final class HttpTransportOptions extends TransportOptions {
  /// The type of the transport, which is always [TransportType.http].
  @override
  TransportType type = TransportType.http;

  /// The base URL for the HTTP requests.
  @override
  String? baseUrl;

  /// The default headers to be included in the HTTP requests.
  @override
  Map<String, String> defaultHeaders;

  /// The metadata associated with the initial HTTP request made by the [HttpTransport].
  ///
  /// This property allows you to customize the HTTP method used for the initial request.
  ///
  /// By default, the [initialRequestMetainfo] is `null`, which means that the HTTP method is determined by the specific implementation of the [HttpTransport].
  ///
  /// Example:
  /// ```dart
  /// final options = HttpTransportOptions(
  ///   initialRequestMetainfo: HttpActionMetainfo(method: "POST"),
  ///   // ...
  /// );
  /// ```
  HttpActionMetainfo? initialRequestMetainfo;

  HttpTransportOptions({
    this.initialRequestMetainfo,
    this.defaultHeaders = const {},
    this.baseUrl,
  });
}

/// The options for configuring the WebSocket transport.
final class WebSocketTransportOptions extends TransportOptions {
  /// The type of the transport, which is always [TransportType.ws].
  @override
  TransportType type = TransportType.ws;

  /// The base URL for the HTTP requests.
  @override
  String? baseUrl;

  /// The default headers to be included in the HTTP requests.
  @override
  Map<String, String> defaultHeaders;

  WebSocketTransportOptions({
    this.baseUrl,
    this.defaultHeaders = const {},
  });
}
