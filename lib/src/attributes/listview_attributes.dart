import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/utils/index.dart';

enum ArrayMergeStrategy {
  addToEnd,
  addToStart,
  replace,
}

final class ListViewAttributes implements DuitAttributes<ListViewAttributes> {
  //<editor-fold desc="Flutter widget props">
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

  //</editor-fold>

  //<editor-fold desc="Special Duit properties">
  /// 0 - ListView,
  ///
  /// 1 - ListView.builder,
  ///
  /// 2 - ListView.separated
  final int type;
  final JSONObject? separator;
  final List<JSONObject>? childObjects;
  final ArrayMergeStrategy? mergeStrategy;
  final double? scrollEndReachedThreshold;

  //</editor-fold>

  //<editor-fold desc="Ctor, copy, mapping">
  ListViewAttributes({
    required this.scrollDirection,
    required this.reverse,
    required this.shrinkWrap,
    required this.addSemanticIndexes,
    required this.addRepaintBoundaries,
    required this.addAutomaticKeepAlives,
    required this.primary,
    required this.physics,
    required this.anchor,
    required this.cacheExtent,
    required this.semanticChildCount,
    required this.dragStartBehavior,
    required this.keyboardDismissBehavior,
    required this.restorationId,
    required this.clipBehavior,
    required this.padding,
    required this.itemExtent,
  })  : separator = null,
        childObjects = null,
        mergeStrategy = ArrayMergeStrategy.addToEnd,
        scrollEndReachedThreshold = null,
        type = 0;

  ListViewAttributes.builder({
    required this.scrollDirection,
    required this.reverse,
    required this.shrinkWrap,
    required this.addSemanticIndexes,
    required this.addRepaintBoundaries,
    required this.addAutomaticKeepAlives,
    required this.primary,
    required this.physics,
    required this.anchor,
    required this.cacheExtent,
    required this.semanticChildCount,
    required this.dragStartBehavior,
    required this.keyboardDismissBehavior,
    required this.restorationId,
    required this.clipBehavior,
    required this.padding,
    required this.itemExtent,
    required this.childObjects,
    this.mergeStrategy = ArrayMergeStrategy.addToEnd,
    this.scrollEndReachedThreshold = 150,
  })  : separator = null,
        type = 1;

  ListViewAttributes.separated({
    required this.scrollDirection,
    required this.reverse,
    required this.shrinkWrap,
    required this.addSemanticIndexes,
    required this.addRepaintBoundaries,
    required this.addAutomaticKeepAlives,
    required this.primary,
    required this.physics,
    required this.anchor,
    required this.cacheExtent,
    required this.semanticChildCount,
    required this.dragStartBehavior,
    required this.keyboardDismissBehavior,
    required this.restorationId,
    required this.clipBehavior,
    required this.padding,
    required this.itemExtent,
    required this.separator,
    required this.childObjects,
    this.mergeStrategy = ArrayMergeStrategy.addToEnd,
    this.scrollEndReachedThreshold = 150,
  }) : type = 2;

