import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/animations/index.dart';

class DuitAnimatedContainer extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitAnimatedContainer({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitAnimatedContainer> createState() => _DuitAnimatedContainerState();
}

class _DuitAnimatedContainerState extends State<DuitAnimatedContainer>
    with ViewControllerChangeListener, OnAnimationEnd {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      key: ValueKey(widget.controller.id),
      duration: attributes.duration(),
      curve: attributes.curve(defaultValue: Curves.linear)!,
      onEnd: onEndHandler(
        attributes.getAction("onEnd"),
        widget.controller.performAction,
      ),
      width: attributes.tryGetDouble(key: "width"),
      height: attributes.tryGetDouble(key: "height"),
      color: attributes.tryParseColor(key: "color"),
      foregroundDecoration: attributes.decoration(key: "foregroundDecoration"),
      decoration: attributes.decoration(),
      clipBehavior: attributes.clipBehavior(defaultValue: Clip.none)!,
      constraints: attributes.boxConstraints(),
      padding: attributes.edgeInsets(),
      margin: attributes.edgeInsets(key: "margin"),
      alignment: attributes.alignment(defaultValue: Alignment.center)!,
      transformAlignment: attributes.alignment(key: "transformAlignment"),
      child: widget.child,
    );
  }
}
