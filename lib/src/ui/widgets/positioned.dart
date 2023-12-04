import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/controller/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

class DUITPositioned extends StatelessWidget {
  final Widget child;
  final ViewAttributeWrapper? attributes;

  const DUITPositioned({
    super.key,
    required this.child,
    this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes?.payload as PositionedAttributes?;
    return Positioned(
      top: attrs?.top,
      left: attrs?.left,
      right: attrs?.right,
      bottom: attrs?.bottom,
      child: child,
    );
  }
}

class DUITControlledPositioned extends StatefulWidget {
  final UIElementController? controller;
  final Widget child;

  const DUITControlledPositioned({
    super.key,
    required this.child,
    this.controller,
  });

  @override
  State<DUITControlledPositioned> createState() =>
      _DUITControlledPositionedState();
}

class _DUITControlledPositionedState extends State<DUITControlledPositioned>
    with
        ViewControllerChangeListener<DUITControlledPositioned,
            PositionedAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: attributes?.top,
      left: attributes?.left,
      right: attributes?.right,
      bottom: attributes?.bottom,
      child: widget.child,
    );
  }
}
