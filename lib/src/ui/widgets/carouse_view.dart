import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/index.dart';

final class DuitCarouselView extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute<CarouselViewAttributes> attributes;
  final List<Widget> children;

  const DuitCarouselView({
    super.key,
    required this.attributes,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithAttributes(
      context,
      attributes.payload,
    );

    return switch (attrs.constructor) {
      CarouselViewConstructor.common => CarouselView(
          key: Key(attributes.id),
          itemExtent: attrs.itemExtent,
          backgroundColor: attrs.backgroundColor,
          elevation: attrs.elevation,
          shape: attrs.shape,
          overlayColor: attrs.overlayColor,
          itemSnapping: attrs.itemSnapping,
          shrinkExtent: attrs.shrinkExtent,
          scrollDirection: attrs.scrollDirection,
          reverse: attrs.reverse,
          children: children,
        ),
      _ => throw UnimplementedError(
          "CarouselView.weighted constructor not implemented, available only in main channel https://github.com/flutter/flutter/issues/153002"),
      // CarouselViewConstructor.weighted => CarouselView.weighted(
      //     key: Key(attributes.id),
      //     flexWeights: attrs.flexWeights,
      //     consumeMaxWeight: attrs.consumeMaxWeight,
      //     reverse: attrs.reverse,
      //     children: children,
      //   ),
    };
  }
}

class DuitControlledCarouselView extends StatefulWidget
    with AnimatedAttributes {
  final UIElementController<CarouselViewAttributes> controller;
  final List<Widget> children;

  const DuitControlledCarouselView({
    super.key,
    required this.controller,
    required this.children,
  });

  @override
  State<DuitControlledCarouselView> createState() =>
      _DuitControlledCarouselViewState();
}

class _DuitControlledCarouselViewState extends State<DuitControlledCarouselView>
    with
        ViewControllerChangeListener<DuitControlledCarouselView,
            CarouselViewAttributes> {
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

    return switch (attrs.constructor) {
      CarouselViewConstructor.common => CarouselView(
          key: Key(widget.controller.id),
          itemExtent: attrs.itemExtent,
          backgroundColor: attrs.backgroundColor,
          elevation: attrs.elevation,
          shape: attrs.shape,
          overlayColor: attrs.overlayColor,
          itemSnapping: attrs.itemSnapping,
          shrinkExtent: attrs.shrinkExtent,
          scrollDirection: attrs.scrollDirection,
          reverse: attrs.reverse,
          children: widget.children,
        ),
      _ => throw UnimplementedError(
          "CarouselView.weighted constructor not implemented, available only in main channel https://github.com/flutter/flutter/issues/153002"),
      // CarouselViewConstructor.weighted => CarouselView.weighted(
      //     key: Key(attributes.id),
      //     flexWeights: attrs.flexWeights,
      //     consumeMaxWeight: attrs.consumeMaxWeight,
      //     reverse: attrs.reverse,
      //     children: children,
      //   ),
    };
  }
}
