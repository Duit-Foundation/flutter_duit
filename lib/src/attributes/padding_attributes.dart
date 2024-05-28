import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// Represents the attributes for a Padding widget.
///
/// This class implements the [DuitAttributes] interface, allowing it to be used with DUIT widgets.
final class PaddingAttributes extends AnimatedPropertyOwner
    implements DuitAttributes<PaddingAttributes> {
  final EdgeInsetsGeometry? padding;

  PaddingAttributes({
    this.padding,
    required super.parentBuilderId,
    required super.affectedProperties,
  });

  @override
  PaddingAttributes copyWith(other) {
    return PaddingAttributes(
      padding: other.padding ?? padding,
      parentBuilderId: other.parentBuilderId,
      affectedProperties: other.affectedProperties,
    );
  }

  factory PaddingAttributes.fromJson(JSONObject json) {
    return PaddingAttributes(
      padding: ParamsMapper.convertToEdgeInsets(json["padding"]),
      parentBuilderId: json["parentBuilderId"],
      affectedProperties: Set.from(
        json["affectedProperties"] ?? {},
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
        PaddingAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
