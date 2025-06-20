import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/animations/index.dart';
import 'package:flutter_duit/src/attributes/index.dart';

class DuitAnimatedSlide extends StatefulWidget {
  final UIElementController<AnimatedSlideAttributes> controller;
  final Widget child;

  const DuitAnimatedSlide({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitAnimatedSlide> createState() => _DuitAnimatedSlideState();
}

class _DuitAnimatedSlideState extends State<DuitAnimatedSlide>
    with
        ViewControllerChangeListener<DuitAnimatedSlide,
            AnimatedSlideAttributes>,
        OnAnimationEnd {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      key: ValueKey(widget.controller.id),
      offset: attributes.offset,
      duration: attributes.duration,
      curve: attributes.curve,
      onEnd: onEndHandler(
        attributes.onEnd,
        widget.controller.performAction,
      ),
      child: widget.child,
    );
  }
}
