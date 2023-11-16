import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/controller/index.dart";

class DUITTextField extends StatefulWidget {
  final UIElementController<TextFieldAttributes> controller;

  const DUITTextField({
    super.key,
    required this.controller,
  });

  @override
  State<DUITTextField> createState() => _DUITTextFieldState();
}

class _DUITTextFieldState extends State<DUITTextField> {
  late final TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController()
      ..addListener(() {
        widget.controller.attributes?.payload.value =
            textEditingController.text;
      });
    widget.controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
    );
  }
}
