import 'package:example/src/custom/example/widget.dart';
import "package:flutter/material.dart";
import 'package:flutter_duit/flutter_duit.dart';

Widget exampleBuildFactory(
  ElementTreeEntry model, [
  Iterable<Widget> subviews = const [],
]) {
  return ExampleWidget(
    controller: model.viewController,
    child: model.child?.renderView(),
  );
}
