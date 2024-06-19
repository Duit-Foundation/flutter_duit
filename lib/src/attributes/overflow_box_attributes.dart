import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class OverflowBoxAttributes extends AnimatedPropertyOwner
    implements DuitAttributes<OverflowBoxAttributes> {
  final double? minWidth, maxWidth, minHeight, maxHeight;
  final AlignmentGeometry? alignment;
  final OverflowBoxFit? fit;

  const OverflowBoxAttributes({
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.fit,
    this.alignment,
    required super.parentBuilderId,
    required super.affectedProperties,
  });

  factory OverflowBoxAttributes.fromJson(Map<String, dynamic> json) {
    return OverflowBoxAttributes(
      minWidth: NumUtils.toDouble(json['minWidth']),
      maxWidth: NumUtils.toDouble(json['maxWidth']),
      minHeight: NumUtils.toDouble(json['minHeight']),
      maxHeight: NumUtils.toDouble(json['maxHeight']),
      fit: AttributeValueMapper.toOverflowBoxFit(json['fit']),
      alignment: AttributeValueMapper.toAlignment(
        json['alignment'],
      ),
      parentBuilderId: json['parentBuilderId'],
      affectedProperties: Set.from(
        json['affectedProperties'] ?? {},
      ),
    );
  }

  @override
  OverflowBoxAttributes copyWith(OverflowBoxAttributes other) {
    return OverflowBoxAttributes(
      minWidth: other.minWidth ?? minWidth,
      maxWidth: other.maxWidth ?? maxWidth,
      minHeight: other.minHeight ?? minHeight,
      maxHeight: other.maxHeight ?? maxHeight,
      fit: other.fit ?? fit,
      alignment: other.alignment ?? alignment,
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
        OverflowBoxAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
