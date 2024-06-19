import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/utils/index.dart';

//TODO add transform [Matrix4] prop

/// Represents the attributes for a Container widget.
///
/// This class implements the [DuitAttributes] interface, allowing it to be used with DUIT widgets.
final class ContainerAttributes extends AnimatedPropertyOwner
    implements DuitAttributes<ContainerAttributes> {
  final double? width, height;
  final Color? color;
  final Clip? clipBehavior;
  final Decoration? decoration, foregroundDecoration;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? padding, margin;
  final AlignmentGeometry? alignment, transformAlignment;

  ContainerAttributes({
    this.width,
    this.height,
    this.color,
    this.clipBehavior,
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
      clipBehavior: other.clipBehavior ?? clipBehavior,
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
      clipBehavior: AttributeValueMapper.toClip(json['clipBehavior']),
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
