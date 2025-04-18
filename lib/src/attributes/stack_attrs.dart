import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// Represents the attributes for a Stack widget.
///
/// This class implements the [DuitAttributes] interface, allowing it to be used with DUIT widgets.
final class StackAttributes extends AnimatedPropertyOwner
    implements DuitAttributes<StackAttributes> {
  final AlignmentGeometry? alignment;
  final TextDirection? textDirection;
  final StackFit? fit;
  final Clip? clipBehavior;

  StackAttributes({
    required this.alignment,
    this.textDirection,
    required this.fit,
    required this.clipBehavior,
    required super.parentBuilderId,
    required super.affectedProperties,
  });

  factory StackAttributes.fromJson(JSONObject json) {
    return StackAttributes(
      alignment: AttributeValueMapper.toAlignmentDirectional(json["alignment"]),
      textDirection:
          AttributeValueMapper.toTextDirection(json["textDirection"]),
      fit: AttributeValueMapper.toStackFit(json["fit"]),
      clipBehavior: AttributeValueMapper.toClip(json["clipBehavior"]),
      parentBuilderId: json["parentBuilderId"],
      affectedProperties: Set.from(
        json["affectedProperties"] ?? {},
      ),
    );
  }

  @override
  StackAttributes copyWith(other) {
    return StackAttributes(
      alignment: other.alignment ?? alignment,
      textDirection: other.textDirection ?? textDirection,
      fit: other.fit ?? fit,
      clipBehavior: other.clipBehavior ?? clipBehavior,
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
        StackAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
