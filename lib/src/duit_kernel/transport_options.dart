/// The base options for configuring a transport.
abstract class TransportOptions {
  /// The type of the transport.
  abstract String type;

  /// The base URL for the transport.
  abstract String? baseUrl;

  /// The default headers to be included in the transport requests.
  abstract Map<String, String> defaultHeaders;
}