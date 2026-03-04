import "package:flutter/widgets.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitIcon extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;

  const DuitIcon({
    required this.attributes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithDataSource(context, attributes.payload);
    final iconData = attrs.iconData(key: "icon");
    if (iconData == null) {
      return const SizedBox.shrink(
        key: ValueKey("icon_empty"),
      );
    }
    return Icon(
      iconData,
      key: ValueKey(attributes.id),
      size: attrs.tryGetDouble(key: "size") ??
          attrs.tryGetDouble(key: "iconSize"),
      fill: attrs.tryGetDouble(key: "fill"),
      weight: attrs.tryGetDouble(key: "weight"),
      grade: attrs.tryGetDouble(key: "grade"),
      color: attrs.tryParseColor(key: "color"),
      textDirection: attrs.textDirection(),
      applyTextScaling: attrs.tryGetBool("applyTextScaling"),
      semanticLabel: attrs.tryGetString("semanticLabel"),
    );
  }
}

class DuitControlledIcon extends StatefulWidget with AnimatedAttributes {
  final UIElementController controller;

  const DuitControlledIcon({
    required this.controller,
    super.key,
  });

  @override
  State<DuitControlledIcon> createState() => _DuitControlledIconState();
}

class _DuitControlledIconState extends State<DuitControlledIcon>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.mergeWithDataSource(context, attributes);
    final iconData = attrs.iconData(key: "icon");
    if (iconData == null) {
      return const SizedBox.shrink(
        key: ValueKey("icon_empty"),
      );
    }
    return Icon(
      iconData,
      key: ValueKey(widget.controller.id),
      size: attrs.tryGetDouble(key: "size") ??
          attrs.tryGetDouble(key: "iconSize"),
      fill: attrs.tryGetDouble(key: "fill"),
      weight: attrs.tryGetDouble(key: "weight"),
      grade: attrs.tryGetDouble(key: "grade"),
      color: attrs.tryParseColor(key: "color"),
      textDirection: attrs.textDirection(),
      applyTextScaling: attrs.tryGetBool("applyTextScaling"),
      semanticLabel: attrs.tryGetString("semanticLabel"),
    );
  }
}
