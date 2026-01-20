import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitFractionalTranslation extends StatelessWidget
    with AnimatedAttributes {
  final ViewAttribute attributes;
  final Widget child;

  const DuitFractionalTranslation({
    required this.attributes,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithDataSource(
      context,
      attributes.payload,
    );
    return FractionalTranslation(
      key: Key(attributes.id),
      translation: attrs.offset(
        key: "translation",
        defaultValue: Offset.zero,
      )!,
      transformHitTests: attrs.getBool(
        "transformHitTests",
        defaultValue: true,
      ),
      child: child,
    );
  }
}

class DuitControlledFractionalTranslation extends StatefulWidget
    with AnimatedAttributes {
  final UIElementController controller;
  final Widget child;

  const DuitControlledFractionalTranslation({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  State<DuitControlledFractionalTranslation> createState() =>
      _DuitControlledFractionalTranslationState();
}

class _DuitControlledFractionalTranslationState
    extends State<DuitControlledFractionalTranslation>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.mergeWithDataSource(
      context,
      attributes,
    );
    return FractionalTranslation(
      key: Key(widget.controller.id),
      translation: attrs.offset(
        key: "translation",
        defaultValue: Offset.zero,
      )!,
      transformHitTests: attrs.getBool(
        "transformHitTests",
        defaultValue: true,
      ),
      child: widget.child,
    );
  }
}
