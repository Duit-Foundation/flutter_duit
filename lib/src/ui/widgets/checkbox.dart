import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitCheckbox extends StatefulWidget {
  final UIElementController controller;

  const DuitCheckbox({
    super.key,
    required this.controller,
  });

  @override
  State<DuitCheckbox> createState() => _DuitCheckboxState();
}

class _DuitCheckboxState extends State<DuitCheckbox>
    with ViewControllerChangeListener {
  bool? _value;

  @override
  void initState() {
    attachStateToController(widget.controller);
    _value = attributes.tryGetBool("value");
    super.initState();
  }

  void _onChange(bool? value) {
    attributes.update("value", (value) => value ?? false);
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
      tristate: attributes.getBool("tristate"),
      autofocus: attributes.getBool("autofocus"),
      checkColor: attributes.tryParseColor(key: "checkColor"),
      hoverColor: attributes.tryParseColor(key: "hoverColor"),
      fillColor: attributes.widgetStateProperty<Color>(key: "fillColor"),
      focusColor: attributes.tryParseColor(key: "focusColor"),
      overlayColor: attributes.widgetStateProperty<Color>(key: "overlayColor"),
      splashRadius: attributes.tryGetDouble(key: "splashRadius"),
      semanticLabel: attributes.getString(key: "semanticLabel"),
      side: attributes.borderSide(),
      activeColor: attributes.tryParseColor(key: "activeColor"),
      isError: attributes.getBool("isError"),
      visualDensity: attributes.visualDensity(),
      materialTapTargetSize: attributes.materialTapTargetSize(),
      onChanged: _onChange,
    );
  }
}
