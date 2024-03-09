import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/utils/index.dart';

class DuitListViewContext extends InheritedWidget {
  final List<JSONObject> childrenArray;
  final UIElementController controller;
  final int len;

  const DuitListViewContext({
    super.key,
    required super.child,
    required this.childrenArray,
    required this.controller,
    required this.len,
  });

  static DuitListViewContext of(BuildContext context) {
    final DuitListViewContext? result =
        context.dependOnInheritedWidgetOfExactType<DuitListViewContext>();
    assert(result != null, 'No DuitListViewContext found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(DuitListViewContext oldWidget) {
    return childrenArray != oldWidget.childrenArray || len != oldWidget.len;
  }
}
