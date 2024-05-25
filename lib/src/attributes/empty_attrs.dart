import 'package:duit_kernel/duit_kernel.dart';

/// Represents the attributes for an empty widget.
///
/// This class can be used to represent an empty widget that has no specific attributes or properties.
final class EmptyAttributes implements DuitAttributes<EmptyAttributes> {
  @override
  EmptyAttributes copyWith(EmptyAttributes other) {
    return EmptyAttributes();
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) {
    return switch (methodName) {
      String() => throw UnimplementedError(
          "$methodName is not implemented on EmptyAttributes"),
    };
  }
}
