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
      onTap:
          json["onTap"] != null ? ServerAction.fromJson(json["onTap"]) : null,
      onTapDown: json["onTapDown"] != null
          ? ServerAction.fromJson(json["onTapDown"])
          : null,
      onTapUp: json["onTapUp"] != null
          ? ServerAction.fromJson(json["onTapUp"])
          : null,
      onTapCancel: json["onTapCancel"] != null
          ? ServerAction.fromJson(json["onTapCancel"])
          : null,
      onDoubleTap: json["onDoubleTap"] != null
          ? ServerAction.fromJson(json["onDoubleTap"])
          : null,
      onDoubleTapDown: json["onDoubleTapDown"] != null
          ? ServerAction.fromJson(json["onDoubleTapDown"])
          : null,
      onDoubleTapCancel: json["onDoubleTapCancel"] != null
          ? ServerAction.fromJson(json["onDoubleTapCancel"])
          : null,
      onLongPressDown: json["onLongPressDown"] != null
          ? ServerAction.fromJson(json["onLongPressDown"])
          : null,
      onLongPressCancel: json["onLongPressCancel"] != null
          ? ServerAction.fromJson(json["onLongPressCancel"])
          : null,
      onLongPress: json["onLongPress"] != null
          ? ServerAction.fromJson(json["onLongPress"])
          : null,
      onLongPressStart: json["onLongPressStart"] != null
          ? ServerAction.fromJson(json["onLongPressStart"])
          : null,
      onLongPressMoveUpdate: json["onLongPressMoveUpdate"] != null
          ? ServerAction.fromJson(json["onLongPressMoveUpdate"])
          : null,
      onLongPressUp: json["onLongPressUp"] != null
          ? ServerAction.fromJson(json["onLongPressUp"])
          : null,
      onLongPressEnd: json["onLongPressEnd"] != null
          ? ServerAction.fromJson(json["onLongPressEnd"])
          : null,
      onPanStart: json["onPanStart"] != null
          ? ServerAction.fromJson(json["onPanStart"])
          : null,
      onPanDown: json["onPanDown"] != null
          ? ServerAction.fromJson(json["onPanDown"])
          : null,
      onPanUpdate: json["onPanUpdate"] != null
          ? ServerAction.fromJson(json["onPanUpdate"])
          : null,
      onPanEnd: json["onPanEnd"] != null
          ? ServerAction.fromJson(json["onPanEnd"])
          : null,
      onPanCancel: json["onPanCancel"] != null
          ? ServerAction.fromJson(json["onPanCancel"])
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
