import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/animations/index.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

final class DuitText extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute<TextAttributes> attributes;

  const DuitText({
    super.key,
    required this.attributes,
  });

  @override
  Widget build(context) {
    final attrs = mergeWithAttributes(
      context,
      attributes.payload,
    );

    if (attributes.payload.data == null || attributes.payload.data!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Text(
      key: Key(attributes.id),
      attrs.data ?? "",
      textAlign: attrs.textAlign,
      textDirection: attrs.textDirection,
      style: attrs.style,
      maxLines: attrs.maxLines,
      semanticsLabel: attrs.semanticsLabel,
      overflow: attrs.overflow,
      softWrap: attrs.softWrap,
    );
  }
}

final class DuitControlledText extends StatefulWidget with AnimatedAttributes {
  final UIElementController<TextAttributes> controller;

  const DuitControlledText({
    super.key,
    required this.controller,
  });

  @override
  State<DuitControlledText> createState() => _DuitControlledTextState();
}

class _DuitControlledTextState extends State<DuitControlledText>
    with ViewControllerChangeListener<DuitControlledText, TextAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.mergeWithAttributes(
      context,
      attributes,
    );

    if (attrs.data == null || attrs.data!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Text(
      attrs.data!,
      textAlign: attrs.textAlign,
      textDirection: attrs.textDirection,
      style: attrs.style,
      maxLines: attrs.maxLines,
      semanticsLabel: attrs.semanticsLabel,
      overflow: attrs.overflow,
      softWrap: attrs.softWrap,
    );
  }
}
