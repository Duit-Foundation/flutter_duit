import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/animations/index.dart';
import 'package:flutter_duit/src/utils/index.dart';

//TODO add transform [Matrix4] prop

abstract interface class _ContainerProps {
  abstract final double? width, height;
  abstract final Color? color;
  abstract final Clip clipBehavior;
  abstract final Decoration? decoration, foregroundDecoration;
  abstract final BoxConstraints? constraints;
  abstract final EdgeInsetsGeometry? padding, margin;
  abstract final AlignmentGeometry? alignment, transformAlignment;
}

/// Represents the attributes for a Container widget.
///
/// This class implements the [DuitAttributes] interface, allowing it to be used with DUIT widgets.
final class ContainerAttributes extends AnimatedPropertyOwner
    implements _ContainerProps, DuitAttributes<ContainerAttributes> {
  @override
  final double? width, height;
  @override
  final Color? color;
  @override
  final Clip clipBehavior;
  @override
  final Decoration? decoration, foregroundDecoration;
  @override
  final BoxConstraints? constraints;
  @override
  final EdgeInsetsGeometry? padding, margin;
  @override
  final AlignmentGeometry? alignment, transformAlignment;

  const ContainerAttributes({
    required this.clipBehavior,
    this.width,
    this.height,
    this.color,
    this.decoration,
    this.constraints,
    this.padding,
    this.margin,
    this.alignment,
    this.transformAlignment,
    this.foregroundDecoration,
    required super.affectedProperties,
    required super.parentBuilderId,
  });

  @override
  ContainerAttributes copyWith(other) {
    return ContainerAttributes(
      width: other.width ?? width,
      height: other.height ?? height,
      color: other.color ?? color,
      clipBehavior: other.clipBehavior,
      decoration: other.decoration ?? decoration,
      constraints: other.constraints ?? constraints,
      padding: other.padding ?? padding,
      margin: other.margin ?? margin,
      alignment: other.alignment ?? alignment,
      transformAlignment: other.transformAlignment ?? transformAlignment,
      foregroundDecoration: other.foregroundDecoration ?? foregroundDecoration,
      affectedProperties: other.affectedProperties,
      parentBuilderId: other.parentBuilderId,
    );
  }

  factory ContainerAttributes.fromJson(Map<String, dynamic> json) {
    return ContainerAttributes(
      width: NumUtils.toDouble(json['width']),
      height: NumUtils.toDouble(json['height']),
      color: ColorUtils.tryParseNullableColor(json['color']),
      clipBehavior: AttributeValueMapper.toClip(
        json['clipBehavior'],
        Clip.none,
      ),
      decoration: AttributeValueMapper.toDecoration(json['decoration']),
      foregroundDecoration:
          AttributeValueMapper.toDecoration(json['foregroundDecoration']),
      constraints: AttributeValueMapper.toBoxConstraints(json['constraints']),
      padding: AttributeValueMapper.toEdgeInsets(json['padding']),
      margin: AttributeValueMapper.toEdgeInsets(json['margin']),
      alignment: AttributeValueMapper.toAlignmentDirectional(json['alignment']),
      transformAlignment: AttributeValueMapper.toAlignmentDirectional(
          json['transformAlignment']),
      affectedProperties: Set.from(json['affectedProperties'] ?? {}),
      parentBuilderId: json['parentBuilderId'],
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
        ContainerAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}

final class AnimatedContainerAttributes extends ImplicitAnimatable
    implements _ContainerProps, DuitAttributes<AnimatedContainerAttributes> {
  @override
  final double? width, height;
  @override
  final Color? color;
  @override
  final Clip clipBehavior;
  @override
  final Decoration? decoration, foregroundDecoration;
  @override
  final BoxConstraints? constraints;
  @override
  final EdgeInsetsGeometry? padding, margin;
  @override
  final AlignmentGeometry? alignment, transformAlignment;

  const AnimatedContainerAttributes({
    required this.clipBehavior,
    this.width,
    this.height,
    this.color,
    this.decoration,
    this.constraints,
    this.padding,
    this.margin,
    this.alignment,
    this.transformAlignment,
    this.foregroundDecoration,
    required super.curve,
    required super.duration,
    required super.onEnd,
  });

  factory AnimatedContainerAttributes.fromJson(Map<String, dynamic> json) {
    return AnimatedContainerAttributes(
      width: NumUtils.toDouble(json['width']),
      height: NumUtils.toDouble(json['height']),
      color: ColorUtils.tryParseNullableColor(json['color']),
      clipBehavior: AttributeValueMapper.toClip(
        json['clipBehavior'],
        Clip.none,
      ),
      decoration: AttributeValueMapper.toDecoration(json['decoration']),
      foregroundDecoration:
          AttributeValueMapper.toDecoration(json['foregroundDecoration']),
      constraints: AttributeValueMapper.toBoxConstraints(json['constraints']),
      padding: AttributeValueMapper.toEdgeInsets(json['padding']),
      margin: AttributeValueMapper.toEdgeInsets(json['margin']),
      alignment: AttributeValueMapper.toAlignmentDirectional(json['alignment']),
      transformAlignment: AttributeValueMapper.toAlignmentDirectional(
          json['transformAlignment']),
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
  AnimatedContainerAttributes copyWith(other) {
    return AnimatedContainerAttributes(
      width: other.width ?? width,
      height: other.height ?? height,
      color: other.color ?? color,
      clipBehavior: other.clipBehavior,
      decoration: other.decoration ?? decoration,
      constraints: other.constraints ?? constraints,
      padding: other.padding ?? padding,
      margin: other.margin ?? margin,
      alignment: other.alignment ?? alignment,
      transformAlignment: other.transformAlignment ?? transformAlignment,
      foregroundDecoration: other.foregroundDecoration ?? foregroundDecoration,
      duration: duration, //copy prohibited
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
