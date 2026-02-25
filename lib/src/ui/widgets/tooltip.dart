import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitTooltip extends StatelessWidget {
  final ViewAttribute attributes;
  final Widget child;

  const DuitTooltip({
    required this.attributes,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    return Tooltip(
      key: ValueKey(attributes.id),
      message: attrs.getString(key: "message"),
      richMessage: attrs.textSpan(key: "richMessage"),
      padding: attrs.edgeInsets(key: "padding"),
      margin: attrs.edgeInsets(key: "margin"),
      verticalOffset: attrs.getDouble(
        key: "verticalOffset",
        defaultValue: 24.0,
      ),
      preferBelow: attrs.getBool(
        "preferBelow",
        defaultValue: true,
      ),
      excludeFromSemantics: attrs.getBool("excludeFromSemantics"),
      decoration: attrs.decoration(key: "decoration"),
      textStyle: attrs.textStyle(key: "textStyle"),
      textAlign: attrs.textAlign(key: "textAlign"),
      waitDuration: attrs.duration(key: "waitDuration"),
      showDuration: attrs.duration(key: "showDuration"),
      exitDuration: attrs.duration(key: "exitDuration"),
      enableTapToDismiss: attrs.getBool(
        "enableTapToDismiss",
        defaultValue: true,
      ),
      triggerMode: attrs.tooltipTriggerMode(key: "triggerMode"),
      child: child,
    );
  }
}

class DuitControlledTooltip extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitControlledTooltip({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  State<DuitControlledTooltip> createState() => _DuitControlledTooltipState();
}

class _DuitControlledTooltipState extends State<DuitControlledTooltip>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      key: ValueKey(widget.controller.id),
      message: attributes.getString(key: "message"),
      richMessage: attributes.textSpan(key: "richMessage"),
      padding: attributes.edgeInsets(key: "padding"),
      margin: attributes.edgeInsets(key: "margin"),
      verticalOffset: attributes.getDouble(
        key: "verticalOffset",
        defaultValue: 24.0,
      ),
      preferBelow: attributes.getBool(
        "preferBelow",
        defaultValue: true,
      ),
      excludeFromSemantics: attributes.getBool("excludeFromSemantics"),
      decoration: attributes.decoration(key: "decoration"),
      textStyle: attributes.textStyle(key: "textStyle"),
      textAlign: attributes.textAlign(key: "textAlign"),
      waitDuration: attributes.duration(key: "waitDuration"),
      showDuration: attributes.duration(key: "showDuration"),
      exitDuration: attributes.duration(key: "exitDuration"),
      enableTapToDismiss: attributes.getBool(
        "enableTapToDismiss",
        defaultValue: true,
      ),
      triggerMode: attributes.tooltipTriggerMode(key: "triggerMode"),
      child: widget.child,
    );
  }
}
