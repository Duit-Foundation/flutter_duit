import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/animations/index.dart';
import 'package:flutter_duit/src/utils/index.dart';

abstract interface class _PaddingProps {
  abstract final EdgeInsetsGeometry padding;
}

/// Represents the attributes for a Padding widget.
///
/// This class implements the [DuitAttributes] interface, allowing it to be used with DUIT widgets.
final class PaddingAttributes extends AnimatedPropertyOwner
    implements DuitAttributes<PaddingAttributes>, _PaddingProps {
  @override
  final EdgeInsetsGeometry padding;

  const PaddingAttributes({
    required this.padding,
    required super.parentBuilderId,
    required super.affectedProperties,
  });

  @override
  PaddingAttributes copyWith(other) {
    return PaddingAttributes(
      padding: other.padding,
      parentBuilderId: other.parentBuilderId,
      affectedProperties: other.affectedProperties,
    );
  }

  factory PaddingAttributes.fromJson(JSONObject json) {
    final view = AnimatedPropHelper(json);
    return PaddingAttributes(
      padding: AttributeValueMapper.toEdgeInsets(view["padding"]),
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
        PaddingAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}

final class AnimatedPaddingAttributes extends ImplicitAnimatable
    implements DuitAttributes<AnimatedPaddingAttributes>, _PaddingProps {
  @override
  final EdgeInsetsGeometry padding;

  const AnimatedPaddingAttributes({
    required super.duration,
    required this.padding,
    super.curve,
    super.onEnd,
  });

  factory AnimatedPaddingAttributes.fromJson(JSONObject json) {
    final action = ActionUtils(json);
    return AnimatedPaddingAttributes(
      padding: AttributeValueMapper.toEdgeInsets(json["padding"]),
      duration: AttributeValueMapper.toDuration(json["duration"]),
      curve: AttributeValueMapper.toCurve(json["curve"]),
      onEnd: action.parseAction("onEnd"),
    );
  }

  @override
  AnimatedPaddingAttributes copyWith(AnimatedPaddingAttributes other) {
    return AnimatedPaddingAttributes(
      padding: other.padding,
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
  }) =>
      throw UnimplementedError();
}
