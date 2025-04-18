import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/animations/index.dart';
import 'package:flutter_duit/src/attributes/index.dart';

class DuitAnimatedPadding extends StatefulWidget {
  final UIElementController<AnimatedPaddingAttributes> controller;
  final Widget child;

  const DuitAnimatedPadding({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitAnimatedPadding> createState() => _DuitAnimatedPaddingState();
}

class _DuitAnimatedPaddingState extends State<DuitAnimatedPadding>
    with
        ViewControllerChangeListener<DuitAnimatedPadding,
            AnimatedPaddingAttributes>,
        OnAnimationEnd {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      key: ValueKey(widget.controller.id),
      padding: attributes.padding,
      duration: attributes.duration,
      curve: attributes.curve,
      onEnd: onEndHandler(widget.controller),
      child: widget.child,
    );
  }
}
