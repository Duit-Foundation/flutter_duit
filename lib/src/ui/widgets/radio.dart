import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/animations/index.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

class DuitRadio extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute<RadioAttributes> attributes;

  const DuitRadio({
    super.key,
    required this.attributes,
  });

  void _onChangeHandler(BuildContext context, dynamic value) {
    RadioGroupContext.maybeOf(context)?.updateGroupValue(value);
  }

  @override
  Widget build(BuildContext context) {
    final groupContext = RadioGroupContext.maybeOf(context);
    assert(groupContext != null, 'RadioGroupContext not found in context');
    final attrs = mergeWithAttributes(
      context,
      attributes.payload,
    );
    return Radio(
      key: Key(attributes.id),
      value: attrs.value,
      groupValue: groupContext?.groupValue,
      onChanged: (value) => _onChangeHandler(context, value),
      toggleable: attrs.toggleable ?? false,
      autofocus: attrs.autofocus ?? false,
      activeColor: attrs.activeColor,
      focusColor: attrs.focusColor,
      hoverColor: attrs.hoverColor,
      fillColor: attrs.fillColor,
      overlayColor: attrs.overlayColor,
      splashRadius: attrs.splashRadius,
      materialTapTargetSize: attrs.materialTapTargetSize,
      visualDensity: attrs.visualDensity,
    );
  }
}

final class DuitControlledRadio extends StatefulWidget with AnimatedAttributes {
  final UIElementController<RadioAttributes> controller;

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
    assert(groupContext != null, 'RadioGroupContext not found in context');
    final attrs = widget.mergeWithController(
      context,
      widget.controller,
    );

    return Radio(
      key: Key(widget.controller.id),
      value: attrs.value,
      groupValue: groupContext?.groupValue,
      onChanged: _onChangeHandler,
      toggleable: attrs.toggleable ?? false,
      autofocus: attrs.autofocus ?? false,
      activeColor: attrs.activeColor,
      focusColor: attrs.focusColor,
      hoverColor: attrs.hoverColor,
      fillColor: attrs.fillColor,
      overlayColor: attrs.overlayColor,
      splashRadius: attrs.splashRadius,
      materialTapTargetSize: attrs.materialTapTargetSize,
      visualDensity: attrs.visualDensity,
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
  final UIElementController<RadioGroupContextAttributes> controller;
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
    updateStateManually(
      RadioGroupContextAttributes(
        value: value,
        groupValue: value,
      ),
      widgetId: widget.controller.id,
    );
    widget.controller.performRelatedAction();
  }

  @override
  Widget build(BuildContext context) {
    return RadioGroupContext(
      key: Key(widget.controller.id),
      groupValue: attributes.groupValue,
      updater: _onChangeHandler,
      child: widget.child,
    );
  }
}
