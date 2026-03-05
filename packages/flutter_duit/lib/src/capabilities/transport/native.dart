import "package:duit_kernel/duit_kernel.dart";

final class NativeTransportManager with TransportCapabilityDelegate {
  late final UIDriver _driver;

  @override
  Stream<Map<String, dynamic>> connect({
    Map<String, dynamic>? initialRequestData,
    Map<String, dynamic>? staticContent,
  }) async* {
    yield* Stream.fromFuture(
      _driver.invokeNativeMethod<Map<String, dynamic>>("duit_connect", {
        ...?initialRequestData,
      }).then(
        (value) {
          if (value == null) {
            _driver.logCritical(
              "Failed to connect to native module",
              StateError(
                "Initial layout data is null",
              ),
              StackTrace.current,
            );
            return const {};
          }
          return value;
        },
      ),
    );
  }

  @override
  Future<Map<String, dynamic>?> executeRemoteAction(
    ServerAction action,
    Map<String, dynamic> payload,
  ) async =>
      _driver.invokeNativeMethod<Map<String, dynamic>>(
        "duit_execute",
        payload,
      );

  @override
  void linkDriver(UIDriver driver) => _driver = driver;

  @override
  void releaseResources() {}

  @override
  Future<Map<String, dynamic>?> request(
    String url,
    Map<String, dynamic> meta,
    Map<String, dynamic> body,
  ) async =>
      _driver.invokeNativeMethod<Map<String, dynamic>>(
        "duit_request",
        {
          "url": url,
          "meta": meta,
          "body": body,
        },
      );
}
