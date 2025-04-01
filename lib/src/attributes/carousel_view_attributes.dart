import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/utils/index.dart';

enum CarouselViewConstructor {
  common,
  weighted;

  static CarouselViewConstructor fromValue(dynamic value) {
    return switch (value) {
      "common" || 0 => CarouselViewConstructor.common,
      "weighted" || 1 => CarouselViewConstructor.weighted,
      _ => throw ArgumentError("Invalid CarouselViewConstructor value: $value"),
    };
  }
}

final class CarouselViewAttributes extends AnimatedPropertyOwner
    implements DuitAttributes<CarouselViewAttributes> {
  final CarouselViewConstructor constructor;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final double? elevation;
  final ShapeBorder? shape;
  final WidgetStateProperty<Color?>? overlayColor;
  final double shrinkExtent, itemExtent;
  final Axis scrollDirection;
  final bool enableSplash, reverse, itemSnapping, consumeMaxWeight;
  final List<int> flexWeights;
  //  final ValueChanged<int>? onTap; //ServerAction needed?

  const CarouselViewAttributes.common({
    this.padding,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.overlayColor,
    required this.itemSnapping,
    required this.shrinkExtent,
    required this.scrollDirection,
    required this.enableSplash,
    required this.reverse,
    required super.affectedProperties,
    required super.parentBuilderId,
    required this.itemExtent,
  })  : flexWeights = const [],
        consumeMaxWeight = false,
        constructor = CarouselViewConstructor.common;

  const CarouselViewAttributes.weighted({
    this.padding,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.overlayColor,
    required this.itemSnapping,
    required this.shrinkExtent,
    required this.scrollDirection,
    required this.enableSplash,
    required this.reverse,
    required this.flexWeights,
    required this.consumeMaxWeight,
    required super.affectedProperties,
    required super.parentBuilderId,
  })  : constructor = CarouselViewConstructor.weighted,
        itemExtent = 0.0;

  factory CarouselViewAttributes.fromJson(Map<String, dynamic> json) {
    final constructor = CarouselViewConstructor.fromValue(json["constructor"]);
    final view = AnimatedPropHelper(json);

    return switch (constructor) {
      CarouselViewConstructor.common => CarouselViewAttributes.common(
          padding: AttributeValueMapper.toEdgeInsets(view["padding"]),
          backgroundColor:
              ColorUtils.tryParseNullableColor(view["backgroundColor"]),
          elevation: NumUtils.toDouble(view["elevation"]),
          shape: AttributeValueMapper.toShapeBorder(view["shape"]),
          overlayColor: AttributeValueMapper.toMSPColor(view["overlayColor"]),
          itemSnapping: view["itemSnapping"] ?? false,
          shrinkExtent: NumUtils.toDoubleWithNullReplacement(
            view["shrinkExtent"],
            0.0,
          ),
          itemExtent: NumUtils.toDoubleWithNullReplacement(
            view["itemExtent"],
            32.0,
          ),
          scrollDirection: AttributeValueMapper.toAxis(
            view["scrollDirection"],
            Axis.horizontal,
          ),
          enableSplash: view["enableSplash"] ?? true,
          reverse: view["reverse"] ?? false,
          affectedProperties: view.affectedProperties,
          parentBuilderId: view.parentBuilderId,
        ),
      CarouselViewConstructor.weighted => CarouselViewAttributes.weighted(
          padding: AttributeValueMapper.toEdgeInsets(view["padding"]),
          backgroundColor:
              ColorUtils.tryParseNullableColor(view["backgroundColor"]),
          elevation: NumUtils.toDouble(view["elevation"]),
          shape: AttributeValueMapper.toShapeBorder(view["shape"]),
          overlayColor: AttributeValueMapper.toMSPColor(json["overlayColor"]),
          itemSnapping: json["itemSnapping"] ?? false,
          shrinkExtent: NumUtils.toDoubleWithNullReplacement(
            json["shrinkExtent"],
            0.0,
          ),
          scrollDirection: AttributeValueMapper.toAxis(
            json["scrollDirection"],
            Axis.horizontal,
          ),
          enableSplash: json["enableSplash"] ?? true,
          reverse: json["reverse"] ?? false,
          flexWeights: (json["flexWeights"] as List<int>?) ?? const [],
          consumeMaxWeight: json["consumeMaxWeight"] ?? true,
          affectedProperties: view.affectedProperties,
          parentBuilderId: view.parentBuilderId,
        )
    };
  }

  @override
  CarouselViewAttributes copyWith(CarouselViewAttributes other) {
    return switch (constructor) {
      CarouselViewConstructor.common => CarouselViewAttributes.common(
          padding: other.padding ?? padding,
          backgroundColor: other.backgroundColor ?? backgroundColor,
          elevation: other.elevation ?? elevation,
          shape: other.shape ?? shape,
          overlayColor: other.overlayColor ?? overlayColor,
          itemSnapping: other.itemSnapping,
          shrinkExtent: other.shrinkExtent,
          itemExtent: other.itemExtent,
          scrollDirection: other.scrollDirection,
          enableSplash: other.enableSplash,
          reverse: other.reverse,
          affectedProperties: other.affectedProperties,
          parentBuilderId: other.parentBuilderId,
        ),
      CarouselViewConstructor.weighted => CarouselViewAttributes.weighted(
          padding: other.padding ?? padding,
          backgroundColor: other.backgroundColor ?? backgroundColor,
          elevation: other.elevation ?? elevation,
          shape: other.shape ?? shape,
          overlayColor: other.overlayColor ?? overlayColor,
          itemSnapping: other.itemSnapping,
          shrinkExtent: other.shrinkExtent,
          scrollDirection: other.scrollDirection,
          enableSplash: other.enableSplash,
          reverse: other.reverse,
          flexWeights: other.flexWeights,
          consumeMaxWeight: other.consumeMaxWeight,
          affectedProperties: other.affectedProperties,
          parentBuilderId: other.parentBuilderId,
        )
    };
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) {
    return switch (methodName) {
      "fromJson" =>
        CarouselViewAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
