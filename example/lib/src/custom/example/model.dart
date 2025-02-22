import 'package:example/src/custom/example/attributes.dart';
import 'package:example/src/custom/index.dart';
import 'package:flutter_duit/flutter_duit.dart';

// Use CustomUiElement instead of DuitElement
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
