import "package:duit_kernel/duit_kernel.dart";

final class DuitStubScriptingManager with ScriptingCapabilityDelegate {
  late final UIDriver _driver;

  @override
  Future<void> evalScript(String source) async {
    _driver.logWarning(
      "evalScript method is not implemented for stub scripting",
    );
  }

  @override
  Future<Map<String, dynamic>?> execScript(
    String functionName, {
    String? url,
    Map<String, dynamic>? meta,
    Map<String, dynamic>? body,
  }) async {
    _driver.logWarning(
      "execScript method is not implemented for stub scripting",
    );
    return null;
  }

  @override
  Future<void> initScriptingCapability() async {
    _driver.logInfo(
      "used stub scripting capability, scripts execution is disabled",
    );
  }

  @override
  void linkDriver(UIDriver driver) => _driver = driver;

  @override
  @preferInline
  void releaseResources() {}
}
