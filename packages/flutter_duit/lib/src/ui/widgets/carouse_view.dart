import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

final class DuitCarouselView extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;
  final List<Widget> children;

  const DuitCarouselView({
    required this.attributes,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithDataSource(
      context,
      attributes.payload,
    );

    return CarouselView(
      key: Key(attributes.id),
      padding: attrs.edgeInsets(),
      itemExtent: attrs.getDouble(key: "itemExtent"),
      backgroundColor: attrs.tryParseColor(key: "backgroundColor"),
      elevation: attrs.tryGetDouble(key: "elevation"),
      shape: attrs.shapeBorder(),
      overlayColor: attrs.widgetStateProperty<Color>(key: "overlayColor"),
      itemSnapping: attrs.getBool("itemSnapping", defaultValue: false),
      shrinkExtent: attrs.getDouble(key: "shrinkExtent"),
      scrollDirection: attrs.axis(defaultValue: Axis.horizontal),
      reverse: attrs.getBool("reverse"),
      children: children,
    );
  }
}

class DuitControlledCarouselView extends StatefulWidget
    with AnimatedAttributes {
  final UIElementController controller;
  final List<Widget> children;

  const DuitControlledCarouselView({
    required this.controller,
    required this.children,
    super.key,
  });

  @override
  State<DuitControlledCarouselView> createState() =>
      _DuitControlledCarouselViewState();
}

class _DuitControlledCarouselViewState extends State<DuitControlledCarouselView>
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

    return CarouselView(
      key: Key(widget.controller.id),
      padding: attrs.edgeInsets(),
      itemExtent: attrs.getDouble(key: "itemExtent"),
      backgroundColor: attrs.tryParseColor(key: "backgroundColor"),
      elevation: attrs.tryGetDouble(key: "elevation"),
      shape: attrs.shapeBorder(),
      overlayColor: attrs.widgetStateProperty<Color>(key: "overlayColor"),
      itemSnapping: attrs.getBool("itemSnapping", defaultValue: true),
      shrinkExtent: attrs.getDouble(key: "shrinkExtent"),
      scrollDirection: attrs.axis(defaultValue: Axis.horizontal),
      reverse: attrs.getBool("reverse"),
      children: widget.children,
    );
  }
}
