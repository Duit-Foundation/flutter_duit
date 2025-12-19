import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/duit_impl/index.dart";
import "package:flutter_duit/src/ui/widgets/focus_node_helper.dart";

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
    with ViewControllerChangeListener, FocusNodeCommandHandler {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    controller = widget.controller;
    attachStateToController(controller);
    _textEditingController = TextEditingController(
      text: attributes.getString(key: "value"),
    );

    focusNode = attributes.focusNode(
      defaultValue: FocusNode(),
    )!;

    controller.driver.attachFocusNode(
      widget.controller.id,
      focusNode,
    );

    _textEditingController.addListener(() {
      final text = _textEditingController.text;
      attributes.update(
        "value",
        (_) => text,
        ifAbsent: () => text,
      );
      controller.performRelatedAction();
    });

    controller.listenCommand(handleCommand);

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
  void setState(_) {
    if (mounted) {
      _syncControllerWithValue();
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    widget.controller.driver.detachFocusNode(widget.controller.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: Key(widget.controller.id),
      focusNode: focusNode,
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
