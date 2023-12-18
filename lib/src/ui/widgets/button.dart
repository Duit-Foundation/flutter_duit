import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/controller/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

final class DuitElevatedButton extends StatefulWidget {
  final UIElementController controller;
  final Widget? child;

  const DuitElevatedButton({
    super.key,
    required this.controller,
    this.child,
  });

  @override
  State<DuitElevatedButton> createState() => _DuitElevatedButtonState();
}

class _DuitElevatedButtonState extends State<DuitElevatedButton>
    with ViewControllerChangeListener<DuitElevatedButton, ElevatedButtonAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      autofocus: attributes?.autofocus ?? false,
      clipBehavior: attributes?.clipBehavior ?? Clip.none,
      onPressed: widget.controller.performRelatedAction,
      child: widget.child,
    );
  }
}
