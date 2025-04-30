import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitRichText extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;

  const DuitRichText({
    super.key,
    required this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithDataSource(
      context,
      DuitDataSource(attributes.payload),
    );

    return Text.rich(
      key: Key(attributes.id),
      attrs.textSpan(),
      textAlign: attrs.textAlign(),
      textDirection: attrs.textDirection(),
      softWrap: attrs.tryGetBool("softWrap"),
      overflow: attrs.textOverflow(),
      maxLines: attrs.tryGetInt(key: "maxLines"),
      semanticsLabel: attrs.tryGetString("semanticsLabel"),
      textWidthBasis: attrs.textWidthBasis(),
      textHeightBehavior: attrs.textHeightBehavior(),
      selectionColor: attrs.tryParseColor(key: "selectionColor"),
      strutStyle: attrs.strutStyle(),
      style: attrs.textStyle(),
      textScaler: attrs.textScaler(),
    );
  }
}

class DuitControlledRichText extends StatefulWidget with AnimatedAttributes {
  final UIElementController controller;

  const DuitControlledRichText({
    super.key,
    required this.controller,
  });

  @override
  State<DuitControlledRichText> createState() => _DuitControlledRichTextState();
}

class _DuitControlledRichTextState extends State<DuitControlledRichText>
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

    return Text.rich(
      key: Key(widget.controller.id),
      attrs.textSpan(),
      textAlign: attrs.textAlign(),
      textDirection: attrs.textDirection(),
      softWrap: attrs.tryGetBool("softWrap"),
      overflow: attrs.textOverflow(),
      maxLines: attrs.tryGetInt(key: "maxLines"),
      semanticsLabel: attrs.tryGetString("semanticsLabel"),
      textWidthBasis: attrs.textWidthBasis(),
      textHeightBehavior: attrs.textHeightBehavior(),
      selectionColor: attrs.tryParseColor(key: "selectionColor"),
      strutStyle: attrs.strutStyle(),
      style: attrs.textStyle(),
      textScaler: attrs.textScaler(),
    );
  }
}
