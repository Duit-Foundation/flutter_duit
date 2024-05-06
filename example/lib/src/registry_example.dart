import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';

final class ExampleCustomWidget<T> extends DuitElement<T> {
  ExampleCustomWidget({
    required super.id,
    required super.attributes,
    required super.viewController,
    required super.controlled,
  }) : super(
          type: "Custom",
          tag: "ExampleCustomWidget",
        );
}

class ExampleCustomWidgetAttributes
    implements DuitAttributes<ExampleCustomWidgetAttributes> {
  String? random;

  ExampleCustomWidgetAttributes({required this.random});

  @override
  ExampleCustomWidgetAttributes copyWith(other) {
    return ExampleCustomWidgetAttributes(
      random: other.random ?? random,
    );
  }
}

DuitAttributes exampleAttributeMapper(String type, Map<String, dynamic>? json) {
  return ExampleCustomWidgetAttributes(random: json?["random"] ?? "no random");
}

class ExampleWidget extends StatefulWidget {
  final UIElementController controller;

  const ExampleWidget({
    super.key,
    required this.controller,
  });

  @override
  State<ExampleWidget> createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget>
    with
        ViewControllerChangeListener<ExampleWidget,
            ExampleCustomWidgetAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(attributes.random ?? "");
  }
}

Widget exampleRenderer(TreeElement model) {
  return ExampleWidget(
    controller: model.viewController!,
  );
}

DuitElement modelMapperExample(
  String id,
  bool controlled,
  ViewAttributeWrapper attributes,
  UIElementController? controller,
) {
  return ExampleCustomWidget(
    id: id,
    attributes: attributes,
    viewController: controller,
    controlled: controlled,
  );
}
