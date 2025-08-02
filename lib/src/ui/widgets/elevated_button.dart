import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

final class DuitElevatedButton extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitElevatedButton({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitElevatedButton> createState() => _DuitElevatedButtonState();
}

class _DuitElevatedButtonState extends State<DuitElevatedButton>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  void _onLongPress(ServerAction? action) {
    if (action != null) {
      widget.controller.performAction(action);
    }
  }

  void _performAction() => widget.controller.performRelatedAction();

  @override
  Widget build(BuildContext context) {
    final action = attributes.getAction("onLongPress");
    return ElevatedButton(
      key: Key(widget.controller.id),
      autofocus: attributes.getBool("autofocus"),
      clipBehavior: attributes.clipBehavior(defaultValue: Clip.none)!,
      onPressed: _performAction,
      style: attributes.buttonStyle(),
      onLongPress: () => _onLongPress(action),
      child: widget.child,
    );
  }
}
