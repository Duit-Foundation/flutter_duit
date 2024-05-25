import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// Represents the attributes for a Expanded widget.
///
/// This class implements the [DuitAttributes] interface, allowing it to be used with DUIT widgets.
class ExpandedAttributes implements DuitAttributes<ExpandedAttributes> {
  final int? flex;

  ExpandedAttributes({
    required this.flex,
  });

  @override
  ExpandedAttributes copyWith(ExpandedAttributes other) {
    return ExpandedAttributes(
      flex: other.flex ?? flex,
    );
  }

  factory ExpandedAttributes.fromJson(JSONObject map) {
    num flx = map['flex'] ?? 1;

    return ExpandedAttributes(
      flex: flx.toInt(),
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
        ExpandedAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
