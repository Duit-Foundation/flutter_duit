import 'package:flutter/material.dart';
import 'package:flutter_duit/src/duit_kernel/index.dart';
import 'package:flutter_duit/src/utils/index.dart';

//TODO add transform [Matrix4] prop

/// Represents the attributes for a Container widget.
///
/// This class implements the [DuitAttributes] interface, allowing it to be used with DUIT widgets.
class ContainerAttributes implements DuitAttributes<ContainerAttributes> {
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
    );
  }

  factory ContainerAttributes.fromJson(Map<String, dynamic> json) {
    return ContainerAttributes(
      width: NumUtils.toDouble(json['width']),
      height: NumUtils.toDouble(json['height']),
      color: ColorUtils.tryParseNullableColor(json['color']),
      clipBehavior: ParamsMapper.convertToClip(json['clipBehavior']),
      decoration: ParamsMapper.convertToDecoration(json['decoration']),
      foregroundDecoration:
          ParamsMapper.convertToDecoration(json['foregroundDecoration']),
      constraints: ParamsMapper.convertToBoxConstraints(json['constraints']),
      padding: ParamsMapper.convertToEdgeInsets(json['padding']),
      margin: ParamsMapper.convertToEdgeInsets(json['margin']),
      alignment: ParamsMapper.convertToAlignmentDirectional(json['alignment']),
      transformAlignment: ParamsMapper.convertToAlignmentDirectional(
          json['transformAlignment']),
    );
  }
}
