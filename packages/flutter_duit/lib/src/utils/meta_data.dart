import "package:flutter/material.dart";

final class DuitMetaData extends InheritedWidget {
  final Map<String, dynamic> value;

  const DuitMetaData({
    required super.child,
    required this.value,
    super.key,
  });

  static DuitMetaData? maybeOf(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<DuitMetaData>();
    return result;
  }

  @override
  bool updateShouldNotify(DuitMetaData oldWidget) {
    return this != oldWidget;
  }
}
