import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

final class DuitControlledRadio extends StatefulWidget {
  final UIElementController? controller;

  const DuitControlledRadio({
    super.key,
    required this.controller,
  });

  @override
  State<DuitControlledRadio> createState() => _DuitControlledRadioState();
}

class _DuitControlledRadioState extends State<DuitControlledRadio>
    with ViewControllerChangeListener<DuitControlledRadio, RadioAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  void _onChangeHandler(dynamic value) {
    RadioGroupContext.maybeOf(context)?.updateGroupValue(value);
  }

  @override
  Widget build(BuildContext context) {
    final groupContext = RadioGroupContext.maybeOf(context);
    assert(groupContext != null, '_RadioGroupContext not found in context');
    return Radio(
      value: attributes?.value,
      groupValue: groupContext?.groupValue,
      onChanged: _onChangeHandler,
      toggleable: attributes?.toggleable ?? false,
      autofocus: attributes?.autofocus ?? false,
      activeColor: attributes?.activeColor,
      focusColor: attributes?.focusColor,
      hoverColor: attributes?.hoverColor,
      fillColor: attributes?.fillColor,
      overlayColor: attributes?.overlayColor,
      splashRadius: attributes?.splashRadius,
      materialTapTargetSize: attributes?.materialTapTargetSize,
      visualDensity: attributes?.visualDensity,
    );
  }
}

final class RadioGroupContext extends InheritedWidget {
  final dynamic groupValue;
  final Function(dynamic value) updater;

  const RadioGroupContext({
    super.key,
    required super.child,
    required this.groupValue,
    required this.updater,
  });

  static RadioGroupContext? maybeOf(BuildContext context) {
    final RadioGroupContext? result =
        context.dependOnInheritedWidgetOfExactType<RadioGroupContext>();
    return result;
  }

  void updateGroupValue(dynamic value) {
    updater(value);
  }

  @override
  bool updateShouldNotify(covariant RadioGroupContext oldWidget) {
    return groupValue != oldWidget.groupValue;
  }
}

class DuitRadioGroupContextProvider extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitRadioGroupContextProvider({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<DuitRadioGroupContextProvider> createState() =>
      _DuitRadioGroupContextProviderState();
}

class _DuitRadioGroupContextProviderState
    extends State<DuitRadioGroupContextProvider>
    with
        ViewControllerChangeListener<DuitRadioGroupContextProvider,
            RadioGroupContextAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  void _onChangeHandler(dynamic value) {
    updateStateManually(RadioGroupContextAttributes(
      value: value,
      groupValue: value,
    ));
    widget.controller.performRelatedAction();
  }

  @override
  Widget build(BuildContext context) {
    return RadioGroupContext(
      groupValue: attributes?.groupValue,
      updater: _onChangeHandler,
      child: widget.child,
    );
  }
}
