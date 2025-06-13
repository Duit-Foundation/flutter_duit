import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/animations/index.dart';
import 'package:flutter_duit/src/attributes/slivers/index.dart';

class DuitSliverAnimatedOpacity extends StatefulWidget {
  final UIElementController<SliverAnimatedOpacityAttributes> controller;
  final Widget child;

  const DuitSliverAnimatedOpacity({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitSliverAnimatedOpacity> createState() =>
      _DuitSliverAnimatedOpacityState();
}

class _DuitSliverAnimatedOpacityState extends State<DuitSliverAnimatedOpacity>
    with
        ViewControllerChangeListener<DuitSliverAnimatedOpacity,
            SliverAnimatedOpacityAttributes>,
        OnAnimationEnd {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAnimatedOpacity(
      key: ValueKey(widget.controller.id),
      opacity: attributes.opacity,
      duration: attributes.duration,
      curve: attributes.curve,
      onEnd: onEndHandler(
        attributes.onEnd,
        widget.controller.performAction,
      ),
      sliver: attributes.needsBoxAdapter
          ? SliverToBoxAdapter(child: widget.child)
          : widget.child,
    );
  }
}
