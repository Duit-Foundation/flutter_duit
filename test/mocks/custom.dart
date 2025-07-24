import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';

const exampleCustomWidget = "ExampleCustomWidget";

Widget exBuildFactory(
  ElementTreeEntry model, [
  Iterable<Widget> subviews = const [],
]) {
  return ExampleWidget(
    controller: model.viewController,
    child: subviews.isEmpty ? null : subviews.first,
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

final class CustomWidgetThemeToken extends ThemeToken {
  CustomWidgetThemeToken(Map<String, dynamic> themeData)
      : super(
          const {},
          themeData,
          exampleCustomWidget,
        );
}

Future<void> regCustom() async {
  final themeData = DuitThemePreprocessor(
    customWidgetTokenizer: (type, themeData) {
      print("type: $type");
      if (type == exampleCustomWidget) {
        return CustomWidgetThemeToken(themeData);
      }
      return null;
    },
  ).tokenize(
    {
      "custom_1": {
        "type": exampleCustomWidget,
        "data": {
          "random": "100500",
        }
      }
    },
  );
  await DuitRegistry.initialize(
    theme: themeData,
  );

  DuitRegistry.register(
    exampleCustomWidget,
    buildFactory: exBuildFactory,
  );
}
