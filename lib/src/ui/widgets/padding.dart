import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/controller/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

class DUITPadding extends StatelessWidget {
  final Widget? child;
  final ViewAttributeWrapper? attributes;

  const DUITPadding({
    super.key,
    this.child,
    this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes?.payload as PaddingAttributes?;
    return Padding(
      padding: attrs?.padding ?? EdgeInsets.zero,
      child: child,
    );
  }
}

class DUITControlledPadding extends StatefulWidget {
  final UIElementController? controller;
  final Widget? child;

  const DUITControlledPadding({
    super.key,
    this.child,
    this.controller,
  });

  @override
  State<DUITControlledPadding> createState() => _DUITControlledPaddingState();
}

class _DUITControlledPaddingState extends State<DUITControlledPadding>
    with
        ViewControllerChangeListener<DUITControlledPadding, PaddingAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: attributes?.padding ?? EdgeInsets.zero,
      child: widget.child,
    );
  }
}
