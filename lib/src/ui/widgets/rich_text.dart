import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";

class DuitRichText extends StatelessWidget {
  final ViewAttributeWrapper? attributes;

  const DuitRichText({
    super.key,
    required this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes?.payload as RichTextAttributes?;
    assert(attrs?.textSpan != null, "TextSpan cannot be null");
    return Text.rich(
      attrs!.textSpan!,
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

class DuitControlledRichText extends StatefulWidget {
  final UIElementController? controller;

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
    assert(attributes?.textSpan != null, "TextSpan cannot be null");
    return Text.rich(
      attributes!.textSpan!,
      textAlign: attributes?.textAlign,
      textDirection: attributes?.textDirection,
      softWrap: attributes?.softWrap,
      overflow: attributes?.overflow,
      maxLines: attributes?.maxLines,
      semanticsLabel: attributes?.semanticsLabel,
      textWidthBasis: attributes?.textWidthBasis,
      textHeightBehavior: attributes?.textHeightBehavior,
      selectionColor: attributes?.selectionColor,
      strutStyle: attributes?.strutStyle,
      style: attributes?.style,
      textScaler: attributes?.textScaler,
    );
  }
}
