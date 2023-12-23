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

Widget exampleRenderer(TreeElement model) {
  final data = model.attributes?.payload as ExampleCustomWidgetAttributes?;
  return Text(data?.random ?? "no random");
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
