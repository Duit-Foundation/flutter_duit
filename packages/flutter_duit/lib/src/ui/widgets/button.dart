import "package:flutter/material.dart";
import "package:flutter_duit/src/controller/index.dart";

final class DUITButton extends StatefulWidget {
  final UIElementController controller;
  final Widget? child;

  const DUITButton({
    super.key,
    required this.controller,
    this.child,
  });

  @override
  State<DUITButton> createState() => _DUITButtonState();
}

class _DUITButtonState extends State<DUITButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.controller.performRelatedAction,
      child: widget.child,
    );
  }
}