  factory ListViewAttributes.fromJson(Map<String, dynamic> json) {
    final type = json["type"] as int;

    switch (type) {
      case 1:
        final children = List<JSONObject>.from(json["childObjects"] ?? []);

        return ListViewAttributes.builder(
          scrollDirection: ParamsMapper.convertToAxis(json['scrollDirection']),
          reverse: json["reverse"],
          shrinkWrap: json["shrinkWrap"],
          addSemanticIndexes: json["addSemanticIndexes"],
          addRepaintBoundaries: json["addRepaintBoundaries"],
          addAutomaticKeepAlives: json["addAutomaticKeepAlives"],
          primary: json["primary"],
          physics: ParamsMapper.convertToScrollPhysics(json['physics']),
          anchor: NumUtils.toDouble(json["anchor"]),
          cacheExtent: NumUtils.toDouble(json["cacheExtent"]),
          semanticChildCount: NumUtils.toInt(json["semanticChildCount"]),
          dragStartBehavior: ParamsMapper.convertToDragStartBehavior(
              json["dragStartBehavior"]),
          keyboardDismissBehavior:
              ParamsMapper.convertToKeyboardDismissBehavior(
                  json["keyboardDismissBehavior"]),
          restorationId: json["restorationId"],
          clipBehavior: ParamsMapper.convertToClip(json["clipBehavior"]),
          padding: ParamsMapper.convertToNullableEdgeInsets(json["padding"]),
          itemExtent: NumUtils.toDouble(json["itemExtent"]),
          childObjects: children,
          mergeStrategy: ArrayMergeStrategy.values[json["mergeStrategy"] ?? 0],
          scrollEndReachedThreshold: NumUtils.toDouble(
            json["scrollEndReachedThreshold"],
          ),
        );
      case 2:
        final separator = json["separator"];
        assert(separator != null,
            "separatorComponentTag must be a Map and non-null value");
        final children = List<JSONObject>.from(json["childObjects"] ?? []);

        return ListViewAttributes.separated(
          scrollDirection: ParamsMapper.convertToAxis(json['scrollDirection']),
          reverse: json["reverse"],
          shrinkWrap: json["shrinkWrap"],
          addSemanticIndexes: json["addSemanticIndexes"],
          addRepaintBoundaries: json["addRepaintBoundaries"],
          addAutomaticKeepAlives: json["addAutomaticKeepAlives"],
          primary: json["primary"],
          physics: ParamsMapper.convertToScrollPhysics(json['physics']),
          anchor: NumUtils.toDouble(json["anchor"]),
          cacheExtent: NumUtils.toDouble(json["cacheExtent"]),
          semanticChildCount: NumUtils.toInt(json["semanticChildCount"]),
          dragStartBehavior: ParamsMapper.convertToDragStartBehavior(
              json["dragStartBehavior"]),
          keyboardDismissBehavior:
              ParamsMapper.convertToKeyboardDismissBehavior(
                  json["keyboardDismissBehavior"]),
          restorationId: json["restorationId"],
          clipBehavior: ParamsMapper.convertToClip(json["clipBehavior"]),
          padding: ParamsMapper.convertToNullableEdgeInsets(json["padding"]),
          itemExtent: NumUtils.toDouble(json["itemExtent"]),
          separator: separator,
          childObjects: children,
          mergeStrategy: ArrayMergeStrategy.values[json["mergeStrategy"] ?? 0],
          scrollEndReachedThreshold: NumUtils.toDouble(
            json["scrollEndReachedThreshold"],
          ),
        );
      default:
        return ListViewAttributes(
          scrollDirection: ParamsMapper.convertToAxis(json['scrollDirection']),
          reverse: json["reverse"],
          shrinkWrap: json["shrinkWrap"],
          addSemanticIndexes: json["addSemanticIndexes"],
          addRepaintBoundaries: json["addRepaintBoundaries"],
          addAutomaticKeepAlives: json["addAutomaticKeepAlives"],
          primary: json["primary"],
          physics: ParamsMapper.convertToScrollPhysics(json['physics']),
          anchor: NumUtils.toDouble(json["anchor"]),
          cacheExtent: NumUtils.toDouble(json["cacheExtent"]),
          semanticChildCount: NumUtils.toInt(json["semanticChildCount"]),
          dragStartBehavior: ParamsMapper.convertToDragStartBehavior(
              json["dragStartBehavior"]),
          keyboardDismissBehavior:
              ParamsMapper.convertToKeyboardDismissBehavior(
                  json["keyboardDismissBehavior"]),
          restorationId: json["restorationId"],
          clipBehavior: ParamsMapper.convertToClip(json["clipBehavior"]),
          padding: ParamsMapper.convertToNullableEdgeInsets(json["padding"]),
          itemExtent: NumUtils.toDouble(json["itemExtent"]),
        );
    }
  }

