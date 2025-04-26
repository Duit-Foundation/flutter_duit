import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/animations/index.dart';
import 'package:flutter_duit/src/attributes/index.dart';

class DuitAnimatedAlign extends StatefulWidget {
  final UIElementController<AnimatedAlignAttributes> controller;
  final Widget child;

  const DuitAnimatedAlign({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitAnimatedAlign> createState() => _DuitAnimatedAlignState();
}

class _DuitAnimatedAlignState extends State<DuitAnimatedAlign>
    with
        ViewControllerChangeListener<DuitAnimatedAlign,
            AnimatedAlignAttributes>,
        OnAnimationEnd {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      key: ValueKey(widget.controller.id),
      alignment: attributes.alignment,
      widthFactor: attributes.widthFactor,
      heightFactor: attributes.heightFactor,
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
