import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";

class DuitSwitch extends StatefulWidget {
  final UIElementController controller;

  const DuitSwitch({
    super.key,
    required this.controller,
  });

  @override
  State<DuitSwitch> createState() => _DuitSwitchState();
}

class _DuitSwitchState extends State<DuitSwitch>
    with ViewControllerChangeListener<DuitSwitch, SwitchAttributes> {
  bool? _value;

  @override
  void initState() {
    attachStateToController(widget.controller);
    _value = attributes.value;
    super.initState();
  }

  void _onChange(bool val) {
    final data = widget.controller.attributes?.payload as CheckboxAttributes;
    data.update(val);
    widget.controller.performRelatedAction();
    setState(() {
      _value = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      key: Key(widget.controller.id),
      value: _value!,
      onChanged: _onChange,
      activeColor: attributes.activeColor,
      focusColor: attributes.focusColor,
      hoverColor: attributes.hoverColor,
      inactiveTrackColor: attributes.inactiveTrackColor,
      activeTrackColor: attributes.inactiveTrackColor,
      overlayColor: attributes.overlayColor,
      trackColor: attributes.trackColor,
      thumbColor: attributes.thumbColor,
      trackOutlineColor: attributes.trackOutlineColor,
      trackOutlineWidth: attributes.trackOutlineWidth,
      splashRadius: attributes.splashRadius,
      materialTapTargetSize: attributes.materialTapTargetSize,
      autofocus: attributes.autofocus ?? false,
    );
  }
}
