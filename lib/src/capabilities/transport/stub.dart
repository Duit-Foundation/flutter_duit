import "dart:async";

import "package:duit_kernel/duit_kernel.dart";

final class StubTransportManager with TransportCapabilityDelegate {
  late final UIDriver _driver;

  StubTransportManager();

  @override
  void linkDriver(UIDriver driver) => _driver = driver;

  @override
  Future<Map<String, dynamic>> executeRemoteAction(
    ServerAction action,
    Map<String, dynamic> payload,
  ) async {
    _driver.logger?.warn(
      "executeRemoteAction method is not implemented for stub transport",
    );
    return Future.value(const {});
  }

  @override
  Stream<Map<String, dynamic>> connect({
    Map<String, dynamic>? initialRequestData,
    Map<String, dynamic>? staticContent,
  }) async* {
    _driver.logger?.warn(
      "connect method is not implemented for stub transport",
    );
    yield staticContent ?? const {};
  }

  @override
  Future<Map<String, dynamic>> request(
    String url,
    Map<String, dynamic> meta,
    Map<String, dynamic> body,
  ) async {
    _driver.logger?.warn(
      "request method is not implemented for stub transport",
    );
    return Future.value(const {});
  }

  @override
  void releaseResources() {}
}
