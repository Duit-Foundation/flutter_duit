import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/animations/index.dart";
import "package:flutter_duit/src/attributes/index.dart";

class DuitRichText extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute<RichTextAttributes> attributes;

  const DuitRichText({
    super.key,
    required this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithAttributes(
      context,
      attributes.payload,
    );

    assert(attrs.textSpan != null, "TextSpan cannot be null");
    return Text.rich(
      key: Key(attributes.id),
      attrs.textSpan!,
      textAlign: attrs.textAlign,
      textDirection: attrs.textDirection,
      softWrap: attrs.softWrap,
      overflow: attrs.overflow,
      maxLines: attrs.maxLines,
      semanticsLabel: attrs.semanticsLabel,
      textWidthBasis: attrs.textWidthBasis,
      textHeightBehavior: attrs.textHeightBehavior,
      selectionColor: attrs.selectionColor,
      strutStyle: attrs.strutStyle,
      style: attrs.style,
      textScaler: attrs.textScaler,
    );
  }
}

class DuitControlledRichText extends StatefulWidget with AnimatedAttributes {
  final UIElementController<RichTextAttributes> controller;

  const DuitControlledRichText({
    super.key,
    required this.controller,
  });

  @override
  State<DuitControlledRichText> createState() => _DuitControlledRichTextState();
}

class _DuitControlledRichTextState extends State<DuitControlledRichText>
    with
        ViewControllerChangeListener<DuitControlledRichText,
            RichTextAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.mergeWithController(
      context,
      widget.controller,
    );

    assert(attrs.textSpan != null, "TextSpan cannot be null");
    return Text.rich(
      key: Key(widget.controller.id),
      attrs.textSpan!,
      textAlign: attrs.textAlign,
      textDirection: attrs.textDirection,
      softWrap: attrs.softWrap,
      overflow: attrs.overflow,
      maxLines: attrs.maxLines,
      semanticsLabel: attrs.semanticsLabel,
      textWidthBasis: attrs.textWidthBasis,
      textHeightBehavior: attrs.textHeightBehavior,
      selectionColor: attrs.selectionColor,
      strutStyle: attrs.strutStyle,
      style: attrs.style,
      textScaler: attrs.textScaler,
    );
  }
}
