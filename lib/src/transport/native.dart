import 'dart:async';

import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter_duit/flutter_duit.dart';

final class NativeTransport extends Transport {
  final UIDriver driver;

  NativeTransport(this.driver) : super("");

  @override
  Future<Map<String, dynamic>?> connect({
    Map<String, dynamic>? initialData,
  }) async {
    try {
      return await driver.driverChannel?.invokeMethod<Map<String, dynamic>>(
      "duit_connect",
      {...?initialData,},
    );
    } catch (e, s) {
      driver.logger?.error(
        "NativeTransport connect error",
        error: e,
        stackTrace: s
      );
      rethrow;
    }
  }

  @override
  void dispose() {
    try {
      driver.driverChannel?.invokeMethod("duit_dispose");
    } catch (e, s) {
      driver.logger?.error(
        "NativeTransport dispose error",
        error: e,
        stackTrace: s
      );
      rethrow;
    }
  }

  @override
  FutureOr<Map<String, dynamic>?> execute(
    ServerAction action,
    Map<String, dynamic> payload,
  ) async {
    return await driver.driverChannel?.invokeMethod<Map<String, dynamic>>(
      "duit_execute",
      payload,
    );
  }

  @override
  FutureOr<Map<String, dynamic>?> request(
    String url,
    Map<String, dynamic> meta,
    Map<String, dynamic> body,
  ) async {
    return await driver.driverChannel?.invokeMethod<Map<String, dynamic>>(
      "duit_request",
      {
        "url": url,
        "meta": meta,
        "body": body,
      },
    );
  }
}
