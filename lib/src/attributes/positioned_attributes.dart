import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter_duit/src/animations/index.dart';
import 'package:flutter_duit/src/utils/index.dart';

abstract interface class _PositionedProps {
  abstract final double? left, top, right, bottom;
}

/// Represents the attributes for a Positioned widget.
///
/// This class implements the [DuitAttributes] interface, allowing it to be used with DUIT widgets.
final class PositionedAttributes extends AnimatedPropertyOwner
    implements DuitAttributes<PositionedAttributes>, _PositionedProps {
  @override
  final double? left, top, right, bottom;

  const PositionedAttributes({
    this.left,
    this.top,
    this.right,
    this.bottom,
    required super.parentBuilderId,
    required super.affectedProperties,
  });

  @override
  PositionedAttributes copyWith(other) {
    return PositionedAttributes(
      left: other.left ?? left,
      top: other.top ?? top,
      right: other.right ?? right,
      bottom: other.bottom ?? bottom,
      parentBuilderId: other.parentBuilderId,
      affectedProperties: other.affectedProperties,
    );
  }

  factory PositionedAttributes.fromJson(JSONObject json) {
    return PositionedAttributes(
      left: NumUtils.toDouble(json['left']),
      top: NumUtils.toDouble(json['top']),
      right: NumUtils.toDouble(json['right']),
      bottom: NumUtils.toDouble(json['bottom']),
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
        PositionedAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}

final class AnimatedPositionedAttributes extends ImplicitAnimatable
    implements DuitAttributes<AnimatedPositionedAttributes>, _PositionedProps {
  @override
  final double? left, top, right, bottom;

  const AnimatedPositionedAttributes({
    this.left,
    this.top,
    this.right,
    this.bottom,
    required super.duration,
    super.curve,
    super.onEnd,
  });

  factory AnimatedPositionedAttributes.fromJson(Map<String, dynamic> json) {
    final action = ActionUtils(json);
    return AnimatedPositionedAttributes(
      left: NumUtils.toDouble(json['left']),
      top: NumUtils.toDouble(json['top']),
      right: NumUtils.toDouble(json['right']),
      bottom: NumUtils.toDouble(json['bottom']),
      duration: AttributeValueMapper.toDuration(json['duration']),
      curve: AttributeValueMapper.toCurve(json['curve']),
      onEnd: action.parseAction("onEnd"),
    );
  }

  @override
  AnimatedPositionedAttributes copyWith(AnimatedPositionedAttributes other) {
    return AnimatedPositionedAttributes(
      left: other.left ?? left,
      top: other.top ?? top,
      right: other.right ?? right,
      bottom: other.bottom ?? bottom,
      duration: other.duration,
      curve: other.curve,
      onEnd: other.onEnd ?? onEnd,
    );
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) =>
      throw UnimplementedError();
}
