import "package:duit_kernel/duit_kernel.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/capabilities/index.dart";

extension type XDriver._(DuitDriver _driver)
    implements DriverHooks, FocusCapabilityDelegate {
  factory XDriver.static(
    Map<String, dynamic> content,
  ) {
    if (content.isEmpty) {
      throw StateError(
        "[content] property must be valid Duit json struct",
      );
    }
    return XDriver._(
      DuitDriver.static(
        content,
        transportOptions: EmptyTransportOptions(),
      ),
    );
  }

  @preferInline
  void attachExternalHandler(
    UserDefinedHandlerKind type,
    UserDefinedEventHandler handle,
  ) =>
      attachExternalHandler(type, handle);

  @preferInline
  void addExternalEventStream(
    Stream<Map<String, dynamic>> stream,
  ) =>
      addExternalEventStream(
        stream,
      );

  @preferInline
  Future<void> init() async => init();

  @preferInline
  void dispose() => dispose();
}
