import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_duit/flutter_duit.dart';
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
      onTap: ServerAction.fromJSON(json["onTap"]),
      onTapDown: ServerAction.fromJSON(json["onTapDown"]),
      onTapUp: ServerAction.fromJSON(json["onTapUp"]),
      onTapCancel: ServerAction.fromJSON(json["onTapCancel"]),
      onDoubleTap: ServerAction.fromJSON(json["onDoubleTap"]),
      onDoubleTapDown: ServerAction.fromJSON(json["onDoubleTapDown"]),
      onDoubleTapCancel: ServerAction.fromJSON(json["onDoubleTapCancel"]),
      onLongPressDown: ServerAction.fromJSON(json["onLongPressDown"]),
      onLongPressCancel: ServerAction.fromJSON(json["onLongPressCancel"]),
      onLongPress: ServerAction.fromJSON(json["onLongPress"]),
      onLongPressStart: ServerAction.fromJSON(json["onLongPressStart"]),
      onLongPressMoveUpdate:
          ServerAction.fromJSON(json["onLongPressMoveUpdate"]),
      onLongPressUp: ServerAction.fromJSON(json["onLongPressUp"]),
      onLongPressEnd: ServerAction.fromJSON(json["onLongPressEnd"]),
      onPanStart: ServerAction.fromJSON(json["onPanStart"]),
      onPanDown: ServerAction.fromJSON(json["onPanDown"]),
      onPanUpdate: ServerAction.fromJSON(json["onPanUpdate"]),
      onPanEnd: ServerAction.fromJSON(json["onPanEnd"]),
      onPanCancel: ServerAction.fromJSON(json["onPanCancel"]),
      excludeFromSemantics: json['excludeFromSemantics'] ?? false,
      dragStartBehavior:
          ParamsMapper.convertToDragStartBehavior(json['dragStartBehavior']),
      behavior: ParamsMapper.convertToHitTestBehavior(json['behavior']),
    );
  }
}
