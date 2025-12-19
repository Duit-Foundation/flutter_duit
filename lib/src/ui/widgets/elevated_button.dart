import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

final class DuitElevatedButton extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitElevatedButton({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  State<DuitElevatedButton> createState() => _DuitElevatedButtonState();
}

class _DuitElevatedButtonState extends State<DuitElevatedButton>
    with ViewControllerChangeListener {
  late final FocusNode _focusNode;

  @override
  void initState() {
    final controller = widget.controller;
    attachStateToController(controller);

    _focusNode = attributes.focusNode(
      defaultValue: FocusNode(),
    )!;

    controller.driver.attachFocusNode(
      widget.controller.id,
      _focusNode,
    );

    super.initState();
  }

  @override
  void dispose() {
    widget.controller.driver.detachFocusNode(widget.controller.id);
    super.dispose();
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
      focusNode: _focusNode,
      autofocus: attributes.getBool("autofocus"),
      clipBehavior: attributes.clipBehavior(defaultValue: Clip.none)!,
      onPressed: _performAction,
      style: attributes.buttonStyle(),
      onLongPress: () => _onLongPress(action),
      child: widget.child,
    );
  }
}
