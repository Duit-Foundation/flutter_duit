import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/services.dart";

final class DuitNativeModuleManager with NativeModuleCapabilityDelegate {
  late final UIDriver _driver;
  late final MethodChannel _driverChannel;

  @override
  void linkDriver(UIDriver driver) => _driver = driver;

  @override
  Future<void> initNativeModule() async {
    _driverChannel = const MethodChannel("duit:driver");
    _driverChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "duit_event":
          await _driver.resolveEvent(
            _driver.buildContext,
            call.arguments as Map<String, dynamic>,
          );
          break;
        case "duit_layout":
          final json = call.arguments as Map<String, dynamic>;
          final view = await _driver.prepareLayout(json);
          if (view != null) {
            _driver.addUIDriverEvent(
              UIDriverViewEvent(view),
            );
          }
          break;
        default:
          _driver.logWarning("Unknown method: ${call.method}");
          break;
      }
    });
  }

  @override
  @preferInline
  Future<T?> invokeNativeMethod<T>(
    String method, [
    arguments,
  ]) async =>
      _driverChannel.invokeMethod<T>(method, arguments);

  @override
  void releaseResources() {
    _driverChannel.setMethodCallHandler(null);
  }
}
