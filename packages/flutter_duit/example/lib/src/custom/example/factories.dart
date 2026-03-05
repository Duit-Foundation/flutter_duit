import "package:flutter/material.dart";
import 'package:flutter_duit/flutter_duit.dart';
import "./widget.dart";

Widget exampleBuildFactory(
  ElementTreeEntry model, [
  Iterable<Widget> subviews = const [],
]) {
  if (model.isControlled) {
    return ExampleWidget(
      controller: model.viewController,
      child: model.child?.renderView(),
    );
  }
  return const Text("No-op");
}
