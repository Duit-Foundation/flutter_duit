import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/animations/index.dart';

class DuitAnimatedScale extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitAnimatedScale({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitAnimatedScale> createState() => _DuitAnimatedScaleState();
}

class _DuitAnimatedScaleState extends State<DuitAnimatedScale>
    with ViewControllerChangeListener, OnAnimationEnd {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      key: ValueKey(widget.controller.id),
      scale: attributes.getDouble(
        key: "scale",
        defaultValue: 1.0,
      ),
      duration: attributes.duration(),
      alignment: attributes.alignment(defaultValue: Alignment.center)!,
      curve: attributes.curve(defaultValue: Curves.linear)!,
      filterQuality: attributes.filterQuality(),
      onEnd: onEndHandler(
        attributes.getAction("onEnd"),
        widget.controller.performAction,
      ),
      child: widget.child,
    );
  }
}
