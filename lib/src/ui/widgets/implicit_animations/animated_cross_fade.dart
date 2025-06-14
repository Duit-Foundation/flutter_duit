import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/index.dart';

class DuitAnimatedCrossFade extends StatefulWidget {
  final UIElementController<AnimatedCrossFadeAttributes> controller;
  final List<Widget> children;

  const DuitAnimatedCrossFade({
    super.key,
    required this.controller,
    required this.children,
  });

  @override
  State<DuitAnimatedCrossFade> createState() =>
      _DuitAnimatedCrossFadeState();
}

class _DuitAnimatedCrossFadeState
    extends State<DuitAnimatedCrossFade>
    with
        ViewControllerChangeListener<DuitAnimatedCrossFade,
            AnimatedCrossFadeAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      key: ValueKey(widget.controller.id),
      firstChild: widget.children[0],
      secondChild: widget.children[1],
      crossFadeState: attributes.crossFadeState == 0
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: attributes.duration,
      firstCurve: attributes.firstCurve,
      secondCurve: attributes.secondCurve,
      alignment: attributes.alignment,
      sizeCurve: attributes.sizeCurve,
      excludeBottomFocus: attributes.excludeBottomFocus,
    );
  }
}
