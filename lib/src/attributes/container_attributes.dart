import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/utils/index.dart';

//TODO add transform [Matrix4] prop

class ContainerAttributes implements DUITAttributes<ContainerAttributes> {
  double? width, height;
  Color? color;
  Clip? clipBehavior;
  Decoration? decoration, foregroundDecoration;
  BoxConstraints? constraints;
  EdgeInsetsGeometry? padding, margin;
  AlignmentGeometry? alignment, transformAlignment;

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
      color: ColorUtils.tryParseColor(json['color']),
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
