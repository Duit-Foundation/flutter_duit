import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/animations/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

final class DuitText extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;

  const DuitText({
    super.key,
    required this.attributes,
  });

  @override
  Widget build(context) {
    final attrs = mergeWithDataSource(
      context,
      attributes.payload,
    );

    final data = attrs.tryGetString("data");

    if (data == null || data.isEmpty) {
      return const SizedBox.shrink();
    }

    return Text(
      key: Key(attributes.id),
      data,
      textAlign: attrs.textAlign(),
      textDirection: attrs.textDirection(),
      style: attrs.textStyle(),
      maxLines: attrs.tryGetInt(key: "maxLines"),
      semanticsLabel: attrs.tryGetString("semanticsLabel"),
      overflow: attrs.textOverflow(),
      softWrap: attrs.tryGetBool("softWrap"),
      textHeightBehavior: attrs.textHeightBehavior(),
      textScaler: attrs.textScaler(),
      textWidthBasis: attrs.textWidthBasis(),
      selectionColor: attrs.tryParseColor(key: "selectionColor"),
    );
  }
}

final class DuitControlledText extends StatefulWidget with AnimatedAttributes {
  final UIElementController controller;

  const DuitControlledText({
    super.key,
    required this.controller,
  });

  @override
  State<DuitControlledText> createState() => _DuitControlledTextState();
}

class _DuitControlledTextState extends State<DuitControlledText>
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

    final data = attrs.tryGetString("data");

    if (data == null || data.isEmpty) {
      return const SizedBox.shrink();
    }

    return Text(
      data,
      textAlign: attrs.textAlign(),
      textDirection: attrs.textDirection(),
      style: attrs.textStyle(),
      maxLines: attrs.tryGetInt(key: "maxLines"),
      semanticsLabel: attrs.tryGetString("semanticsLabel"),
      overflow: attrs.textOverflow(),
      softWrap: attrs.tryGetBool("softWrap"),
      textHeightBehavior: attrs.textHeightBehavior(),
      textScaler: attrs.textScaler(),
      textWidthBasis: attrs.textWidthBasis(),
      selectionColor: attrs.tryParseColor(key: "selectionColor"),
    );
  }
}
