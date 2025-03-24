import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// Represents the attributes for an AppBar widget.
///
/// This class implements the [DuitAttributes] interface, allowing it to be used with DUIT widgets.
final class AppBarAttributes extends AnimatedPropertyOwner
    implements DuitAttributes<AppBarAttributes> {
  // NOTE: children properties with [Widget] type
  final Map<String, dynamic>? leading, title, bottom, flexibleSpace;
  final List<Map<String, dynamic>>? actions;

  //NOTE: other attributes properties
  final EdgeInsetsGeometry? actionsPadding;
  final Color? backgroundColor, foregroundColor, surfaceTintColor, shadowColor;
  final double bottomOpacity, toolbarOpacity;
  final double? elevation,
      scrolledUnderElevation,
      toolbarHeight,
      leadingWidth,
      titleSpacing;
  final bool automaticallyImplyLeading,
      excludeHeaderSemantics,
      forceMaterialTransparency,
      primary;
  final TextStyle? toolbarTextStyle, titleTextStyle;
  final bool? centerTitle;
  final ShapeBorder? shape;
  final Clip? clipBehavior;
  
  const AppBarAttributes({
    required this.automaticallyImplyLeading,
    required this.excludeHeaderSemantics,
    required this.forceMaterialTransparency,
    required this.primary,
    required this.bottomOpacity,
    required this.toolbarOpacity,
    this.leading,
    this.title,
    this.actions,
    this.bottom,
    this.actionsPadding,
    this.backgroundColor,
    this.foregroundColor,
    this.surfaceTintColor,
    this.shadowColor,
    this.elevation,
    this.scrolledUnderElevation,
    this.toolbarHeight,
    this.leadingWidth,
    this.titleSpacing,
    this.toolbarTextStyle,
    this.titleTextStyle,
    this.centerTitle,
    this.shape,
    this.clipBehavior,
    this.flexibleSpace,
    required super.parentBuilderId,
    required super.affectedProperties,
  });

  factory AppBarAttributes.fromJson(JSONObject json) {
    final view = AnimatedPropHelper(json);
    return AppBarAttributes(
      automaticallyImplyLeading: view["automaticallyImplyLeading"] ?? true,
      excludeHeaderSemantics: view["excludeHeaderSemantics"] ?? false,
      forceMaterialTransparency: view["forceMaterialTransparency"] ?? false,
      flexibleSpace: view["flexibleSpace"],
      leading: view["leading"],
      title: view["title"],
      actions: (view["actions"] as List?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      bottom: view["bottom"],
      actionsPadding: AttributeValueMapper.toEdgeInsets(
        view["actionsPadding"],
      ),
      backgroundColor:
          ColorUtils.tryParseNullableColor(view["backgroundColor"]),
      foregroundColor:
          ColorUtils.tryParseNullableColor(view["foregroundColor"]),
      surfaceTintColor:
          ColorUtils.tryParseNullableColor(view["surfaceTintColor"]),
      shadowColor: ColorUtils.tryParseNullableColor(view["shadowColor"]),
      elevation: NumUtils.toDouble(view["elevation"]),
      scrolledUnderElevation: view["scrolledUnderElevation"],
      toolbarHeight: NumUtils.toDouble(view["toolbarHeight"]),
      leadingWidth: NumUtils.toDouble(view["leadingWidth"]),
      titleSpacing: NumUtils.toDouble(view["titleSpacing"]),
      bottomOpacity:
          NumUtils.toDoubleWithNullReplacement(view["bottomOpacity"], 1.0),
      toolbarOpacity:
          NumUtils.toDoubleWithNullReplacement(view["toolbarOpacity"], 1.0),
      toolbarTextStyle:
          AttributeValueMapper.toTextStyle(view["toolbarTextStyle"]),
      titleTextStyle: AttributeValueMapper.toTextStyle(view["titleTextStyle"]),
      centerTitle: view["centerTitle"],
      primary: view["primary"] ?? true,
      shape: AttributeValueMapper.toShapeBorder(view["shape"]),
      clipBehavior: AttributeValueMapper.toClip(view["clipBehavior"]),
      parentBuilderId: view.parentBuilderId,
      affectedProperties: view.affectedProperties,
    );
  }

  @override
  AppBarAttributes copyWith(AppBarAttributes other) {
    return AppBarAttributes(
      automaticallyImplyLeading: other.automaticallyImplyLeading,
      excludeHeaderSemantics: other.excludeHeaderSemantics,
      forceMaterialTransparency: other.forceMaterialTransparency,
      actionsPadding: other.actionsPadding ?? actionsPadding,
      backgroundColor: other.backgroundColor ?? backgroundColor,
      foregroundColor: other.foregroundColor ?? foregroundColor,
      surfaceTintColor: other.surfaceTintColor ?? surfaceTintColor,
      shadowColor: other.shadowColor ?? shadowColor,
      elevation: other.elevation ?? elevation,
      scrolledUnderElevation:
          other.scrolledUnderElevation ?? scrolledUnderElevation,
      toolbarHeight: other.toolbarHeight ?? toolbarHeight,
      leadingWidth: other.leadingWidth ?? leadingWidth,
      titleSpacing: other.titleSpacing ?? titleSpacing,
      bottomOpacity: other.bottomOpacity,
      toolbarOpacity: other.toolbarOpacity,
      toolbarTextStyle: other.toolbarTextStyle ?? toolbarTextStyle,
      titleTextStyle: other.titleTextStyle ?? titleTextStyle,
      centerTitle: other.centerTitle ?? centerTitle,
      primary: other.primary,
      shape: other.shape ?? shape,
      clipBehavior: other.clipBehavior ?? clipBehavior,
      leading: other.leading ?? leading,
      title: other.title ?? title,
      actions: other.actions ?? actions,
      bottom: other.bottom ?? bottom,
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
      "fromJson" =>
        AppBarAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
