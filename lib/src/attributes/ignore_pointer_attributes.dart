import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter_duit/src/utils/index.dart';

class IgnorePointerAttributes
    implements DuitAttributes<IgnorePointerAttributes> {
  final bool? ignoring;

  IgnorePointerAttributes({
    this.ignoring,
  });

  factory IgnorePointerAttributes.fromJson(JSONObject json) {
    return IgnorePointerAttributes(
      ignoring: json["ignoring"],
    );
  }

  @override
  IgnorePointerAttributes copyWith(IgnorePointerAttributes other) {
    return IgnorePointerAttributes(
      ignoring: other.ignoring ?? ignoring,
    );
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) {
    return switch (methodName) {
      "fromJson" =>
        IgnorePointerAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
