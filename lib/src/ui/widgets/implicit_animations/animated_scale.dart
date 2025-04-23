import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/animations/index.dart';
import 'package:flutter_duit/src/attributes/index.dart';

class DuitAnimatedScale extends StatefulWidget {
  final UIElementController<AnimatedScaleAttributes> controller;
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
    with
        ViewControllerChangeListener<DuitAnimatedScale,
            AnimatedScaleAttributes>,
        OnAnimationEnd {

  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      key: ValueKey(widget.controller.id),
      scale: attributes.scale,
      duration: attributes.duration,
      alignment: attributes.alignment,
      curve: attributes.curve,
      filterQuality: attributes.filterQuality,
      onEnd: onEndHandler(widget.controller),
      child: widget.child,
    );
  }
}
