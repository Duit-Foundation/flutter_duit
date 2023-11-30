import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/controller/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

final class DUITControlledButton extends StatefulWidget {
  final UIElementController controller;
  final Widget? child;

  const DUITControlledButton({
    super.key,
    required this.controller,
    this.child,
  });

  @override
  State<DUITControlledButton> createState() => _DUITControlledButtonState();
}

class _DUITControlledButtonState extends State<DUITControlledButton>
    with ViewControllerChangeListener<DUITControlledButton, ElevatedButtonAttributes> {
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
