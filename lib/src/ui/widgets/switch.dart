import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/ui/widgets/focus_node_helper.dart";

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
    with ViewControllerChangeListener, FocusNodeCommandHandler {
  bool? _value;

  @override
  void initState() {
    controller = widget.controller;
    attachStateToController(widget.controller);
    _value = attributes.tryGetBool("value");

    focusNode = attributes.focusNode(
      defaultValue: FocusNode(),
    )!;

    controller.driver.attachFocusNode(
      widget.controller.id,
      focusNode,
    );

    controller.listenCommand(handleCommand);

    super.initState();
  }

  @override
  void dispose() {
    controller.driver.detachFocusNode(controller.id);
    super.dispose();
  }

  void _onChange(bool val) {
    final data = widget.controller.attributes.payload;
    data.update(
      "value",
      (v) => val,
      ifAbsent: () => data["attributes"] = val,
    );
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
      focusNode: focusNode,
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
