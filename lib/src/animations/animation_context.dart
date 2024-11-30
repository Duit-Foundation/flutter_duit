import "package:flutter/material.dart";

class DuitAnimationContext extends InheritedWidget {
  final Map<String, dynamic> data;
  final String parentId;

  const DuitAnimationContext({
    super.key,
    required Widget child,
    required this.data,
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
