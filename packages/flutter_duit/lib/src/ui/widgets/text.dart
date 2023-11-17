import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/controller/index.dart";

final class DUITText extends StatelessWidget {
  final ViewAttributeWrapper? attributes;

  const DUITText({
    super.key,
    required this.attributes,
  });

  @override
  Widget build(context) {
    final payload = attributes?.payload as TextAttributes?;
    return Text(
      payload?.data ?? "",
      textAlign: payload?.textAlign,
      textDirection: payload?.textDirection,
      style: payload?.style,
      maxLines: payload?.maxLines,
      semanticsLabel: payload?.semanticsLabel,
      textScaleFactor: payload?.textScaleFactor,
      overflow: payload?.overflow,
      softWrap: payload?.softWrap,
    );
  }
}

final class DUITControlledText<TextAttributes> extends StatefulWidget {
  final UIElementController<TextAttributes>? controller;

  const DUITControlledText({
    super.key,
    required this.controller,
  });

  @override
  State<DUITControlledText> createState() => _DUITControlledTextState();
}

class _DUITControlledTextState extends State<DUITControlledText> {
  late TextAttributes? attributes;

  @override
  void initState() {
    attributes = widget.controller?.attributes?.payload as TextAttributes?;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    widget.controller?.addListener(() {
      final newState = widget.controller?.attributes?.payload as TextAttributes?;

      if (newState != null) {
        setState(() {
          attributes = attributes?.copyWith(newState);
        });
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      attributes?.data ?? "",
      textAlign: attributes?.textAlign,
      textDirection: attributes?.textDirection,
      style: attributes?.style,
      maxLines: attributes?.maxLines,
      semanticsLabel: attributes?.semanticsLabel,
      textScaleFactor: attributes?.textScaleFactor,
      overflow: attributes?.overflow,
      softWrap: attributes?.softWrap,
    );
  }
}
