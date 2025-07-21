// import 'package:example/src/custom/example/attributes.dart';
// import 'package:example/src/custom/example/model.dart';
// import 'package:example/src/custom/example/widget.dart';
// import "package:flutter/material.dart";
// import 'package:flutter_duit/flutter_duit.dart';

// DuitAttributes exAttributeFactory(
//   String type,
//   Map<String, dynamic>? json,
// ) {
//   return ExampleCustomWidgetAttributes.fromJson(json ?? {});
// }

// Widget exBuildFactory(
//   ElementTreeEntry model, [
//   Iterable<Widget> subviews = const [],
// ]) {
//   final m = model as ExampleCustomWidget;
//   Widget? child;

//   if (subviews.isNotEmpty) {
//     child = subviews.first;
//   }

//   return ExampleWidget(
//     controller: m.viewController!,
//     child: child,
//   );
// }

// ElementTreeEntry exModelFactory(
//   String id,
//   bool controlled,
//   ViewAttribute attributes,
//   UIElementController? controller, [
//   Iterable<ElementTreeEntry> subviews = const [],
// ]) {
//   return ExampleCustomWidget(
//     id: id,
//     attributes: attributes,
//     viewController: controller,
//     controlled: controlled,
//     subviews: subviews,
//   );
// }
