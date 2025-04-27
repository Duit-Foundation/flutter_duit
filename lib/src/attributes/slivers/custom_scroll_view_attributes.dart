import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class CustomScrollViewAttributes
    implements DuitAttributes<CustomScrollViewAttributes> {
  final Axis scrollDirection;
  final bool reverse, shrinkWrap;
  final bool? primary;
  final ScrollPhysics? physics;
  //TODO: add scrollBehavior
  // final ScrollBehavior? scrollBehavior;
  final Key? center;
  final double anchor;
  final double? cacheExtent;
  final int? semanticChildCount;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;
  final HitTestBehavior hitTestBehavior;

  const CustomScrollViewAttributes({
    required this.scrollDirection,
    required this.reverse,
    required this.shrinkWrap,
    required this.primary,
    required this.physics,
    // required this.scrollBehavior,
    required this.center,
    required this.anchor,
    required this.cacheExtent,
    required this.semanticChildCount,
    required this.dragStartBehavior,
    required this.keyboardDismissBehavior,
    required this.restorationId,
    required this.clipBehavior,
    required this.hitTestBehavior,
  });

  factory CustomScrollViewAttributes.fromJson(Map<String, dynamic> json) {
    return CustomScrollViewAttributes(
      scrollDirection: AttributeValueMapper.toAxis(json['scrollDirection']),
      reverse: json['reverse'] ?? false,
      shrinkWrap: json['shrinkWrap'] ?? false,
      primary: json['primary'],
      physics: AttributeValueMapper.toScrollPhysics(json['physics']),
      // scrollBehavior: AttributeValueMapper.toScrollBehavior(json['scrollBehavior']),
      center: json['center'] != null ? ValueKey(json['center']) : null,
      anchor: NumUtils.toDoubleWithNullReplacement(json['anchor']),
      cacheExtent: NumUtils.toDouble(json['cacheExtent']),
      semanticChildCount: NumUtils.toInt(json['semanticChildCount']),
      dragStartBehavior:
          AttributeValueMapper.toDragStartBehavior(json['dragStartBehavior']),
      keyboardDismissBehavior: AttributeValueMapper.toKeyboardDismissBehavior(
        json['keyboardDismissBehavior'],
      ),
      clipBehavior: AttributeValueMapper.toClip(json['clipBehavior']),
      hitTestBehavior:
          AttributeValueMapper.toHitTestBehavior(json['hitTestBehavior']),
      restorationId: json['restorationId'],
    );
  }

  @override
  CustomScrollViewAttributes copyWith(CustomScrollViewAttributes other) {
    return CustomScrollViewAttributes(
      scrollDirection: other.scrollDirection,
      reverse: other.reverse,
      shrinkWrap: other.shrinkWrap,
      primary: other.primary ?? primary,
      physics: other.physics ?? physics,
      // scrollBehavior: other.scrollBehavior,
      center: other.center ?? center,
      anchor: other.anchor,
      cacheExtent: other.cacheExtent ?? cacheExtent,
      semanticChildCount: other.semanticChildCount ?? semanticChildCount,
      dragStartBehavior: other.dragStartBehavior,
      keyboardDismissBehavior: other.keyboardDismissBehavior,
      clipBehavior: other.clipBehavior,
      hitTestBehavior: other.hitTestBehavior,
      restorationId: other.restorationId ?? restorationId,
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
