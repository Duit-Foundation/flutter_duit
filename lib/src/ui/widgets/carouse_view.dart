import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/ui/models/carousel_constructor.dart';

final class DuitCarouselView extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;
  final List<Widget> children;

  const DuitCarouselView({
    super.key,
    required this.attributes,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithDataSource(
      context,
      DuitDataSource(attributes.payload),
    );

    final type = CarouselViewConstructor.fromValue(attrs["constructor"]);

    return switch (type) {
      CarouselViewConstructor.common => CarouselView(
          key: Key(attributes.id),
          itemExtent: attrs.getDouble(key: "itemExtent"),
          backgroundColor: attrs.tryParseColor(key: "backgroundColor"),
          elevation: attrs.tryGetDouble(key: "elevation"),
          shape: attrs.shapeBorder(),
          overlayColor: attrs.widgetStateProperty<Color>(key: "overlayColor"),
          itemSnapping: attrs.getBool(
            "itemSnapping",
            defaultValue: false,
          ),
          shrinkExtent: attrs.getDouble(key: "shrinkExtent"),
          scrollDirection: attrs.axis(),
          reverse: attrs.getBool(
            "reverse",
            defaultValue: false,
          ),
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
  final UIElementController controller;
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

    final type = CarouselViewConstructor.fromValue(attrs["constructor"]);

    return switch (type) {
      CarouselViewConstructor.common => CarouselView(
          key: Key(widget.controller.id),
          itemExtent: attrs.getDouble(key: "itemExtent"),
          backgroundColor: attrs.tryParseColor(key: "backgroundColor"),
          elevation: attrs.tryGetDouble(key: "elevation"),
          shape: attrs.shapeBorder(),
          overlayColor: attrs.widgetStateProperty<Color>(key: "overlayColor"),
          itemSnapping: attrs.getBool(
            "itemSnapping",
            defaultValue: false,
          ),
          shrinkExtent: attrs.getDouble(key: "shrinkExtent"),
          scrollDirection: attrs.axis(),
          reverse: attrs.getBool(
            "reverse",
            defaultValue: false,
          ),
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
