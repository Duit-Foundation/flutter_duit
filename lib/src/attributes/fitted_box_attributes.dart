import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class FittedBoxAttributes extends AnimatedPropertyOwner
    implements DuitAttributes<FittedBoxAttributes> {
  final BoxFit? fit;
  final Clip? clipBehavior;
  final AlignmentGeometry? alignment;

  FittedBoxAttributes({
    required this.clipBehavior,
    required this.alignment,
    required this.fit,
    required super.parentBuilderId,
    required super.affectedProperties,
  });

  factory FittedBoxAttributes.fromJson(Map<String, dynamic> json) {
    return FittedBoxAttributes(
      fit: AttributeValueMapper.toBoxFit(json['fit']),
      clipBehavior: AttributeValueMapper.toClip(json['clipBehavior']),
      alignment: AttributeValueMapper.toAlignment(json['alignment']),
      parentBuilderId: json['parentBuilderId'],
      affectedProperties: Set.from(
        json['affectedProperties'] ?? {},
      ),
    );
  }

  @override
  FittedBoxAttributes copyWith(FittedBoxAttributes other) {
    return FittedBoxAttributes(
      fit: other.fit ?? fit,
      clipBehavior: other.clipBehavior ?? clipBehavior,
      alignment: other.alignment ?? alignment,
      parentBuilderId: other.parentBuilderId,
      affectedProperties: other.affectedProperties,
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
        FittedBoxAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
