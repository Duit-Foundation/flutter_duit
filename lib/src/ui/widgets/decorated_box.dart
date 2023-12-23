import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";
import "package:flutter_duit/src/duit_kernel/index.dart";

class DuitDecoratedBox extends StatelessWidget {
  final ViewAttributeWrapper? attributes;
  final Widget child;

  const DuitDecoratedBox({
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

class DuitControlledDecoratedBox extends StatefulWidget {
  final UIElementController? controller;
  final Widget child;

  const DuitControlledDecoratedBox({
    super.key,
    this.controller,
    required this.child,
  });

  @override
  State<DuitControlledDecoratedBox> createState() =>
      _DuitControlledDecoratedBoxState();
}

class _DuitControlledDecoratedBoxState extends State<DuitControlledDecoratedBox>
    with
        ViewControllerChangeListener<DuitControlledDecoratedBox,
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
