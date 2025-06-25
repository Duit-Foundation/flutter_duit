import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class FlexibleSpaceBarAttributes extends AnimatedPropertyOwner
    implements DuitAttributes<FlexibleSpaceBarAttributes> {
  final NonChildWidget? title, background;
  final EdgeInsetsGeometry? titlePadding;
  final CollapseMode collapseMode;
  final List<StretchMode> stretchModes;
  final bool? centerTitle;
  final double expandedTitleScale;

  const FlexibleSpaceBarAttributes({
    required this.collapseMode,
    required this.stretchModes,
    required this.expandedTitleScale,
    this.titlePadding,
    this.centerTitle,
    this.title,
    this.background,
    required super.parentBuilderId,
    required super.affectedProperties,
  });

  factory FlexibleSpaceBarAttributes.fromJson(Map<String, dynamic> json) {
    final view = AnimatedPropHelper(json);
    return FlexibleSpaceBarAttributes(
      title: view["title"],
      background: view["background"],
      titlePadding: AttributeValueMapper.toEdgeInsets(view["titlePadding"]),
      collapseMode: AttributeValueMapper.toCollapseMode(view["collapseMode"]),
      stretchModes: AttributeValueMapper.toStretchModes(view["stretchModes"]),
      centerTitle: view["centerTitle"] as bool?,
      expandedTitleScale:
          NumUtils.toDoubleWithNullReplacement(view["expandedTitleScale"], 1.5),
      parentBuilderId: view.parentBuilderId,
      affectedProperties: view.affectedProperties,
    );
  }

  @override
  FlexibleSpaceBarAttributes copyWith(FlexibleSpaceBarAttributes other) {
    return FlexibleSpaceBarAttributes(
      title: other.title ?? title,
      background: other.background ?? background,
      titlePadding: other.titlePadding ?? titlePadding,
      collapseMode: other.collapseMode,
      stretchModes: other.stretchModes,
      centerTitle: other.centerTitle ?? centerTitle,
      expandedTitleScale: other.expandedTitleScale,
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
        FlexibleSpaceBarAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
