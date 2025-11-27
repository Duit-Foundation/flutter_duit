import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitSwitch extends StatefulWidget {
  final UIElementController controller;

  const DuitSwitch({
    required this.controller,
    super.key,
  });

  @override
  State<DuitSwitch> createState() => _DuitSwitchState();
}

class _DuitSwitchState extends State<DuitSwitch>
    with ViewControllerChangeListener {
  bool? _value;

  @override
  void initState() {
    attachStateToController(widget.controller);
    _value = attributes.tryGetBool("value");
    super.initState();
  }

  void _onChange(bool val) {
    final data = widget.controller.attributes.payload;
    data.update("value", (v) => val);
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
      activeColor: attributes.tryParseColor(key: "activeColor"),
      focusColor: attributes.tryParseColor(key: "focusColor"),
      hoverColor: attributes.tryParseColor(key: "hoverColor"),
      inactiveTrackColor: attributes.tryParseColor(key: "inactiveTrackColor"),
      activeTrackColor: attributes.tryParseColor(key: "activeTrackColor"),
      overlayColor: attributes.widgetStateProperty<Color>(key: "overlayColor"),
      trackColor: attributes.widgetStateProperty<Color>(key: "trackColor"),
      thumbColor: attributes.widgetStateProperty<Color>(key: "thumbColor"),
      trackOutlineColor: attributes.widgetStateProperty<Color>(
        key: "trackOutlineColor",
      ),
      trackOutlineWidth:
          attributes.widgetStateProperty<double>(key: "trackOutlineWidth"),
      splashRadius: attributes.tryGetDouble(key: "splashRadius"),
      materialTapTargetSize: attributes.materialTapTargetSize(),
      autofocus: attributes.getBool("autofocus"),
    );
  }
}
