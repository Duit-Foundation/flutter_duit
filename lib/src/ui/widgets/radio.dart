import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/animations/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

class DuitRadio extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;

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
    final attrs = mergeWithDataSource(
      context,
      attributes.payload,
    );
    return Radio(
      key: Key(attributes.id),
      value: attrs["value"],
      groupValue: groupContext?.groupValue,
      onChanged: (value) => _onChangeHandler(context, value),
      toggleable: attrs.getBool("toggleable"),
      autofocus: attrs.getBool("autofocus"),
      activeColor: attrs.tryParseColor(key: "activeColor"),
      focusColor: attrs.tryParseColor(key: "focusColor"),
      hoverColor: attrs.tryParseColor(key: "hoverColor"),
      fillColor: attrs.widgetStateProperty<Color>(key: "fillColor"),
      overlayColor: attrs.widgetStateProperty<Color>(key: "overlayColor"),
      splashRadius: attrs.tryGetDouble(key: "splashRadius"),
      materialTapTargetSize: attrs.materialTapTargetSize(),
      visualDensity: attrs.visualDensity(),
    );
  }
}

final class DuitControlledRadio extends StatefulWidget with AnimatedAttributes {
  final UIElementController controller;

  const DuitControlledRadio({
    super.key,
    required this.controller,
  });

  @override
  State<DuitControlledRadio> createState() => _DuitControlledRadioState();
}

class _DuitControlledRadioState extends State<DuitControlledRadio>
    with ViewControllerChangeListener {
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
    final attrs = widget.mergeWithDataSource(
      context,
      attributes,
    );

    return Radio(
      key: Key(widget.controller.id),
      value: attrs["value"],
      groupValue: groupContext?.groupValue,
      onChanged: (value) => _onChangeHandler(value),
      toggleable: attrs.getBool("toggleable"),
      autofocus: attrs.getBool("autofocus"),
      activeColor: attrs.tryParseColor(key: "activeColor"),
      focusColor: attrs.tryParseColor(key: "focusColor"),
      hoverColor: attrs.tryParseColor(key: "hoverColor"),
      fillColor: attrs.widgetStateProperty<Color>(key: "fillColor"),
      overlayColor: attrs.widgetStateProperty<Color>(key: "overlayColor"),
      splashRadius: attrs.tryGetDouble(key: "splashRadius"),
      materialTapTargetSize: attrs.materialTapTargetSize(),
      visualDensity: attrs.visualDensity(),
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
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  void _onChangeHandler(dynamic value) {
    updateStateManually(<String, dynamic>{
      "value": value,
      "groupValue": value,
    });
    widget.controller.performRelatedAction();
  }

  @override
  Widget build(BuildContext context) {
    return RadioGroupContext(
      key: Key(widget.controller.id),
      groupValue: attributes["groupValue"],
      updater: _onChangeHandler,
      child: widget.child,
    );
  }
}
