import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

final class DuitText extends StatelessWidget {
  final ViewAttribute attributes;

  const DuitText({
    super.key,
    required this.attributes,
  });

  @override
  Widget build(context) {
    final payload = attributes.payload as TextAttributes;
    return Text(
      key: Key(attributes.id),
      payload.data ?? "",
      textAlign: payload.textAlign,
      textDirection: payload.textDirection,
      style: payload.style,
      maxLines: payload.maxLines,
      semanticsLabel: payload.semanticsLabel,
      overflow: payload.overflow,
      softWrap: payload.softWrap,
    );
  }
}

final class DuitControlledText extends StatefulWidget {
  final UIElementController controller;

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
    if (attributes.data == null || attributes.data!.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return Text(
        attributes.data ?? "",
        textAlign: attributes.textAlign,
        textDirection: attributes.textDirection,
        style: attributes.style,
        maxLines: attributes.maxLines,
        semanticsLabel: attributes.semanticsLabel,
        overflow: attributes.overflow,
        softWrap: attributes.softWrap,
      );
    }
  }
}
