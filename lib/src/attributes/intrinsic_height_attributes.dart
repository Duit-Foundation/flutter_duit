import 'package:duit_kernel/duit_kernel.dart';

/// Represents the attributes for an IntrinsicHeight widget.
///
/// This class implements the [DuitAttributes] interface, allowing it to be used with DUIT widgets.
final class IntrinsicHeightAttributes
    implements DuitAttributes<IntrinsicHeightAttributes> {
  IntrinsicHeightAttributes();

  factory IntrinsicHeightAttributes.fromJson(arg) {
    return IntrinsicHeightAttributes();
  }

  @override
  IntrinsicHeightAttributes copyWith(IntrinsicHeightAttributes other) {
    return this;
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) {
    return switch (methodName) {
      "fromJson" => this as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
