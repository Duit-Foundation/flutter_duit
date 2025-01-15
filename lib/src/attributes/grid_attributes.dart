import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class GridViewAttributes implements DuitAttributes<GridViewAttributes> {
  final Axis? scrollDirection;
  final bool? reverse,
      shrinkWrap,
      addSemanticIndexes,
      addRepaintBoundaries,
      addAutomaticKeepAlives,
      primary;
  final ScrollPhysics? physics;
  final EdgeInsets? padding;

  final double? anchor, cacheExtent, itemExtent;
  final int? semanticChildCount;
  final DragStartBehavior? dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;
  final String? restorationId;
  final Clip? clipBehavior;

  /// 0 - GridView,
  ///
  /// 1 - GridView.count,
  ///
  /// 2 - GridView.builder
  final int type;
  // final JSONObject? separator;
  final List<JSONObject>? childObjects;
  // final ArrayMergeStrategy? mergeStrategy;
  final double? scrollEndReachedThreshold;

  const GridViewAttributes({
    required this.scrollDirection,
    required this.reverse,
    required this.shrinkWrap,
    required this.addSemanticIndexes,
    required this.addRepaintBoundaries,
    required this.addAutomaticKeepAlives,
    required this.primary,
    required this.physics,
    required this.padding,
    required this.anchor,
    required this.cacheExtent,
    required this.itemExtent,
    required this.semanticChildCount,
    required this.dragStartBehavior,
    required this.keyboardDismissBehavior,
    required this.restorationId,
    required this.clipBehavior,
    required this.type,
    //required this.separator,
    required this.childObjects,
    //required this.mergeStrategy,
    required this.scrollEndReachedThreshold,
  });

  @override
  GridViewAttributes copyWith(GridViewAttributes other) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) {
    throw UnimplementedError();
  }
}
