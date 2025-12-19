import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/ui/widgets/focus_node_helper.dart";

class DuitSlider extends StatefulWidget {
  final UIElementController controller;

  const DuitSlider({
    required this.controller,
    super.key,
  });

  @override
  State<DuitSlider> createState() => _DuitSliderState();
}

class _DuitSliderState extends State<DuitSlider>
    with ViewControllerChangeListener, FocusNodeCommandHandler {
  double _value = 0;

  @override
  void initState() {
    controller = widget.controller;
    attachStateToController(widget.controller);
    _value = attributes.getDouble(key: "value", defaultValue: 0);

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

  void _onChangeHandler(double value) {
    setState(() {
      _value = value;
    });
    widget.controller.performAction(attributes.getAction("onChanged"));
  }

  void _onChangeStartHandler(double _) {
    widget.controller.performAction(attributes.getAction("onChangeStart"));
  }

  void _onChangeEndHandler(double value) {
    attributes.update(
      "value",
      (v) => value,
      ifAbsent: () => value,
    );
    widget.controller.performAction(attributes.getAction("onChangeEnd"));
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      key: Key(widget.controller.id),
      value: _value,
      focusNode: focusNode,
      onChanged: _onChangeHandler,
      onChangeStart: _onChangeStartHandler,
      onChangeEnd: _onChangeEndHandler,
      min: attributes.getDouble(key: "min", defaultValue: 0),
      max: attributes.getDouble(key: "max", defaultValue: 1),
      divisions: attributes.tryGetInt(key: "divisions"),
      label: attributes.tryGetString("label"),
      activeColor: attributes.tryParseColor(key: "activeColor"),
      inactiveColor: attributes.tryParseColor(key: "inactiveColor"),
      secondaryActiveColor:
          attributes.tryParseColor(key: "secondaryActiveColor"),
      thumbColor: attributes.tryParseColor(key: "thumbColor"),
      overlayColor: attributes.widgetStateProperty<Color>(key: "overlayColor"),
      autofocus: attributes.getBool("autofocus"),
      secondaryTrackValue: attributes.tryGetDouble(key: "secondaryTrackValue"),
      allowedInteraction: attributes.sliderInteraction(
        key: "allowedInteraction",
      ),
    );
  }
}
