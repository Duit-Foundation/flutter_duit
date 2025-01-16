import "package:duit_kernel/duit_kernel.dart";
import "package:flutter_duit/src/animations/index.dart";
import "package:flutter_duit/src/utils/index.dart";

abstract interface class _OpacityProps {
  abstract final double opacity;
}

final class OpacityAttributes extends AnimatedPropertyOwner
    implements _OpacityProps, DuitAttributes<OpacityAttributes> {
  @override
  final double opacity;

  const OpacityAttributes({
    required this.opacity,
    required super.parentBuilderId,
    required super.affectedProperties,
  });

  @override
  OpacityAttributes copyWith(OpacityAttributes other) {
    return OpacityAttributes(
      opacity: other.opacity,
      parentBuilderId: other.parentBuilderId ?? parentBuilderId,
      affectedProperties: other.affectedProperties ?? affectedProperties,
    );
  }

  factory OpacityAttributes.fromJson(Map<String, dynamic> json) {
    final view = AnimatedPropHelper(json);

    return OpacityAttributes(
      opacity: NumUtils.toDoubleWithNullReplacement(view["opacity"], 1),
      parentBuilderId: view.parentBuilderId,
      affectedProperties: view.affectedProperties,
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

final class AnimatedOpacityAttributes extends ImplicitAnimatable
    implements _OpacityProps, DuitAttributes<AnimatedOpacityAttributes> {
  @override
  final double opacity;

  const AnimatedOpacityAttributes({
    required this.opacity,
    required super.duration,
    super.curve,
    super.onEnd,
  });

  factory AnimatedOpacityAttributes.fromJson(Map<String, dynamic> json) {
    return AnimatedOpacityAttributes(
      opacity: NumUtils.toDoubleWithNullReplacement(json["opacity"], 1),
      duration: AttributeValueMapper.toDuration(json["duration"]),
      curve: AttributeValueMapper.toCurve(json["curve"]),
      onEnd: JsonUtils.nullOrParse(
        "onEnd",
        json,
        ServerAction.parse,
      ),
    );
  }

  @override
  AnimatedOpacityAttributes copyWith(AnimatedOpacityAttributes other) {
    return AnimatedOpacityAttributes(
      opacity: other.opacity,
      duration: other.duration,
      curve: other.curve,
      onEnd: other.onEnd,
    );
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) {
    throw UnimplementedError();
  }
}
