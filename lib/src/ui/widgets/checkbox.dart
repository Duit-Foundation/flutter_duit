import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";

class DuitCheckbox extends StatefulWidget {
  final UIElementController<CheckboxAttributes> controller;

  const DuitCheckbox({
    super.key,
    required this.controller,
  });

  @override
  State<DuitCheckbox> createState() => _DuitCheckboxState();
}

class _DuitCheckboxState extends State<DuitCheckbox>
    with ViewControllerChangeListener<DuitCheckbox, CheckboxAttributes> {
  bool? _value;

  @override
  void initState() {
    attachStateToController(widget.controller);
    _value = attributes.value;
    super.initState();
  }

  void _onChange(bool? value) {
    final data = widget.controller.attributes.payload;
    data.update(value ?? false);
    widget.controller.performRelatedAction();
    setState(() {
      _value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      key: Key(widget.controller.id),
      value: _value,
      tristate: attributes.tristate ?? true,
      autofocus: attributes.autofocus ?? false,
      checkColor: attributes.checkColor,
      hoverColor: attributes.hoverColor,
      fillColor: attributes.fillColor,
      focusColor: attributes.focusColor,
      overlayColor: attributes.overlayColor,
      splashRadius: attributes.splashRadius,
      semanticLabel: attributes.semanticLabel,
      side: attributes.side,
      activeColor: attributes.activeColor,
      isError: attributes.isError ?? false,
      visualDensity: attributes.visualDensity,
      onChanged: _onChange,
    );
  }
}
