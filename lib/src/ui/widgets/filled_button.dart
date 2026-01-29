import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

final class DuitFilledButton extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitFilledButton({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  State<DuitFilledButton> createState() => _DuitFilledButtonState();
}

class _DuitFilledButtonState extends State<DuitFilledButton>
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

  void _onLongPress() {
    final action = attributes.getAction("onLongPress");
    if (action != null) {
      widget.controller.performAction(action);
    }
  }

  void _onFocusChange(bool _) {
    final action = attributes.getAction("onFocusChange");
    if (action != null) {
      widget.controller.performAction(action);
    }
  }

  void _onHover(bool _) {
    final action = attributes.getAction("onHover");
    if (action != null) {
      widget.controller.performAction(action);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      key: ValueKey(widget.controller.id),
      focusNode: _focusNode,
      autofocus: attributes.getBool("autofocus"),
      clipBehavior: attributes.clipBehavior(),
      onPressed: widget.controller.performRelatedAction,
      style: attributes.buttonStyle(),
      onLongPress: _onLongPress,
      onFocusChange: _onFocusChange,
      onHover: _onHover,
      child: widget.child,
    );
  }
}
