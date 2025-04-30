import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

class DuitTextField extends StatefulWidget {
  final UIElementController controller;

  const DuitTextField({
    super.key,
    required this.controller,
  });

  @override
  State<DuitTextField> createState() => _DuitTextFieldState();
}

class _DuitTextFieldState extends State<DuitTextField>
    with ViewControllerChangeListener {
  late final TextEditingController textEditingController;
  late final FocusNode focusNode;

  @override
  void initState() {
    attachStateToController(widget.controller);
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    textEditingController.addListener(() {
      final text = textEditingController.text;
      attributes["value"] = text;
      widget.controller.performRelatedAction();
    });
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      onTapOutside: (_) {
        focusNode.unfocus();
      },
      key: Key(widget.controller.id),
      controller: textEditingController,
      decoration: attributes.inputDecoration(),
      style: attributes.textStyle(),
      textDirection: attributes.textDirection(),
      textAlign:
          attributes.textAlign(defaultValue: TextAlign.start) as TextAlign,
      obscuringCharacter: attributes.getString(
        key: "obscuringCharacter",
        defaultValue: "*",
      ),
      obscureText: attributes.getBool(
        "obscureText",
        defaultValue: false,
      ),
      autofocus: attributes.getBool(
        "autofocus",
        defaultValue: false,
      ),
      enabled: attributes.tryGetBool("enabled"),
      enableSuggestions: attributes.getBool(
        "enabled",
        defaultValue: true,
      ),
      readOnly: attributes.getBool(
        "readOnly",
        defaultValue: false,
      ),
      expands: attributes.getBool(
        "expands",
        defaultValue: false,
      ),
      maxLines: attributes.tryGetInt(key: "maxLines"),
      maxLength: attributes.tryGetInt(key: "maxLength"),
      minLines: attributes.tryGetInt(key: "minLines"),
      showCursor: attributes.tryGetBool("showCursor"),
      keyboardType: attributes.textInputType(),
    );
  }
}
