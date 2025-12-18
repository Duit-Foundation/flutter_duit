import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/animations/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";
import "package:flutter_duit/src/ui/widgets/focus_node_helper.dart";

class DuitRadio extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;

  const DuitRadio({
    required this.attributes,
    super.key,
  });

  void _onChangeHandler(BuildContext context, value) {
    RadioGroupContext.maybeOf(context)?.updateGroupValue(value);
  }

  @override
  Widget build(BuildContext context) {
    final groupContext = RadioGroupContext.maybeOf(context);
    assert(groupContext != null, "RadioGroupContext not found in context");
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
    required this.controller,
    super.key,
  });

  @override
  State<DuitControlledRadio> createState() => _DuitControlledRadioState();
}

class _DuitControlledRadioState extends State<DuitControlledRadio>
    with ViewControllerChangeListener, FocusNodeCommandHandler {
  @override
  void initState() {
    controller = widget.controller;
    attachStateToController(widget.controller);

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

  void _onChangeHandler(value) {
    RadioGroupContext.maybeOf(context)?.updateGroupValue(value);
  }

  @override
  Widget build(BuildContext context) {
    final groupContext = RadioGroupContext.maybeOf(context);
    assert(groupContext != null, "RadioGroupContext not found in context");
    final attrs = widget.mergeWithDataSource(
      context,
      attributes,
    );

    return Radio(
      key: Key(widget.controller.id),
      value: attrs["value"],
      focusNode: focusNode,
      groupValue: groupContext?.groupValue,
      onChanged: _onChangeHandler,
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
  // ignore: avoid_annotating_with_dynamic
  final Function(dynamic value) updater;

  const RadioGroupContext({
    required super.child,
    required this.groupValue,
    required this.updater,
    super.key,
  });

  static RadioGroupContext? maybeOf(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<RadioGroupContext>();
    return result;
  }

  void updateGroupValue(value) {
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
    required this.child,
    required this.controller,
    super.key,
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

  void _onChangeHandler(value) {
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
