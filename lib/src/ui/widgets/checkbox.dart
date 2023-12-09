import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";

class DUITCheckbox extends StatefulWidget {
  final UIElementController? controller;

  const DUITCheckbox({
    super.key,
    this.controller,
  });

  @override
  State<DUITCheckbox> createState() => _DUITCheckboxState();
}

class _DUITCheckboxState extends State<DUITCheckbox>
    with ViewControllerChangeListener<DUITCheckbox, CheckboxAttributes> {
  bool? _value;

  @override
  void initState() {
    attachStateToController(widget.controller);
    _value = attributes?.value;
    super.initState();
  }

  void _onChange(bool? value) {
    final data = widget.controller?.attributes?.payload as CheckboxAttributes?;
    data?.update(value ?? false);
    widget.controller?.performRelatedAction();
    setState(() {
      _value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: _value,
      tristate: attributes?.tristate ?? true,
      autofocus: attributes?.autofocus ?? false,
      checkColor: attributes?.checkColor,
      hoverColor: attributes?.hoverColor,
      fillColor: attributes?.fillColor,
      focusColor: attributes?.focusColor,
      overlayColor: attributes?.overlayColor,
      splashRadius: attributes?.splashRadius,
      semanticLabel: attributes?.semanticLabel,
      side: attributes?.side,
      activeColor: attributes?.activeColor,
      isError: attributes?.isError ?? false,
      visualDensity: attributes?.visualDensity,
      onChanged: _onChange,
    );
  }
}
