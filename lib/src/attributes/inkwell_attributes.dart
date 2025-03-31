import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/utils/num_utils.dart';

final class InkWellAttributes implements DuitAttributes<InkWellAttributes> {
  final ServerAction? onTap,
      onDoubleTap,
      onLongPress,
      onTapDown,
      onTapUp,
      onTapCancel,
      onSecondaryTapDown,
      onSecondaryTapCancel,
      onSecondaryTap,
      onSecondaryTapUp;
  final Color? focusColor, hoverColor, highlightColor, splashColor;
  final WidgetStateProperty<Color>? overlayColor;
  final double? radius;
  final BorderRadius? borderRadius;
  final ShapeBorder? customBorder;
  final bool enableFeedback, excludeFromSemantics, autofocus, canRequestFocus;
  final Duration? hoverDuration;
  // final WidgetStatesController? statesController;

  const InkWellAttributes({
    required this.enableFeedback,
    required this.excludeFromSemantics,
    required this.autofocus,
    required this.canRequestFocus,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapCancel,
    this.onSecondaryTap,
    this.onSecondaryTapUp,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.overlayColor,
    this.radius,
    this.borderRadius,
    this.customBorder,
    this.hoverDuration,
    // this.statesController,
  });

  factory InkWellAttributes.fromJson(Map<String, dynamic> json) {
    final actions = ActionUtils(json);
    return InkWellAttributes(
      enableFeedback: json["enableFeedback"] ?? true,
      excludeFromSemantics: json["excludeFromSemantics"] ?? false,
      autofocus: json["autofocus"] ?? false,
      canRequestFocus: json["canRequestFocus"] ?? true,
      onTap: actions.parseAction("onTap"),
      onDoubleTap: actions.parseAction("onDoubleTap"),
      onLongPress: actions.parseAction("onLongPress"),
      onTapDown: actions.parseAction("onTapDown"),
      onTapUp: actions.parseAction("onTapUp"),
      onTapCancel: actions.parseAction("onTapCancel"),
      onSecondaryTap: actions.parseAction("onSecondaryTap"),
      onSecondaryTapUp: actions.parseAction("onSecondaryTapUp"),
      onSecondaryTapDown: actions.parseAction("onSecondaryTapDown"),
      onSecondaryTapCancel: actions.parseAction("onSecondaryTapCancel"),
      focusColor: ColorUtils.tryParseNullableColor(json["focusColor"]),
      hoverColor: ColorUtils.tryParseNullableColor(json["hoverColor"]),
      highlightColor: ColorUtils.tryParseNullableColor(json["highlightColor"]),
      splashColor: ColorUtils.tryParseNullableColor(json["splashColor"]),
      overlayColor: AttributeValueMapper.toMSPColor(json["overlayColor"]),
      radius: NumUtils.toDouble(json["radius"]),
      borderRadius: AttributeValueMapper.toBorderRadius(json["borderRadius"]),
      customBorder: AttributeValueMapper.toShapeBorder(json["customBorder"]),
      hoverDuration: AttributeValueMapper.toDuration(json["hoverDuration"]),
      // statesController: null,
    );
  }

  @override
  InkWellAttributes copyWith(InkWellAttributes other) {
    return InkWellAttributes(
      enableFeedback: other.enableFeedback,
      excludeFromSemantics: other.excludeFromSemantics,
      autofocus: other.autofocus,
      canRequestFocus: other.canRequestFocus,
      onTap: other.onTap ?? onTap,
      onDoubleTap: other.onDoubleTap ?? onDoubleTap,
      onLongPress: other.onLongPress ?? onLongPress,
      onTapDown: other.onTapDown ?? onTapDown,
      onTapUp: other.onTapUp ?? onTapUp,
      onTapCancel: other.onTapCancel ?? onTapCancel,
      onSecondaryTapDown: other.onSecondaryTapDown ?? onSecondaryTapDown,
      onSecondaryTapCancel: other.onSecondaryTapCancel ?? onSecondaryTapCancel,
      focusColor: other.focusColor ?? focusColor,
      hoverColor: other.hoverColor ?? hoverColor,
      highlightColor: other.highlightColor ?? highlightColor,
      splashColor: other.splashColor ?? splashColor,
      overlayColor: other.overlayColor ?? overlayColor,
      radius: other.radius ?? radius,
      borderRadius: other.borderRadius ?? borderRadius,
      customBorder: other.customBorder ?? customBorder,
      hoverDuration: other.hoverDuration ?? hoverDuration,
      // statesController: other.statesController ?? statesController,
    );
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) =>
      throw UnimplementedError("$methodName is not implemented");
}
