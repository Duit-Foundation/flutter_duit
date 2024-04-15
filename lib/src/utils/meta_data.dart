import "package:flutter/material.dart";

final class DuitMetaData extends InheritedWidget {
  final Map<String, dynamic> value;

  const DuitMetaData({
    super.key,
    required Widget child,
    required this.value,
  }) : super(child: child);

  static DuitMetaData? maybeOf(BuildContext context) {
    final DuitMetaData? result =
        context.dependOnInheritedWidgetOfExactType<DuitMetaData>();
    return result;
  }

  @override
  bool updateShouldNotify(DuitMetaData oldWidget) {
    return this != oldWidget;
  }
}
