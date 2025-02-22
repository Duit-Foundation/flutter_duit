import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';

final class ExampleCustomWidgetAttributes extends AnimatedPropertyOwner
    implements DuitAttributes<ExampleCustomWidgetAttributes> {
  final String? random;

  ExampleCustomWidgetAttributes({
    required this.random,
    required super.parentBuilderId,
    required super.affectedProperties,
  });

  factory ExampleCustomWidgetAttributes.fromJson(Map<String, dynamic> json) {
    final view = AnimatedPropHelper(json);

    return ExampleCustomWidgetAttributes(
      random: view["random"],
      parentBuilderId: view.parentBuilderId,
      affectedProperties: view.affectedProperties,
    );
  }

  @override
  ExampleCustomWidgetAttributes copyWith(other) {
    return ExampleCustomWidgetAttributes(
        random: other.random ?? random,
        parentBuilderId: other.parentBuilderId ?? parentBuilderId,
        affectedProperties: other.affectedProperties ?? affectedProperties);
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) {
    return switch (methodName) {
      "fromJson" =>
        ExampleCustomWidgetAttributes.fromJson(positionalParams!.first)
            as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}

const exampleCustomWidget = "ExampleCustomWidget";

DuitAttributes exAttributeFactory(
  String type,
  Map<String, dynamic>? json,
) {
  return ExampleCustomWidgetAttributes.fromJson(json ?? {});
}

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

final class ExampleCustomWidget
    extends CustomUiElement<ExampleCustomWidgetAttributes> {
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
  final UIElementController<ExampleCustomWidgetAttributes> controller;

  ExampleWidget({
    super.key,
    required UIElementController controller,
    this.child,
  }) : controller = controller.cast<ExampleCustomWidgetAttributes>();

  @override
  State<ExampleWidget> createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget>
    with
        ViewControllerChangeListener<ExampleWidget,
            ExampleCustomWidgetAttributes> {
  @override
  void initState() {
    attachStateToController(
      widget.controller,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Text(attributes.random ?? ""),
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

void regCustom() {
  DuitRegistry.configure();
  DuitRegistry.register(
    exampleCustomWidget,
    modelFactory: exModelFactory,
    buildFactory: exBuildFactory,
    attributesFactory: exAttributeFactory,
  );
}
