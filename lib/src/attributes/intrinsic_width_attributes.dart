import 'package:flutter_duit/flutter_duit.dart';

/// Represents the attributes for an IntrinsicWidth widget.
///
/// This class implements the [DuitAttributes] interface, allowing it to be used with DUIT widgets.
final class IntrinsicWidthAttributes extends AnimatedPropertyOwner
    implements DuitAttributes<IntrinsicWidthAttributes> {
  final double? stepWidth, stepHeight;

  IntrinsicWidthAttributes(
      {this.stepWidth,
      this.stepHeight,
      required super.affectedProperties,
      required super.parentBuilderId});

  factory IntrinsicWidthAttributes.fromJson(Map<String, dynamic> json) {
    final view = AnimatedPropHelper(json);
    return IntrinsicWidthAttributes(
      stepWidth: json["stepWidth"],
      stepHeight: json["stepHeight"],
      parentBuilderId: view.parentBuilderId,
      affectedProperties: view.affectedProperties,
    );
  }

  @override
  IntrinsicWidthAttributes copyWith(IntrinsicWidthAttributes other) {
    return IntrinsicWidthAttributes(
      stepWidth: assignIfNotNull(other.stepWidth, stepWidth),
      stepHeight: assignIfNotNull(other.stepHeight, stepHeight),
      parentBuilderId: assignIfNotNull(other.parentBuilderId, parentBuilderId),
      affectedProperties:
          assignIfNotNull(other.affectedProperties, affectedProperties),
    );
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
