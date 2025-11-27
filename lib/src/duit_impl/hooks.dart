import "dart:async";

import "package:duit_kernel/duit_kernel.dart";

///A mixin that adds driver definitions for hook
///functions that will be called during certain events
///
/// Example usage:
///
/// ```dart
/// DuitDriver(
///   "url",
///   transportOptions: HttpTransportOptions(,
///     defaultHeaders: {
///       "Content-Type": "application/json",
///     },
///    ),
/// )..onInit = () {
///   // ...
/// }..afterActionCallback = () {
///     print("Action handled");
/// }
///};
/// ```
mixin DriverHooks {
  ///Function called before driver initialization
  FutureOr<void> Function()? onInit;

  ///Function called before driver disposing
  FutureOr<void> Function()? onDispose;

  ///Function called when an [ServerEvent] is received
  FutureOr<void> Function(ServerEvent? event)? onEventReceived;

  ///Function called when an [ServerEvent] is handled
  FutureOr<void> Function()? onEventHandled;

  ///Function called before an [ServerAction] is executed
  FutureOr<void> Function(ServerAction action)? beforeActionCallback;

  ///Function called after an [ServerAction] is executed
  FutureOr<void> Function()? afterActionCallback;
}
