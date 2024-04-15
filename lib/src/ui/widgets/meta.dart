import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";
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
    with ViewControllerChangeListener<DuitMetaWidget, MetaAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DuitMetaData(
      value: attributes?.value ?? {},
      child: widget.child,
    );
  }
}
