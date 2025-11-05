import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/animations/index.dart';

class DuitAnimatedAlign extends StatefulWidget {
  final UIElementController controller;
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
    with ViewControllerChangeListener, OnAnimationEnd {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      key: ValueKey(widget.controller.id),
      alignment: attributes.alignment(defaultValue: Alignment.center)!,
      widthFactor: attributes.tryGetDouble(key: "widthFactor"),
      heightFactor: attributes.tryGetDouble(key: "heightFactor"),
      duration: attributes.duration(),
      curve: attributes.curve(defaultValue: Curves.linear)!,
      onEnd: onEndHandler(
        attributes.getAction("onEnd"),
        widget.controller.performAction,
      ),
      child: widget.child,
    );
  }
}
