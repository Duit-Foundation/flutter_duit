import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";

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
    with ViewControllerChangeListener<DuitSlider, SliderAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  void _onChangeHandler(double value) {
    attributes?.update(value);
    widget.controller.performAction(attributes?.onChanged);
  }

  void _onChangeStartHandler(double _) {
    widget.controller.performAction(attributes?.onChangeStart);
  }

  void _onChangeEndHandler(double _) {
    widget.controller.performAction(attributes?.onChangeEnd);
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: attributes?.value ?? 0.0,
      onChanged: _onChangeHandler,
      onChangeStart: _onChangeStartHandler,
      onChangeEnd: _onChangeEndHandler,
      min: attributes?.min ?? 0,
      max: attributes?.max ?? 1,
      divisions: attributes?.divisions,
      label: attributes?.label,
      activeColor: attributes?.activeColor,
      inactiveColor: attributes?.inactiveColor,
      secondaryActiveColor: attributes?.secondaryActiveColor,
      thumbColor: attributes?.thumbColor,
      overlayColor: attributes?.overlayColor,
      autofocus: attributes?.autofocus ?? false,
      secondaryTrackValue: attributes?.secondaryTrackValue,
      allowedInteraction: attributes?.allowedInteraction,
    );
  }
}
