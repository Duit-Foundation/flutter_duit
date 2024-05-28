import "dart:typed_data";

import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/animations/index.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";
import "package:flutter_duit/src/utils/image_type.dart";

sealed class _ImageProducer {
  static Widget memory(ImageAttributes? attrs, String id) {
    return Image.memory(
      key: Key(id),
      attrs?.byteData ?? Uint8List(0),
      fit: attrs?.fit,
      gaplessPlayback: attrs?.gaplessPlayback ?? false,
      excludeFromSemantics: attrs?.excludeFromSemantics ?? false,
      scale: attrs?.scale ?? 1.0,
      color: attrs?.color,
      colorBlendMode: attrs?.colorBlendMode,
      alignment: attrs?.alignment ?? Alignment.center,
      repeat: attrs?.repeat ?? ImageRepeat.noRepeat,
      matchTextDirection: attrs?.matchTextDirection ?? false,
      isAntiAlias: attrs?.isAntiAlias ?? false,
      filterQuality: attrs?.filterQuality ?? FilterQuality.low,
      cacheWidth: attrs?.cacheWidth,
      cacheHeight: attrs?.cacheHeight,
      width: attrs?.width,
      height: attrs?.height,
    );
  }

  static Widget asset(ImageAttributes? attrs, String id) {
    return Image.asset(
      key: Key(id),
      attrs?.src ?? "",
      fit: attrs?.fit,
      gaplessPlayback: attrs?.gaplessPlayback ?? false,
      excludeFromSemantics: attrs?.excludeFromSemantics ?? false,
      scale: attrs?.scale ?? 1.0,
      color: attrs?.color,
      colorBlendMode: attrs?.colorBlendMode,
      alignment: attrs?.alignment ?? Alignment.center,
      repeat: attrs?.repeat ?? ImageRepeat.noRepeat,
      matchTextDirection: attrs?.matchTextDirection ?? false,
      isAntiAlias: attrs?.isAntiAlias ?? false,
      filterQuality: attrs?.filterQuality ?? FilterQuality.low,
      cacheWidth: attrs?.cacheWidth,
      cacheHeight: attrs?.cacheHeight,
      width: attrs?.width,
      height: attrs?.height,
    );
  }

  static Widget network(ImageAttributes? attrs, String id) {
    return Image.network(
      key: Key(id),
      attrs?.src ?? "",
      fit: attrs?.fit,
      gaplessPlayback: attrs?.gaplessPlayback ?? false,
      excludeFromSemantics: attrs?.excludeFromSemantics ?? false,
      scale: attrs?.scale ?? 1.0,
      color: attrs?.color,
      colorBlendMode: attrs?.colorBlendMode,
      alignment: attrs?.alignment ?? Alignment.center,
      repeat: attrs?.repeat ?? ImageRepeat.noRepeat,
      matchTextDirection: attrs?.matchTextDirection ?? false,
      isAntiAlias: attrs?.isAntiAlias ?? false,
      filterQuality: attrs?.filterQuality ?? FilterQuality.low,
      cacheWidth: attrs?.cacheWidth,
      cacheHeight: attrs?.cacheHeight,
      width: attrs?.width,
      height: attrs?.height,
    );
  }
}

class DuitImage extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute<ImageAttributes> attributes;

  const DuitImage({
    super.key,
    required this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithAttributes(
      context,
      attributes.payload,
    );

    return switch (attrs.type) {
      ImageType.memory => _ImageProducer.memory(attrs, attributes.id),
      ImageType.asset => _ImageProducer.asset(attrs, attributes.id),
      ImageType.network => _ImageProducer.network(attrs, attributes.id),
    };
  }
}

class DuitControlledImage extends StatefulWidget with AnimatedAttributes {
  final UIElementController<ImageAttributes> controller;

  const DuitControlledImage({
    super.key,
    required this.controller,
  });

  @override
  State<DuitControlledImage> createState() => _DuitControlledImageState();
}

class _DuitControlledImageState extends State<DuitControlledImage>
    with ViewControllerChangeListener<DuitControlledImage, ImageAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.mergeWithController(
      context,
      widget.controller,
    );

    return switch (attrs.type) {
      ImageType.memory => _ImageProducer.memory(attrs, widget.controller.id),
      ImageType.asset => _ImageProducer.asset(attrs, widget.controller.id),
      ImageType.network => _ImageProducer.network(attrs, widget.controller.id),
    };
  }
}
