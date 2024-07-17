import 'dart:async';

import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter_duit/flutter_duit.dart';

final class NativeTransport extends Transport {
  final DuitDriver driver;

  NativeTransport(this.driver) : super("");

  @override
  Future<Map<String, dynamic>?> connect({
    Map<String, dynamic>? initialData,
  }) async {
    return await driver.emitNativeEvent<Map<String, dynamic>>(
      "duit_connect",
      {...?initialData},
    );
  }

  @override
  void dispose() {
    driver.emitNativeEvent("duit_dispose");
  }

  @override
  FutureOr<Map<String, dynamic>?> execute(
    ServerAction action,
    Map<String, dynamic> payload,
  ) async {
    return await driver.emitNativeEvent<Map<String, dynamic>>(
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
    return await driver.emitNativeEvent<Map<String, dynamic>>(
      "duit_request",
      {
        "url": url,
        "meta": meta,
        "body": body,
      },
    );
  }
}
