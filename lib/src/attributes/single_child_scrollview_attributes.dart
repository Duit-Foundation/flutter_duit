import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/utils/index.dart';

class SingleChildScrollviewAttributes
    implements DuitAttributes<SingleChildScrollviewAttributes> {
  final Axis? scrollDirection;
  final bool? reverse, primary;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final String? restorationId;
  final Clip? clipBehavior;
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;
  final DragStartBehavior? dragStartBehavior;

  SingleChildScrollviewAttributes({
    required this.scrollDirection,
    required this.reverse,
    required this.primary,
    required this.padding,
    required this.physics,
    required this.restorationId,
    required this.clipBehavior,
    required this.keyboardDismissBehavior,
    required this.dragStartBehavior,
  });

  factory SingleChildScrollviewAttributes.fromJson(Map<String, dynamic> json) {
    return SingleChildScrollviewAttributes(
      scrollDirection: AttributeValueMapper.toAxis(json['scrollDirection']),
      reverse: json['reverse'],
      primary: json['primary'],
      padding: AttributeValueMapper.toEdgeInsets(json['padding']),
      physics: AttributeValueMapper.toScrollPhysics(json['physics']),
      restorationId: json['restorationId'],
      clipBehavior: AttributeValueMapper.toClip(json['clipBehavior']),
      keyboardDismissBehavior: AttributeValueMapper.toKeyboardDismissBehavior(
          json['keyboardDismissBehavior']),
      dragStartBehavior:
          AttributeValueMapper.toDragStartBehavior(json['dragStartBehavior']),
    );
  }

  @override
  SingleChildScrollviewAttributes copyWith(other) {
    return SingleChildScrollviewAttributes(
      scrollDirection: other.scrollDirection ?? scrollDirection,
      reverse: other.reverse ?? reverse,
      primary: other.primary ?? primary,
      padding: other.padding ?? padding,
      physics: other.physics ?? physics,
      restorationId: other.restorationId ?? restorationId,
      clipBehavior: other.clipBehavior ?? clipBehavior,
      keyboardDismissBehavior:
          other.keyboardDismissBehavior ?? keyboardDismissBehavior,
      dragStartBehavior: other.dragStartBehavior ?? dragStartBehavior,
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
        SingleChildScrollviewAttributes.fromJson(positionalParams!.first)
            as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
