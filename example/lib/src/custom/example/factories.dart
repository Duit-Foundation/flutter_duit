import 'package:duit_kernel/duit_kernel.dart';
import 'package:example/src/custom/example/attributes.dart';
import 'package:example/src/custom/example/model.dart';
import 'package:example/src/custom/example/widget.dart';
import "package:flutter/material.dart";

DuitAttributes exAttributeFactory(
  String type,
  Map<String, dynamic>? json,
) {
  return ExampleCustomWidgetAttributes(random: json?["random"] ?? "no random")
      as DuitAttributes;
}

Widget exBuildFactory(
  TreeElement model, [
  Iterable<Widget> subviews = const {},
]) {
  final m = model as ExampleCustomWidget;
  Widget? child;

  if (subviews.isNotEmpty) {
    child = subviews.first;
  }

  return ExampleWidget(
    controller: m.viewController!,
    child: child,
  );
}

TreeElement exModelFactory(
  String id,
  bool controlled,
  ViewAttribute attributes,
  UIElementController? controller, [
  Iterable<TreeElement> subviews = const {},
]) {
  return ExampleCustomWidget(
    id: id,
    attributes: attributes,
    viewController: controller,
    controlled: controlled,
    subviews: subviews,
  );
}
