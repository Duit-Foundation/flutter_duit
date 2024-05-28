import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class AlignAttributes extends AnimatedPropertyOwner
    implements DuitAttributes<AlignAttributes> {
  final AlignmentGeometry? alignment;
  final double? widthFactor, heightFactor;

  const AlignAttributes({
    this.alignment,
    this.widthFactor,
    this.heightFactor,
    required super.parentBuilderId,
    required super.affectedProperties,
  });

  factory AlignAttributes.fromJson(JSONObject json) {
    return AlignAttributes(
      alignment: ParamsMapper.convertToAlignment(json["alignment"]),
      widthFactor: NumUtils.toDouble(json["widthFactor"]),
      heightFactor: NumUtils.toDouble(json["heightFactor"]),
      parentBuilderId: json["parentBuilderId"],
      affectedProperties: Set.from(json["affectedProperties"] ?? {}),
    );
  }

  @override
  AlignAttributes copyWith(AlignAttributes other) {
    return AlignAttributes(
      alignment: other.alignment ?? alignment,
      widthFactor: other.widthFactor ?? widthFactor,
      heightFactor: other.heightFactor ?? heightFactor,
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
        AlignAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
