import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// Represents the attributes for a Positioned widget.
///
/// This class implements the [DuitAttributes] interface, allowing it to be used with DUIT widgets.
final class PositionedAttributes extends AnimatedPropertyOwner
    implements DuitAttributes<PositionedAttributes> {
  final double? left, top, right, bottom;

  PositionedAttributes({
    this.left,
    this.top,
    this.right,
    this.bottom,
    required super.parentBuilderId,
    required super.affectedProperties,
  });

  @override
  PositionedAttributes copyWith(other) {
    return PositionedAttributes(
      left: other.left ?? left,
      top: other.top ?? top,
      right: other.right ?? right,
      bottom: other.bottom ?? bottom,
      parentBuilderId: other.parentBuilderId,
      affectedProperties: other.affectedProperties,
    );
  }

  factory PositionedAttributes.fromJson(JSONObject json) {
    return PositionedAttributes(
      left: NumUtils.toDouble(json['left']),
      top: NumUtils.toDouble(json['top']),
      right: NumUtils.toDouble(json['right']),
      bottom: NumUtils.toDouble(json['bottom']),
      parentBuilderId: json['parentBuilderId'],
      affectedProperties: Set.from(
        json['affectedProperties'] ?? {},
      ),
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
        PositionedAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
