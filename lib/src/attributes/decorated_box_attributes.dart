import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// Represents the attributes for a DecoratedBox widget.
///
/// This class implements the [DuitAttributes] interface, allowing it to be used with DUIT widgets.
final class DecoratedBoxAttributes extends AnimatedPropertyOwner
    implements DuitAttributes<DecoratedBoxAttributes> {
  final Decoration? decoration;

  DecoratedBoxAttributes({
    required this.decoration,
    required super.parentBuilderId,
    required super.affectedProperties,
  });

  factory DecoratedBoxAttributes.fromJson(JSONObject json) {
    return DecoratedBoxAttributes(
      decoration: AttributeValueMapper.toDecoration(json["decoration"]),
      parentBuilderId: json["parentBuilderId"],
      affectedProperties: Set.from(json["affectedProperties"] ?? {}),
    );
  }

  @override
  DecoratedBoxAttributes copyWith(other) {
    return DecoratedBoxAttributes(
      decoration: other.decoration ?? decoration,
      parentBuilderId: other.parentBuilderId ?? parentBuilderId,
      affectedProperties: other.affectedProperties ?? affectedProperties,
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
        DecoratedBoxAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
