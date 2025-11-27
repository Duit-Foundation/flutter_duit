import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

class DuitTextField extends StatefulWidget {
  final UIElementController controller;

  const DuitTextField({
    required this.controller,
    super.key,
  });

  @override
  State<DuitTextField> createState() => _DuitTextFieldState();
}

class _DuitTextFieldState extends State<DuitTextField>
    with ViewControllerChangeListener {
  late final TextEditingController _textEditingController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    attachStateToController(widget.controller);
    _textEditingController = TextEditingController(
      text: attributes.getString(key: "value"),
    );
    _focusNode = FocusNode();
    _textEditingController.addListener(() {
      final text = _textEditingController.text;
      attributes.update("value", (v) => text);
      widget.controller.performRelatedAction();
    });
    super.initState();
  }

  void _syncControllerWithValue() {
    if (_textEditingController.text != attributes.getString(key: "value")) {
      _textEditingController.text = attributes.getString(key: "value");
    }
  }

  @override
  void didUpdateWidget(covariant DuitTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncControllerWithValue();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      _syncControllerWithValue();
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      onTapOutside: (_) {
        _focusNode.unfocus();
      },
      key: Key(widget.controller.id),
      controller: _textEditingController,
      decoration: attributes.inputDecoration(),
      style: attributes.textStyle(),
      textDirection: attributes.textDirection(),
      textAlign: attributes.textAlign(defaultValue: TextAlign.start)!,
      obscuringCharacter: attributes.getString(
        key: "obscuringCharacter",
        defaultValue: "•",
      ),
      obscureText: attributes.getBool("obscureText"),
      autofocus: attributes.getBool("autofocus"),
      enabled: attributes.tryGetBool("enabled"),
      enableSuggestions: attributes.getBool(
        "enableSuggestions",
        defaultValue: true,
      ),
      readOnly: attributes.getBool("readOnly"),
      expands: attributes.getBool("expands"),
      maxLines: attributes.tryGetInt(key: "maxLines"),
      maxLength: attributes.tryGetInt(key: "maxLength"),
      minLines: attributes.tryGetInt(key: "minLines"),
      showCursor: attributes.tryGetBool("showCursor"),
      keyboardType: attributes.textInputType(),
    );
  }
}
