import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/slivers/sliver_props.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class SliverAppBarAttributes extends AnimatedPropertyOwner
    implements DuitAttributes<SliverAppBarAttributes>, DuitSliverProps {
  final NonChildWidget? leading, title, bottom, flexibleSpace;
  final List<NonChildWidget>? actions;
  final EdgeInsetsGeometry? actionsPadding;
  final Color? backgroundColor, foregroundColor, surfaceTintColor, shadowColor;
  final double bottomOpacity, toolbarOpacity;
  final double? elevation,
      scrolledUnderElevation,
      toolbarHeight,
      leadingWidth,
      titleSpacing,
      collapsedHeight,
      expandedHeight,
      stretchTriggerOffset;
  final bool automaticallyImplyLeading,
      excludeHeaderSemantics,
      forceMaterialTransparency,
      primary,
      forceElevated,
      useDefaultSemanticsOrder,
      stretch,
      floating,
      pinned,
      snap;
  final TextStyle? toolbarTextStyle, titleTextStyle;
  final bool? centerTitle;
  final ShapeBorder? shape;
  final Clip? clipBehavior;

  @override
  final bool needsBoxAdapter;

  const SliverAppBarAttributes({
    required this.automaticallyImplyLeading,
    required this.excludeHeaderSemantics,
    required this.forceMaterialTransparency,
    required this.primary,
    required this.bottomOpacity,
    required this.toolbarOpacity,
    required this.floating,
    required this.pinned,
    required this.snap,
    required this.stretch,
    required this.needsBoxAdapter,
    required this.collapsedHeight,
    required this.stretchTriggerOffset,
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
    this.expandedHeight,
    required this.forceElevated,
    required this.useDefaultSemanticsOrder,
    required super.parentBuilderId,
    required super.affectedProperties,
  });

  factory SliverAppBarAttributes.fromJson(Map<String, dynamic> json) {
    final view = AnimatedPropHelper(json);
    return SliverAppBarAttributes(
      automaticallyImplyLeading: view["automaticallyImplyLeading"] ?? true,
      excludeHeaderSemantics: view["excludeHeaderSemantics"] ?? false,
      forceMaterialTransparency: view["forceMaterialTransparency"] ?? false,
      primary: view["primary"] ?? true,
      forceElevated: view["forceElevated"] ?? false,
      useDefaultSemanticsOrder: view["useDefaultSemanticsOrder"] ?? false,
      bottomOpacity:
          NumUtils.toDoubleWithNullReplacement(view["bottomOpacity"], 1.0),
      toolbarOpacity:
          NumUtils.toDoubleWithNullReplacement(view["toolbarOpacity"], 1.0),
      floating: view["floating"] ?? false,
      pinned: view["pinned"] ?? false,
      snap: view["snap"] ?? false,
      stretch: view["stretch"] ?? false,
      needsBoxAdapter: json['needsBoxAdapter'] ?? false,
      flexibleSpace: view["flexibleSpace"],
      leading: view["leading"],
      title: view["title"],
      actions: (view["actions"] as List?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      bottom: view["bottom"],
      actionsPadding: AttributeValueMapper.toEdgeInsets(view["actionsPadding"]),
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
      toolbarTextStyle:
          AttributeValueMapper.toTextStyle(view["toolbarTextStyle"]),
      titleTextStyle: AttributeValueMapper.toTextStyle(view["titleTextStyle"]),
      centerTitle: view["centerTitle"],
      shape: AttributeValueMapper.toShapeBorder(view["shape"]),
      clipBehavior: AttributeValueMapper.toClip(view["clipBehavior"]),
      expandedHeight: NumUtils.toDouble(view["expandedHeight"]),
      collapsedHeight: NumUtils.toDouble(view["collapsedHeight"]),
      stretchTriggerOffset: NumUtils.toDouble(view["stretchTriggerOffset"]),
      parentBuilderId: view.parentBuilderId,
      affectedProperties: view.affectedProperties,
    );
  }

  @override
  SliverAppBarAttributes copyWith(SliverAppBarAttributes other) {
    return SliverAppBarAttributes(
      automaticallyImplyLeading: other.automaticallyImplyLeading,
      excludeHeaderSemantics: other.excludeHeaderSemantics,
      forceMaterialTransparency: other.forceMaterialTransparency,
      primary: other.primary,
      bottomOpacity: other.bottomOpacity,
      toolbarOpacity: other.toolbarOpacity,
      floating: other.floating,
      pinned: other.pinned,
      snap: other.snap,
      stretch: other.stretch,
      needsBoxAdapter: needsBoxAdapter,
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
      toolbarTextStyle: other.toolbarTextStyle ?? toolbarTextStyle,
      titleTextStyle: other.titleTextStyle ?? titleTextStyle,
      centerTitle: other.centerTitle ?? centerTitle,
      shape: other.shape ?? shape,
      clipBehavior: other.clipBehavior ?? clipBehavior,
      leading: other.leading ?? leading,
      title: other.title ?? title,
      actions: other.actions ?? actions,
      bottom: other.bottom ?? bottom,
      flexibleSpace: other.flexibleSpace ?? flexibleSpace,
      expandedHeight: other.expandedHeight ?? expandedHeight,
      collapsedHeight: other.collapsedHeight ?? collapsedHeight,
      stretchTriggerOffset: other.stretchTriggerOffset ?? stretchTriggerOffset,
      forceElevated: other.forceElevated,
      useDefaultSemanticsOrder: other.useDefaultSemanticsOrder,
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
        SliverAppBarAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
