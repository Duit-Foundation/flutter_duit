import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/utils/index.dart';

class GestureDetectorAttributes
    implements DuitAttributes<GestureDetectorAttributes> {
  ServerAction? onTap,
      onTapDown,
      onTapUp,
      onTapCancel,
      onDoubleTap,
      onDoubleTapDown,
      onDoubleTapCancel,
      onLongPressDown,
      onLongPressCancel,
      onLongPress,
      onLongPressStart,
      onLongPressMoveUpdate,
      onLongPressUp,
      onLongPressEnd,
      onPanStart,
      onPanDown,
      onPanUpdate,
      onPanEnd,
      onPanCancel;
  bool? excludeFromSemantics;
  DragStartBehavior dragStartBehavior;
  HitTestBehavior? behavior;

  GestureDetectorAttributes({
    this.onTap,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onDoubleTap,
    this.onDoubleTapDown,
    this.onDoubleTapCancel,
    this.onLongPressDown,
    this.onLongPressCancel,
    this.onLongPress,
    this.onLongPressStart,
    this.onLongPressMoveUpdate,
    this.onLongPressUp,
    this.onLongPressEnd,
    this.onPanStart,
    this.onPanDown,
    this.onPanUpdate,
    this.onPanEnd,
    this.onPanCancel,
    this.excludeFromSemantics,
    this.dragStartBehavior = DragStartBehavior.start,
    this.behavior,
  });

  @override
  GestureDetectorAttributes copyWith(other) {
    return GestureDetectorAttributes(
      onTap: other.onTap ?? onTap,
      onTapDown: other.onTapDown ?? onTapDown,
      onTapUp: other.onTapUp ?? onTapUp,
      onTapCancel: other.onTapCancel ?? onTapCancel,
      onDoubleTap: other.onDoubleTap ?? onDoubleTap,
      onDoubleTapDown: other.onDoubleTapDown ?? onDoubleTapDown,
      onDoubleTapCancel: other.onDoubleTapCancel ?? onDoubleTapCancel,
      onLongPressDown: other.onLongPressDown ?? onLongPressDown,
      onLongPressCancel: other.onLongPressCancel ?? onLongPressCancel,
      onLongPress: other.onLongPress ?? onLongPress,
      onLongPressStart: other.onLongPressStart ?? onLongPressStart,
      onLongPressMoveUpdate:
          other.onLongPressMoveUpdate ?? onLongPressMoveUpdate,
      onLongPressUp: other.onLongPressUp ?? onLongPressUp,
      onLongPressEnd: other.onLongPressEnd ?? onLongPressEnd,
      onPanStart: other.onPanStart ?? onPanStart,
      onPanDown: other.onPanDown ?? onPanDown,
      onPanUpdate: other.onPanUpdate ?? onPanUpdate,
      onPanEnd: other.onPanEnd ?? onPanEnd,
      onPanCancel: other.onPanCancel ?? onPanCancel,
      excludeFromSemantics: other.excludeFromSemantics ?? excludeFromSemantics,
      dragStartBehavior: other.dragStartBehavior,
      behavior: other.behavior ?? behavior,
    );
  }

  factory GestureDetectorAttributes.fromJson(JSONObject json) {
    return GestureDetectorAttributes(
      onTap: json["onTap"] != null ? ServerAction.parse(json["onTap"]) : null,
      onTapDown: json["onTapDown"] != null
          ? ServerAction.parse(json["onTapDown"])
          : null,
      onTapUp:
          json["onTapUp"] != null ? ServerAction.parse(json["onTapUp"]) : null,
      onTapCancel: json["onTapCancel"] != null
          ? ServerAction.parse(json["onTapCancel"])
          : null,
      onDoubleTap: json["onDoubleTap"] != null
          ? ServerAction.parse(json["onDoubleTap"])
          : null,
      onDoubleTapDown: json["onDoubleTapDown"] != null
          ? ServerAction.parse(json["onDoubleTapDown"])
          : null,
      onDoubleTapCancel: json["onDoubleTapCancel"] != null
          ? ServerAction.parse(json["onDoubleTapCancel"])
          : null,
      onLongPressDown: json["onLongPressDown"] != null
          ? ServerAction.parse(json["onLongPressDown"])
          : null,
      onLongPressCancel: json["onLongPressCancel"] != null
          ? ServerAction.parse(json["onLongPressCancel"])
          : null,
      onLongPress: json["onLongPress"] != null
          ? ServerAction.parse(json["onLongPress"])
          : null,
      onLongPressStart: json["onLongPressStart"] != null
          ? ServerAction.parse(json["onLongPressStart"])
          : null,
      onLongPressMoveUpdate: json["onLongPressMoveUpdate"] != null
          ? ServerAction.parse(json["onLongPressMoveUpdate"])
          : null,
      onLongPressUp: json["onLongPressUp"] != null
          ? ServerAction.parse(json["onLongPressUp"])
          : null,
      onLongPressEnd: json["onLongPressEnd"] != null
          ? ServerAction.parse(json["onLongPressEnd"])
          : null,
      onPanStart: json["onPanStart"] != null
          ? ServerAction.parse(json["onPanStart"])
          : null,
      onPanDown: json["onPanDown"] != null
          ? ServerAction.parse(json["onPanDown"])
          : null,
      onPanUpdate: json["onPanUpdate"] != null
          ? ServerAction.parse(json["onPanUpdate"])
          : null,
      onPanEnd: json["onPanEnd"] != null
          ? ServerAction.parse(json["onPanEnd"])
          : null,
      onPanCancel: json["onPanCancel"] != null
          ? ServerAction.parse(json["onPanCancel"])
          : null,
      excludeFromSemantics: json['excludeFromSemantics'] ?? false,
      dragStartBehavior:
          AttributeValueMapper.toDragStartBehavior(json['dragStartBehavior']),
      behavior: AttributeValueMapper.toHitTestBehavior(json['behavior']),
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
        GestureDetectorAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
