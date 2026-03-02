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
      message: attrs.tryGetString("message"),
      richMessage: attrs.tryParseIfNotNull<TextSpan>(
        key: "richMessage",
        defaultValue: null,
        converter: attrs.textSpan,
      ),
      padding: attrs.edgeInsets(key: "padding"),
      margin: attrs.edgeInsets(key: "margin"),
      height: attrs.tryGetDouble(key: "height"),
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
      enableFeedback: attrs.tryGetBool("enableFeedback"),
      triggerMode: attrs.tooltipTriggerMode(key: "triggerMode"),
      //TODO: implement this props when migrate to Flutter version 3.30+

      // ignorePointer: attrs.tryGetBool("ignorePointer"),
      // constraints: attrs.boxConstraints(key: "constraints"),
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
      message: attributes.tryGetString("message"),
      richMessage: attributes.tryParseIfNotNull<TextSpan>(
        key: "richMessage",
        converter: attributes.textSpan,
        defaultValue: null,
      ),
      padding: attributes.edgeInsets(key: "padding"),
      margin: attributes.edgeInsets(key: "margin"),
      height: attributes.getDouble(key: "height"),
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
      enableFeedback: attributes.tryGetBool("enableFeedback"),
      triggerMode: attributes.tooltipTriggerMode(key: "triggerMode"),
      //TODO: implement this props when migrate to Flutter version 3.30+

      // constraints: attributes.boxConstraints(key: "constraints"),
      // ignorePointer: attributes.tryGetBool("ignorePointer"),
      child: widget.child,
    );
  }
}
