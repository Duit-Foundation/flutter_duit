import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/controller/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

class DUITDecoratedBox extends StatelessWidget {
  final ViewAttributeWrapper? attributes;
  final Widget child;

  const DUITDecoratedBox({
    super.key,
    this.attributes,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes?.payload as DecoratedBoxAttributes?;
    return DecoratedBox(
      decoration: attrs?.decoration ?? const BoxDecoration(),
      child: child,
    );
  }
}

class DUITControlledDecoratedBox extends StatefulWidget {
  final UIElementController? controller;
  final Widget child;

  const DUITControlledDecoratedBox({
    super.key,
    this.controller,
    required this.child,
  });

  @override
  State<DUITControlledDecoratedBox> createState() =>
      _DUITControlledDecoratedBoxState();
}

class _DUITControlledDecoratedBoxState extends State<DUITControlledDecoratedBox>
    with
        ViewControllerChangeListener<DUITControlledDecoratedBox,
            DecoratedBoxAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: attributes?.decoration ?? const BoxDecoration(),
      child: widget.child,
    );
  }
}
