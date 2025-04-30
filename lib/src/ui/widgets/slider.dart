import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitSlider extends StatefulWidget {
  final UIElementController controller;

  const DuitSlider({
    super.key,
    required this.controller,
  });

  @override
  State<DuitSlider> createState() => _DuitSliderState();
}

class _DuitSliderState extends State<DuitSlider>
    with ViewControllerChangeListener {
  double _value = 0;

  @override
  void initState() {
    attachStateToController(widget.controller);
    _value = attributes.getDouble(key: "value");
    super.initState();
  }

  void _onChangeHandler(double value) {
    setState(() {
      _value = value;
    });
    widget.controller.performAction(attributes.getAction("onChange"));
  }

  void _onChangeStartHandler(double _) {
    widget.controller.performAction(attributes.getAction("onChangeStart"));
  }

  void _onChangeEndHandler(double value) {
    attributes["value"] = value;
    widget.controller.performAction(attributes.getAction("onChangeEnd"));
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      key: Key(widget.controller.id),
      value: _value,
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
      autofocus: attributes.getBool("autofocus", defaultValue: false),
      secondaryTrackValue: attributes.tryGetDouble(key: "secondaryTrackValue"),
      allowedInteraction:
          attributes.sliderInteraction(key: "allowedInteraction"),
    );
  }
}
