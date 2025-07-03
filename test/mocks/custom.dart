import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';

import '../utils.dart';

const exampleCustomWidget = "ExampleCustomWidget";

Widget exBuildFactory(
  ElementTreeEntry model, [
  Iterable<Widget> subviews = const [],
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

ElementTreeEntry exModelFactory(
  String id,
  bool controlled,
  ViewAttribute attributes,
  UIElementController? controller, [
  Iterable<ElementTreeEntry> subviews = const [],
]) {
  return ExampleCustomWidget(
    id: id,
    attributes: attributes,
    viewController: controller,
    controlled: controlled,
    subviews: subviews,
  );
}

final class ExampleCustomWidget extends CustomUiElement {
  ExampleCustomWidget({
    required super.id,
    required super.attributes,
    required super.viewController,
    required super.controlled,
    required super.subviews,
  }) : super(
          tag: exampleCustomWidget,
        );
}

class ExampleWidget extends StatefulWidget {
  final Widget? child;
  final UIElementController controller;

  const ExampleWidget({
    super.key,
    required this.controller,
    this.child,
  });

  @override
  State<ExampleWidget> createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Text(attributes.getString(key: "random")),
          widget.child ??
              Container(
                color: Colors.red,
                width: 25,
                height: 25,
              ),
        ],
      ),
    );
  }
}

Future<void> regCustom() async {
  await DuitRegistry.configure(
    themeLoader: const MockThemeLoader(
      {
        "custom_1": {
          "type": exampleCustomWidget,
          "data": {
            "random": "100500",
          }
        }
      },
    ),
  );

  DuitRegistry.initTheme();

  DuitRegistry.register(
    exampleCustomWidget,
    modelFactory: exModelFactory,
    buildFactory: exBuildFactory,
  );
}
