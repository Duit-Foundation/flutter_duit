import "package:flutter/material.dart";

class DuitAnimationContext extends InheritedWidget {
  final Map<String, Animation> streams;
  final String parentId;

  const DuitAnimationContext({
    super.key,
    required Widget child,
    required this.streams,
    required this.parentId,
  }) : super(child: child);

  static DuitAnimationContext? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DuitAnimationContext>();
  }

  @override
  bool updateShouldNotify(DuitAnimationContext oldWidget) {
    return this != oldWidget;
  }
}
