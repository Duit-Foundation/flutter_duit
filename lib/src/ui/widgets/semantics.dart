import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitSemantics extends StatelessWidget {
  final ViewAttribute attributes;
  final Widget child;

  const DuitSemantics({
    required this.attributes,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    return Semantics(
      key: Key(attributes.id),
      label: attrs.tryGetString("label"),
      hint: attrs.tryGetString("hint"),
      value: attrs.tryGetString("value"),
      tooltip: attrs.tryGetString("tooltip"),
      enabled: attrs.tryGetBool("enabled"),
      checked: attrs.tryGetBool("checked"),
      selected: attrs.tryGetBool("selected"),
      button: attrs.tryGetBool("button"),
      link: attrs.tryGetBool("link"),
      header: attrs.tryGetBool("header"),
      textField: attrs.tryGetBool("textField"),
      image: attrs.tryGetBool("image"),
      liveRegion: attrs.tryGetBool("liveRegion"),
      container: attrs.getBool("container"),
      explicitChildNodes: attrs.getBool("explicitChildNodes"),
      excludeSemantics: attrs.getBool("excludeSemantics"),
      blockUserActions: attrs.getBool("blockUserActions"),
      child: child,
    );
  }
}

class DuitControlledSemantics extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitControlledSemantics({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  State<DuitControlledSemantics> createState() =>
      _DuitControlledSemanticsState();
}

class _DuitControlledSemanticsState extends State<DuitControlledSemantics>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      key: Key(widget.controller.id),
      label: attributes.tryGetString("label"),
      hint: attributes.tryGetString("hint"),
      value: attributes.tryGetString("value"),
      tooltip: attributes.tryGetString("tooltip"),
      enabled: attributes.tryGetBool("enabled"),
      checked: attributes.tryGetBool("checked"),
      selected: attributes.tryGetBool("selected"),
      button: attributes.tryGetBool("button"),
      link: attributes.tryGetBool("link"),
      header: attributes.tryGetBool("header"),
      textField: attributes.tryGetBool("textField"),
      image: attributes.tryGetBool("image"),
      liveRegion: attributes.tryGetBool("liveRegion"),
      container: attributes.getBool("container"),
      explicitChildNodes: attributes.getBool("explicitChildNodes"),
      excludeSemantics: attributes.getBool("excludeSemantics"),
      blockUserActions: attributes.getBool("blockUserActions"),
      child: widget.child,
    );
  }
}
