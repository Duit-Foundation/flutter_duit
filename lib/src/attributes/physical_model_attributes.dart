import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/animations/index.dart';
import 'package:flutter_duit/src/utils/index.dart';

abstract interface class _PhysicalModelProps {
  abstract final double elevation;
  abstract final Color color;
  abstract final Color shadowColor;
  abstract final Clip clipBehavior;
  abstract final BorderRadius? borderRadius;
  abstract final BoxShape shape;
}

/// Represents the attributes for a PhysicalModel widget.
///
/// This class implements the [DuitAttributes] interface, allowing it to be used with DUIT widgets.
final class PhysicalModelAttributes extends AnimatedPropertyOwner
    implements _PhysicalModelProps, DuitAttributes<PhysicalModelAttributes> {
  @override
  final double elevation;
  @override
  final Color color;
  @override
  final Color shadowColor;
  @override
  final Clip clipBehavior;
  @override
  final BorderRadius? borderRadius;
  @override
  final BoxShape shape;

  const PhysicalModelAttributes({
    required this.elevation,
    required this.color,
    required this.shadowColor,
    required this.clipBehavior,
    this.borderRadius,
    required this.shape,
    required super.parentBuilderId,
    required super.affectedProperties,
  });

  factory PhysicalModelAttributes.fromJson(Map<String, dynamic> json) {
    final view = AnimatedPropHelper(json);
    return PhysicalModelAttributes(
      elevation: NumUtils.toDoubleWithNullReplacement(json['elevation'], 0.0),
      color: ColorUtils.tryParseColor(json['color']),
      shadowColor: ColorUtils.tryParseColor(json['shadowColor']),
      clipBehavior: AttributeValueMapper.toClip(
        json['clipBehavior'],
        Clip.none,
      ),
      borderRadius: AttributeValueMapper.toBorderRadius(json['borderRadius']),
      shape: AttributeValueMapper.toBoxShape(json['shape']),
      parentBuilderId: view.parentBuilderId,
      affectedProperties: view.affectedProperties,
    );
  }

  @override
  PhysicalModelAttributes copyWith(other) {
    return PhysicalModelAttributes(
      elevation: other.elevation,
      color: other.color,
      shadowColor: other.shadowColor,
      clipBehavior: other.clipBehavior,
      borderRadius: other.borderRadius ?? borderRadius,
      shape: other.shape,
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
        PhysicalModelAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}

/// Represents the attributes for an AnimatedPhysicalModel widget.
///
/// This class implements the [DuitAttributes] interface, allowing it to be used with DUIT widgets.
final class AnimatedPhysicalModelAttributes extends ImplicitAnimatable
    implements
        _PhysicalModelProps,
        DuitAttributes<AnimatedPhysicalModelAttributes> {
  @override
  final double elevation;
  @override
  final Color color;
  @override
  final Color shadowColor;
  @override
  final Clip clipBehavior;
  @override
  final BorderRadius? borderRadius;
  @override
  final BoxShape shape;

  final bool animateColor, animateShadowColor;

  const AnimatedPhysicalModelAttributes({
    required this.elevation,
    required this.color,
    required this.shadowColor,
    required this.clipBehavior,
    this.borderRadius,
    required this.shape,
    required super.curve,
    required super.duration,
    required super.onEnd,
    required this.animateColor,
    required this.animateShadowColor,
  });

  factory AnimatedPhysicalModelAttributes.fromJson(Map<String, dynamic> json) {
    return AnimatedPhysicalModelAttributes(
      elevation: NumUtils.toDoubleWithNullReplacement(json['elevation'], 0.0),
      color: ColorUtils.tryParseColor(json['color']),
      shadowColor: ColorUtils.tryParseColor(json['shadowColor']),
      clipBehavior: AttributeValueMapper.toClip(
        json['clipBehavior'],
        Clip.none,
      ),
      borderRadius: AttributeValueMapper.toBorderRadius(json['borderRadius']),
      shape: AttributeValueMapper.toBoxShape(json['shape']),
      duration: AttributeValueMapper.toDuration(json["duration"]),
      curve: AttributeValueMapper.toCurve(json["curve"]),
      onEnd: JsonUtils.nullOrParse(
        "onEnd",
        json,
        ServerAction.parse,
      ),
      animateColor: json['animateColor'] ?? true,
      animateShadowColor: json['animateShadowColor'] ?? true,
    );
  }

  @override
  AnimatedPhysicalModelAttributes copyWith(other) {
    return AnimatedPhysicalModelAttributes(
      elevation: other.elevation,
      color: other.color,
      shadowColor: other.shadowColor,
      clipBehavior: other.clipBehavior,
      borderRadius: other.borderRadius ?? borderRadius,
      shape: other.shape,
      duration: duration, //copy prohibited
      curve: other.curve,
      onEnd: other.onEnd ?? onEnd,
      animateColor: other.animateColor,
      animateShadowColor: other.animateShadowColor,
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
