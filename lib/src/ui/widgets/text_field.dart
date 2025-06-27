import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

class DuitTextField extends StatefulWidget {
  final UIElementController<TextFieldAttributes> controller;

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
    textEditingController = TextEditingController(text: attributes.value);
    focusNode = FocusNode();
    textEditingController.addListener(() {
      final text = textEditingController.text;
      final data = widget.controller.attributes.payload;
      data.update(text);
      widget.controller.performRelatedAction();
    });
    super.initState();
  }

  void _syncControllerWithValue() {
    if (textEditingController.text != attributes.value) {
      textEditingController.text = attributes.value;
    }
  }

  @override
  void didUpdateWidget(covariant DuitTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncControllerWithValue();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    if (mounted) {
      _syncControllerWithValue();
    }
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
      decoration: attributes.decoration,
      style: attributes.style,
      textDirection: attributes.textDirection,
      textAlign: attributes.textAlign ?? TextAlign.start,
      obscuringCharacter: attributes.obscuringCharacter ?? "*",
      obscureText: attributes.obscureText ?? false,
      autofocus: attributes.autofocus ?? false,
      enabled: attributes.enabled,
      enableSuggestions: attributes.enableSuggestions ?? true,
      readOnly: attributes.readOnly ?? false,
      expands: attributes.expands ?? false,
      maxLines: attributes.maxLines,
      maxLength: attributes.maxLength,
      minLines: attributes.minLines,
      showCursor: attributes.showCursor,
      keyboardType: attributes.keyboardType,
    );
  }
}
