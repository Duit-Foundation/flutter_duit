import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/slivers/sliver_props.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class SliverFillViewportAttributes
    implements
        DuitAttributes<SliverFillViewportAttributes>,
        SliverChildDelegateProps {
  final double viewportFraction;
  final bool padEnds;
  @override
  final List<NonChildWidget>? childObjects;
  @override
  final bool isBuilderDelegate,
      addAutomaticKeepAlives,
      addRepaintBoundaries,
      addSemanticIndexes;
  @override
  final int? childCount;

  const SliverFillViewportAttributes({
    required this.viewportFraction,
    required this.padEnds,
    required this.isBuilderDelegate,
    required this.addAutomaticKeepAlives,
    required this.addRepaintBoundaries,
    required this.addSemanticIndexes,
    this.childObjects,
    this.childCount,
  });

  factory SliverFillViewportAttributes.fromJson(Map<String, dynamic> json) {
    return SliverFillViewportAttributes(
      viewportFraction:
          NumUtils.toDoubleWithNullReplacement(json['viewportFraction'], 1.0),
      padEnds: json['padEnds'] ?? true,
      isBuilderDelegate: json['isBuilderDelegate'] ?? false,
      addAutomaticKeepAlives: json['addAutomaticKeepAlives'] ?? true,
      addRepaintBoundaries: json['addRepaintBoundaries'] ?? true,
      addSemanticIndexes: json['addSemanticIndexes'] ?? true,
      childObjects: json['childObjects'],
      childCount: NumUtils.toInt(json["childCount"]),
    );
  }

  @override
  SliverFillViewportAttributes copyWith(SliverFillViewportAttributes other) {
    return SliverFillViewportAttributes(
      viewportFraction: other.viewportFraction,
      padEnds: other.padEnds,
      isBuilderDelegate: other.isBuilderDelegate,
      addAutomaticKeepAlives: other.addAutomaticKeepAlives,
      addRepaintBoundaries: other.addRepaintBoundaries,
      addSemanticIndexes: other.addSemanticIndexes,
      childObjects: other.childObjects ?? childObjects,
      childCount: other.childCount ?? childCount,
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
