import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/animations/index.dart';
import 'package:flutter_duit/src/attributes/index.dart';

class DuitAnimatedContainer extends StatefulWidget {
  final UIElementController<AnimatedContainerAttributes> controller;
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
    with
        ViewControllerChangeListener<DuitAnimatedContainer,
            AnimatedContainerAttributes>,
        OnAnimationEnd {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      key: ValueKey(widget.controller.id),
      duration: attributes.duration,
      curve: attributes.curve,
      onEnd: onEndHandler(
        attributes.onEnd,
        widget.controller.performAction,
      ),
      width: attributes.width,
      height: attributes.height,
      color: attributes.color,
      foregroundDecoration: attributes.foregroundDecoration,
      decoration: attributes.decoration,
      clipBehavior: attributes.clipBehavior,
      constraints: attributes.constraints,
      padding: attributes.padding,
      margin: attributes.margin,
      alignment: attributes.alignment,
      transformAlignment: attributes.transformAlignment,
    );
  }
}
