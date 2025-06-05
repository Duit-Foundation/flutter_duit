import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class PageViewAttributes
    implements DuitAttributes<PageViewAttributes>, DynamicChildHolder {
  final Axis? scrollDirection;
  final bool? reverse, pageSnapping, allowImplicitScrolling, padEnds;
  final ScrollPhysics? physics;

  final DragStartBehavior? dragStartBehavior;

  final String? restorationId;
  final Clip? clipBehavior;

  final HitTestBehavior? hitTestBehavior;
  final ScrollBehavior? scrollBehavior;

  //</editor-fold>

  //<editor-fold desc="Special Duit properties">
  /// 0 - PageView,
  ///
  /// 1 - PageView.builder,
  final int type;

  @override
  final List<Map<String, dynamic>>? childObjects;

  @override
  final ArrayMergeStrategy? mergeStrategy;

  @override
  final double? scrollEndReachedThreshold;

  PageViewAttributes({
    required this.scrollDirection,
    required this.reverse,
    required this.pageSnapping,
    required this.allowImplicitScrolling,
    required this.padEnds,
    required this.physics,
    required this.dragStartBehavior,
    required this.restorationId,
    required this.clipBehavior,
    required this.hitTestBehavior,
    required this.scrollBehavior,
  })  : childObjects = null,
        type = 0,
        mergeStrategy = ArrayMergeStrategy.addToEnd,
        scrollEndReachedThreshold = null;

  PageViewAttributes.builder({
    required this.scrollDirection,
    required this.reverse,
    required this.pageSnapping,
    required this.allowImplicitScrolling,
    required this.padEnds,
    required this.physics,
    required this.dragStartBehavior,
    required this.restorationId,
    required this.clipBehavior,
    required this.hitTestBehavior,
    required this.scrollBehavior,
    required this.childObjects,
    this.mergeStrategy = ArrayMergeStrategy.addToEnd,
    this.scrollEndReachedThreshold = 150,
  }) : type = 1;

  factory PageViewAttributes.fromJson(Map<String, dynamic> json) {
    final type = json["type"] as int;

    switch (type) {
      case 1:
        return PageViewAttributes.builder(
          scrollDirection: AttributeValueMapper.toAxis(json["scrollDirection"]),
          reverse: json["reverse"],
          pageSnapping: json["pageSnapping"],
          allowImplicitScrolling: json["allowImplicitScrolling"],
          padEnds: json["padEnds"],
          physics: AttributeValueMapper.toScrollPhysics(json["physics"]),
          dragStartBehavior: AttributeValueMapper.toDragStartBehavior(
              json["dragStartBehavior"]),
          restorationId: json["restorationId"],
          clipBehavior: AttributeValueMapper.toClip(json["clipBehavior"]),
          hitTestBehavior:
              AttributeValueMapper.toHitTestBehavior(json["hitTestBehavior"]),
          scrollBehavior:
              AttributeValueMapper.toScrollBehavior(json["scrollBehavior"]),
          childObjects: json["childObjects"],
          mergeStrategy: ArrayMergeStrategy.fromValue(json["mergeStrategy"]),
          scrollEndReachedThreshold: json["scrollEndReachedThreshold"],
        );
      default:
        return PageViewAttributes(
          scrollDirection: AttributeValueMapper.toAxis(json["scrollDirection"]),
          reverse: json["reverse"],
          pageSnapping: json["pageSnapping"],
          allowImplicitScrolling: json["allowImplicitScrolling"],
          padEnds: json["padEnds"],
          physics: AttributeValueMapper.toScrollPhysics(json["physics"]),
          dragStartBehavior: AttributeValueMapper.toDragStartBehavior(
              json["dragStartBehavior"]),
          restorationId: json["restorationId"],
          clipBehavior: AttributeValueMapper.toClip(json["clipBehavior"]),
          hitTestBehavior:
              AttributeValueMapper.toHitTestBehavior(json["hitTestBehavior"]),
          scrollBehavior:
              AttributeValueMapper.toScrollBehavior(json["scrollBehavior"]),
        );
    }
  }

  @override
  PageViewAttributes copyWith(PageViewAttributes other) {
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
        return PageViewAttributes.builder(
          scrollDirection: other.scrollDirection ?? scrollDirection,
          reverse: other.reverse ?? reverse,
          pageSnapping: other.pageSnapping ?? pageSnapping,
          allowImplicitScrolling:
              other.allowImplicitScrolling ?? allowImplicitScrolling,
          padEnds: other.padEnds ?? padEnds,
          physics: other.physics ?? physics,
          dragStartBehavior: other.dragStartBehavior ?? dragStartBehavior,
          restorationId: other.restorationId ?? restorationId,
          clipBehavior: other.clipBehavior ?? clipBehavior,
          hitTestBehavior: other.hitTestBehavior ?? hitTestBehavior,
          scrollBehavior: other.scrollBehavior ?? scrollBehavior,
          childObjects: children,
          mergeStrategy: other.mergeStrategy ?? mergeStrategy,
          scrollEndReachedThreshold:
              other.scrollEndReachedThreshold ?? scrollEndReachedThreshold,
        );
      default:
        return PageViewAttributes(
          scrollDirection: other.scrollDirection ?? scrollDirection,
          reverse: other.reverse ?? reverse,
          pageSnapping: other.pageSnapping ?? pageSnapping,
          allowImplicitScrolling:
              other.allowImplicitScrolling ?? allowImplicitScrolling,
          padEnds: other.padEnds ?? padEnds,
          physics: other.physics ?? physics,
          dragStartBehavior: other.dragStartBehavior ?? dragStartBehavior,
          restorationId: other.restorationId ?? restorationId,
          clipBehavior: other.clipBehavior ?? clipBehavior,
          hitTestBehavior: other.hitTestBehavior ?? hitTestBehavior,
          scrollBehavior: other.scrollBehavior ?? scrollBehavior,
        );
    }
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(String methodName,
      {Iterable? positionalParams, Map<String, dynamic>? namedParams}) {
    return switch (methodName) {
      "fromJson" =>
        PageViewAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
