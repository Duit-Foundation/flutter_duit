import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

final class ConstrainedBoxAttributes extends AnimatedPropertyOwner
    implements DuitAttributes<ConstrainedBoxAttributes> {
  final BoxConstraints constraints;

  ConstrainedBoxAttributes({
    required super.parentBuilderId,
    required super.affectedProperties,
    required this.constraints,
  });

  factory ConstrainedBoxAttributes.fromJson(Map<String, dynamic> json) {
    final props = AnimatedPropHelper(json);

    return ConstrainedBoxAttributes(
      parentBuilderId: props.parentBuilderId,
      affectedProperties: props.affectedProperties,
      constraints: AttributeValueMapper.toBoxConstraints(props["constraints"]),
    );
  }

  @override
  ConstrainedBoxAttributes copyWith(ConstrainedBoxAttributes other) {
    return ConstrainedBoxAttributes(
      constraints: other.constraints,
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
        ConstrainedBoxAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
