import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class OpacityAttributes extends AnimatedPropertyOwner
    implements DuitAttributes<OpacityAttributes> {
  final double opacity;

  OpacityAttributes({
    required this.opacity,
    required super.parentBuilderId,
    required super.affectedProperties,
  });

  @override
  OpacityAttributes copyWith(OpacityAttributes other) {
    return OpacityAttributes(
      opacity: other.opacity,
      parentBuilderId: other.parentBuilderId,
      affectedProperties: other.affectedProperties,
    );
  }

  factory OpacityAttributes.fromJson(Map<String, dynamic> json) {
    return OpacityAttributes(
      opacity: NumUtils.toDoubleWithNullReplacement(json['opacity'], 1),
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
        OpacityAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
