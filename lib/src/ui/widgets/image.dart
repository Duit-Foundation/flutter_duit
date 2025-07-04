import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/animations/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";
import "package:flutter_duit/src/utils/image_type.dart";

sealed class _ImageProducer {
  static Widget memory(DuitDataSource attrs, String id) {
    return Image.memory(
      key: Key(id),
      attrs.uint8List(key: "byteData"),
      fit: attrs.boxFit(),
      gaplessPlayback: attrs.getBool("gaplessPlayback"),
      excludeFromSemantics: attrs.getBool("excludeFromSemantics"),
      scale: attrs.getDouble(key: "scale", defaultValue: 1.0),
      color: attrs.tryParseColor(),
      colorBlendMode: attrs.blendMode(),
      alignment: attrs.alignment(defaultValue: Alignment.center)!,
      repeat: attrs.imageRepeat(),
      matchTextDirection: attrs.getBool("matchTextDirection"),
      isAntiAlias: attrs.getBool("isAntiAlias"),
      filterQuality: attrs.filterQuality(),
      cacheWidth: attrs.tryGetInt(key: "cacheWidth"),
      cacheHeight: attrs.tryGetInt(key: "cacheHeight"),
      width: attrs.tryGetDouble(key: "width"),
      height: attrs.tryGetDouble(key: "height"),
    );
  }

  static Widget asset(DuitDataSource attrs, String id) {
    return Image.asset(
      key: Key(id),
      attrs.getString(key: "src"),
      fit: attrs.boxFit(),
      gaplessPlayback: attrs.getBool("gaplessPlayback"),
      excludeFromSemantics: attrs.getBool("excludeFromSemantics"),
      scale: attrs.getDouble(key: "scale", defaultValue: 1.0),
      color: attrs.tryParseColor(),
      colorBlendMode: attrs.blendMode(),
      alignment: attrs.alignment(defaultValue: Alignment.center)!,
      repeat: attrs.imageRepeat(),
      matchTextDirection: attrs.getBool("matchTextDirection"),
      isAntiAlias: attrs.getBool("isAntiAlias"),
      filterQuality: attrs.filterQuality(),
      cacheWidth: attrs.tryGetInt(key: "cacheWidth"),
      cacheHeight: attrs.tryGetInt(key: "cacheHeight"),
      width: attrs.tryGetDouble(key: "width"),
      height: attrs.tryGetDouble(key: "height"),
    );
  }

  static Widget network(DuitDataSource attrs, String id) {
    return Image.network(
      key: Key(id),
      attrs.getString(key: "src"),
      fit: attrs.boxFit(),
      gaplessPlayback: attrs.getBool("gaplessPlayback"),
      excludeFromSemantics: attrs.getBool("excludeFromSemantics"),
      scale: attrs.getDouble(key: "scale", defaultValue: 1.0),
      color: attrs.tryParseColor(),
      colorBlendMode: attrs.blendMode(),
      alignment: attrs.alignment(defaultValue: Alignment.center)!,
      repeat: attrs.imageRepeat(),
      matchTextDirection: attrs.getBool("matchTextDirection"),
      isAntiAlias: attrs.getBool("isAntiAlias"),
      filterQuality: attrs.filterQuality(),
      cacheWidth: attrs.tryGetInt(key: "cacheWidth"),
      cacheHeight: attrs.tryGetInt(key: "cacheHeight"),
      width: attrs.tryGetDouble(key: "width"),
      height: attrs.tryGetDouble(key: "height"),
    );
  }
}

class DuitImage extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;

  const DuitImage({
    super.key,
    required this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithDataSource(
      context,
      attributes.payload,
    );

    final type = ImageType.fromString(attrs.getString(key: "type"));

    return switch (type) {
      ImageType.memory => _ImageProducer.memory(attrs, attributes.id),
      ImageType.asset => _ImageProducer.asset(attrs, attributes.id),
      ImageType.network => _ImageProducer.network(attrs, attributes.id),
    };
  }
}

class DuitControlledImage extends StatefulWidget with AnimatedAttributes {
  final UIElementController controller;

  const DuitControlledImage({
    super.key,
    required this.controller,
  });

  @override
  State<DuitControlledImage> createState() => _DuitControlledImageState();
}

class _DuitControlledImageState extends State<DuitControlledImage>
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

    final type = ImageType.fromString(attrs.getString(key: "type"));

    return switch (type) {
      ImageType.memory => _ImageProducer.memory(attrs, widget.controller.id),
      ImageType.asset => _ImageProducer.asset(attrs, widget.controller.id),
      ImageType.network => _ImageProducer.network(attrs, widget.controller.id),
    };
  }
}
