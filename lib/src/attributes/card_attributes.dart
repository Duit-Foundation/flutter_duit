import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// Represents the attributes for a Card widget.
///
/// This class implements the [DuitAttributes] interface, allowing it to be used with DUIT widgets.
///
/// See also:
/// - [Card](https://api.flutter.dev/flutter/material/Card-class.html) - The Flutter widget this attributes class represents.
final class CardAttributes extends AnimatedPropertyOwner
    implements DuitAttributes<CardAttributes> {
  final Color? color, shadowColor;
  final double? elevation;
  final ShapeBorder? shape;
  final EdgeInsetsGeometry? margin;
  final Clip? clipBehavior;
  final bool semanticContainer, borderOnForeground;

  const CardAttributes({
    this.color,
    this.shadowColor,
    this.elevation,
    this.shape,
    this.margin,
    this.clipBehavior,
    this.semanticContainer = true,
    this.borderOnForeground = true,
    required super.parentBuilderId,
    required super.affectedProperties,
  });

  factory CardAttributes.fromJson(JSONObject json) {
    final view = AnimatedPropHelper(json);
    return CardAttributes(
      color: ColorUtils.tryParseNullableColor(json['color']),
      shadowColor: ColorUtils.tryParseNullableColor(json['shadowColor']),
      elevation: NumUtils.toDouble(json['elevation']),
      shape: AttributeValueMapper.toShapeBorder(json['shape']),
      borderOnForeground: json['borderOnForeground'] ?? true,
      margin: AttributeValueMapper.toEdgeInsets(json['margin']),
      clipBehavior: AttributeValueMapper.toClip(json['clipBehavior']),
      semanticContainer: json['semanticContainer'] ?? true,
      parentBuilderId: view.parentBuilderId,
      affectedProperties: view.affectedProperties,
    );
  }

  @override
  CardAttributes copyWith(CardAttributes other) {
    return CardAttributes(
      color: other.color ?? color,
      shadowColor: other.shadowColor ?? shadowColor,
      elevation: other.elevation ?? elevation,
      shape: other.shape ?? shape,
      borderOnForeground: assignIfNotNull(
        other.borderOnForeground,
        borderOnForeground,
      ),
      margin: other.margin ?? margin,
      clipBehavior: other.clipBehavior ?? clipBehavior,
      semanticContainer: assignIfNotNull(
        other.semanticContainer,
        semanticContainer,
      ),
      parentBuilderId: other.parentBuilderId ?? parentBuilderId,
      affectedProperties: other.affectedProperties ?? affectedProperties,
    );
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) {
    return switch (methodName) {
      "fromJson" => CardAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
