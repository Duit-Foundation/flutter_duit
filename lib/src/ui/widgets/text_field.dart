import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

class DuitTextField extends StatefulWidget {
  final UIElementController? controller;

  const DuitTextField({
    super.key,
    required this.controller,
  });

  @override
  State<DuitTextField> createState() => _DuitTextFieldState();
}

class _DuitTextFieldState extends State<DuitTextField>
    with ViewControllerChangeListener<DuitTextField, TextFieldAttributes> {
  late final TextEditingController textEditingController;
  late final FocusNode focusNode;

  @override
  void initState() {
    attachStateToController(widget.controller);
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    textEditingController.addListener(() {
      final text = textEditingController.text;
      final data =
          widget.controller?.attributes?.payload as TextFieldAttributes?;
      data?.update(text);
      widget.controller?.performRelatedAction();
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
      controller: textEditingController,
      decoration: attributes?.decoration,
      style: attributes?.style,
      textDirection: attributes?.textDirection,
      textAlign: attributes?.textAlign ?? TextAlign.start,
      obscuringCharacter: attributes?.obscuringCharacter ?? "*",
      obscureText: attributes?.obscureText ?? false,
      autofocus: attributes?.autofocus ?? false,
      enabled: attributes?.enabled,
      enableSuggestions: attributes?.enableSuggestions ?? true,
      readOnly: attributes?.readOnly ?? false,
      expands: attributes?.expands ?? false,
      maxLines: attributes?.maxLines,
      maxLength: attributes?.maxLength,
      minLines: attributes?.minLines,
      showCursor: attributes?.showCursor,
      keyboardType: attributes?.keyboardType,
    );
  }
}
