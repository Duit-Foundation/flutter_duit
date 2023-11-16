import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/controller/index.dart";

final class DUITText extends StatelessWidget {
  final Attributes? attributes;

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

class _DUITControlledTextState extends State<DUITControlledText>
    implements ITextAttributes {
  @override
  late String data;
  @override
  late TextAlign? textAlign;
  @override
  late TextDirection? textDirection;
  @override
  late bool? softWrap;
  @override
  late TextOverflow? overflow;
  @override
  late double? textScaleFactor;
  @override
  late int? maxLines;
  @override
  late String? semanticsLabel;
  @override
  late TextStyle? style;

  // late TextAttributes? attrs;

  @override
  void initState() {
    final attributes = widget.controller?.attributes?.payload as TextAttributes?;
    data = attributes?.data ?? "";
    textAlign = attributes?.textAlign;
    textDirection = attributes?.textDirection;
    softWrap = attributes?.softWrap;
    overflow = attributes?.overflow;
    textScaleFactor = attributes?.textScaleFactor;
    maxLines = attributes?.maxLines;
    semanticsLabel = attributes?.semanticsLabel;
    style = attributes?.style;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    widget.controller?.addListener(() {
      setState(() {
        final newData = widget.controller?.attributes?.payload as TextAttributes?;
        data = newData?.data ?? "";
        textAlign = newData?.textAlign;
        textDirection = newData?.textDirection;
        softWrap = newData?.softWrap;
        overflow = newData?.overflow;
        textScaleFactor = newData?.textScaleFactor;
        maxLines = newData?.maxLines;
        semanticsLabel = newData?.semanticsLabel;
        style = newData?.style;
      });
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // widget.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: textAlign,
      textDirection: textDirection,
      style: style,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textScaleFactor: textScaleFactor,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}