  @override
  ListViewAttributes copyWith(ListViewAttributes other) {
    switch (type) {
      case 1:
        var children = childObjects ?? [];

        switch (mergeStrategy!) {
          case ArrayMergeStrategy.addToEnd:
            children.addAll(other.childObjects!);
            break;
          case ArrayMergeStrategy.addToStart:
            children.insertAll(0, other.childObjects!);
            break;
          case ArrayMergeStrategy.replace:
            children = other.childObjects!;
            break;
        }

        return ListViewAttributes.builder(
          scrollDirection: other.scrollDirection ?? scrollDirection,
          reverse: other.reverse ?? reverse,
          shrinkWrap: other.shrinkWrap ?? shrinkWrap,
          addSemanticIndexes: other.addSemanticIndexes ?? addSemanticIndexes,
          addRepaintBoundaries:
              other.addRepaintBoundaries ?? addRepaintBoundaries,
          addAutomaticKeepAlives:
              other.addAutomaticKeepAlives ?? addAutomaticKeepAlives,
          primary: other.primary ?? primary,
          physics: other.physics ?? physics,
          anchor: other.anchor ?? anchor,
          cacheExtent: other.cacheExtent ?? cacheExtent,
          semanticChildCount: other.semanticChildCount ?? semanticChildCount,
          dragStartBehavior: other.dragStartBehavior ?? dragStartBehavior,
          keyboardDismissBehavior:
              other.keyboardDismissBehavior ?? keyboardDismissBehavior,
          restorationId: other.restorationId ?? restorationId,
          clipBehavior: other.clipBehavior ?? clipBehavior,
          padding: other.padding ?? padding,
          itemExtent: other.itemExtent ?? itemExtent,
          childObjects: children,
          mergeStrategy: other.mergeStrategy ?? mergeStrategy,
        );
      case 2:
        var children = childObjects ?? [];

        switch (mergeStrategy!) {
          case ArrayMergeStrategy.addToEnd:
            children.addAll(other.childObjects!);
            break;
          case ArrayMergeStrategy.addToStart:
            children.insertAll(0, other.childObjects!);
            break;
          case ArrayMergeStrategy.replace:
            children = other.childObjects!;
            break;
        }

        return ListViewAttributes.separated(
          scrollDirection: other.scrollDirection ?? scrollDirection,
          reverse: other.reverse ?? reverse,
          shrinkWrap: other.shrinkWrap ?? shrinkWrap,
          addSemanticIndexes: other.addSemanticIndexes ?? addSemanticIndexes,
          addRepaintBoundaries:
              other.addRepaintBoundaries ?? addRepaintBoundaries,
          addAutomaticKeepAlives:
              other.addAutomaticKeepAlives ?? addAutomaticKeepAlives,
          primary: other.primary ?? primary,
          physics: other.physics ?? physics,
          anchor: other.anchor ?? anchor,
          cacheExtent: other.cacheExtent ?? cacheExtent,
          semanticChildCount: other.semanticChildCount ?? semanticChildCount,
          dragStartBehavior: other.dragStartBehavior ?? dragStartBehavior,
          keyboardDismissBehavior:
              other.keyboardDismissBehavior ?? keyboardDismissBehavior,
          restorationId: other.restorationId ?? restorationId,
          clipBehavior: other.clipBehavior ?? clipBehavior,
          separator: other.separator ?? separator,
          padding: other.padding ?? padding,
          itemExtent: other.itemExtent ?? itemExtent,
          childObjects: children,
          mergeStrategy: other.mergeStrategy ?? mergeStrategy,
        );
      default:
        return ListViewAttributes(
          scrollDirection: other.scrollDirection ?? scrollDirection,
          reverse: other.reverse ?? reverse,
          shrinkWrap: other.shrinkWrap ?? shrinkWrap,
          addSemanticIndexes: other.addSemanticIndexes ?? addSemanticIndexes,
          addRepaintBoundaries:
              other.addRepaintBoundaries ?? addRepaintBoundaries,
          addAutomaticKeepAlives:
              other.addAutomaticKeepAlives ?? addAutomaticKeepAlives,
          primary: other.primary ?? primary,
          physics: other.physics ?? physics,
          anchor: other.anchor ?? anchor,
          cacheExtent: other.cacheExtent ?? cacheExtent,
          semanticChildCount: other.semanticChildCount ?? semanticChildCount,
          dragStartBehavior: other.dragStartBehavior ?? dragStartBehavior,
          keyboardDismissBehavior:
              other.keyboardDismissBehavior ?? keyboardDismissBehavior,
          restorationId: other.restorationId ?? restorationId,
          clipBehavior: other.clipBehavior ?? clipBehavior,
          padding: other.padding ?? padding,
          itemExtent: other.itemExtent ?? itemExtent,
        );
    }
  }
//</editor-fold>
}
