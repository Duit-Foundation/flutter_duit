import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/animation_attributes/animated_size_attributes.dart";

class DuitAnimatedSize extends StatefulWidget {
  final Widget child;
  final UIElementController<AnimatedSizeAttributes> controller;

  const DuitAnimatedSize({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<DuitAnimatedSize> createState() => _DuitAnimatedSizeState();
}

class _DuitAnimatedSizeState extends State<DuitAnimatedSize>
    with
        ViewControllerChangeListener<DuitAnimatedSize, AnimatedSizeAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: attributes.duration,
      clipBehavior: attributes.clipBehavior ?? Clip.hardEdge,
      alignment: attributes.alignment ?? Alignment.center,
      curve: attributes.curve,
      reverseDuration: attributes.reverseDuration,
      child: widget.child,
    );
  }
}
