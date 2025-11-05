import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/utils/index.dart";

class DuitMetaWidget extends StatefulWidget {
  final Widget child;
  final UIElementController controller;

  const DuitMetaWidget({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<DuitMetaWidget> createState() => _DuitMetaWidgetState();
}

class _DuitMetaWidgetState extends State<DuitMetaWidget>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DuitMetaData(
      key: Key(widget.controller.id),
      value: Map<String, dynamic>.from(attributes["value"]),
      child: widget.child,
    );
  }
}
