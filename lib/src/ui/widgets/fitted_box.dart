import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";

final class DuitFittedBox extends StatelessWidget {
  final ViewAttribute<FittedBoxAttributes> attributes;
  final Widget child;

  const DuitFittedBox({
    super.key,
    required this.child,
    required this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    return FittedBox(
      key: Key(attributes.id),
      fit: attrs.fit ?? BoxFit.contain,
      clipBehavior: attrs.clipBehavior ?? Clip.none,
      alignment: attrs.alignment ?? Alignment.center,
      child: child,
    );
  }
}

class DuitControlledFittedBox extends StatefulWidget {
  final UIElementController<FittedBoxAttributes> controller;
  final Widget child;

  const DuitControlledFittedBox({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<DuitControlledFittedBox> createState() =>
      _DuitControlledFittedBoxState();
}

class _DuitControlledFittedBoxState extends State<DuitControlledFittedBox>
    with
        ViewControllerChangeListener<DuitControlledFittedBox,
            FittedBoxAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      key: Key(widget.controller.id),
      fit: attributes.fit ?? BoxFit.contain,
      clipBehavior: attributes.clipBehavior ?? Clip.none,
      alignment: attributes.alignment ?? Alignment.center,
      child: widget.child,
    );
  }
}
