import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';

final class ExampleCustomWidget<T> extends DUITElement<T> {
  @override
  ViewAttributeWrapper<T>? attributes;

  @override
  UIElementController<T>? viewController;

  ExampleCustomWidget({
    required super.id,
    required this.attributes,
    required this.viewController,
    required super.controlled,
  }) : super(
          type: DUITElementType.custom,
          tag: "ExampleCustomWidget",
        );
}

class ExampleCustomWidgetAttributes
    implements DUITAttributes<ExampleCustomWidgetAttributes> {
  String? random;

  ExampleCustomWidgetAttributes({required this.random});

  @override
  ExampleCustomWidgetAttributes copyWith(other) {
    return ExampleCustomWidgetAttributes(
      random: other.random ?? random,
    );
  }
}

DUITAttributes exapleAttributeMapper(String type, Map<String, dynamic>? json) {
  return ExampleCustomWidgetAttributes(random: json?["random"] ?? "no random");
}

Widget exampleRenerer(DUITElement model) {
  return Text(model.id);
}

DUITElement modelMapperExample(
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
