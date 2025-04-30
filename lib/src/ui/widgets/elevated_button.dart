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

  @override
  Widget build(BuildContext context) {
    final onLongPress = attributes.getAction("onLongPress");
    return ElevatedButton(
      key: Key(widget.controller.id),
      autofocus: attributes.getBool(
        "autofocus",
        defaultValue: false,
      ),
      clipBehavior: attributes.clipBehavior(),
      onPressed: widget.controller.performRelatedAction,
      style: attributes.buttonStyle(),
      onLongPress: onLongPress != null
          ? () => _onLongPress(
                onLongPress,
              )
          : null,
      child: widget.child,
    );
  }
}
