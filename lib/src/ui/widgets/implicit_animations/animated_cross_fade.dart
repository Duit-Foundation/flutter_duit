import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitAnimatedCrossFade extends StatefulWidget {
  final UIElementController controller;
  final List<Widget> children;

  const DuitAnimatedCrossFade({
    required this.controller,
    required this.children,
    super.key,
  });

  @override
  State<DuitAnimatedCrossFade> createState() => _DuitAnimatedCrossFadeState();
}

class _DuitAnimatedCrossFadeState extends State<DuitAnimatedCrossFade>
    with ViewControllerChangeListener {
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
      crossFadeState: attributes.getInt(key: "crossFadeState") == 0
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: attributes.duration(),
      firstCurve: attributes.curve(defaultValue: Curves.linear)!,
      secondCurve: attributes.curve(defaultValue: Curves.linear)!,
      alignment: attributes.alignment(defaultValue: Alignment.topCenter)!,
      sizeCurve: attributes.curve(defaultValue: Curves.linear)!,
      excludeBottomFocus: attributes.getBool(
        "excludeBottomFocus",
        defaultValue: true,
      ),
    );
  }
}
