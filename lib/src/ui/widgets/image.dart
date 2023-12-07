import "dart:typed_data";

import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/controller/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";
import "package:flutter_duit/src/utils/image_type.dart";

class DUITImage extends StatelessWidget {
  final ViewAttributeWrapper? attributes;

  const DUITImage({
    super.key,
    this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes?.payload as ImageAttributes?;
    return switch (attrs?.type) {
      ImageType.memory => Image.memory(
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
        ),
      ImageType.asset => Image.asset(
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
        ),
      ImageType.network => Image.network(
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
        ),
      null => const SizedBox.shrink(),
    };
  }
}

class DUITControlledImage extends StatefulWidget {
  final UIElementController? controller;

  const DUITControlledImage({
    super.key,
    this.controller,
  });

  @override
  State<DUITControlledImage> createState() => _DUITControlledImageState();
}

class _DUITControlledImageState extends State<DUITControlledImage>
    with ViewControllerChangeListener<DUITControlledImage, ImageAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return switch (attributes?.type) {
      ImageType.memory => Image.memory(
          attributes?.byteData ?? Uint8List(0),
          fit: attributes?.fit,
          gaplessPlayback: attributes?.gaplessPlayback ?? false,
          excludeFromSemantics: attributes?.excludeFromSemantics ?? false,
          scale: attributes?.scale ?? 1.0,
          color: attributes?.color,
          colorBlendMode: attributes?.colorBlendMode,
          alignment: attributes?.alignment ?? Alignment.center,
          repeat: attributes?.repeat ?? ImageRepeat.noRepeat,
          matchTextDirection: attributes?.matchTextDirection ?? false,
          isAntiAlias: attributes?.isAntiAlias ?? false,
          filterQuality: attributes?.filterQuality ?? FilterQuality.low,
          cacheWidth: attributes?.cacheWidth,
          cacheHeight: attributes?.cacheHeight,
          width: attributes?.width,
          height: attributes?.height,
        ),
      ImageType.asset => Image.asset(
          attributes?.src ?? "",
          fit: attributes?.fit,
          gaplessPlayback: attributes?.gaplessPlayback ?? false,
          excludeFromSemantics: attributes?.excludeFromSemantics ?? false,
          scale: attributes?.scale ?? 1.0,
          color: attributes?.color,
          colorBlendMode: attributes?.colorBlendMode,
          alignment: attributes?.alignment ?? Alignment.center,
          repeat: attributes?.repeat ?? ImageRepeat.noRepeat,
          matchTextDirection: attributes?.matchTextDirection ?? false,
          isAntiAlias: attributes?.isAntiAlias ?? false,
          filterQuality: attributes?.filterQuality ?? FilterQuality.low,
          cacheWidth: attributes?.cacheWidth,
          cacheHeight: attributes?.cacheHeight,
          width: attributes?.width,
          height: attributes?.height,
        ),
      ImageType.network => Image.network(
          attributes?.src ?? "",
          fit: attributes?.fit,
          gaplessPlayback: attributes?.gaplessPlayback ?? false,
          excludeFromSemantics: attributes?.excludeFromSemantics ?? false,
          scale: attributes?.scale ?? 1.0,
          color: attributes?.color,
          colorBlendMode: attributes?.colorBlendMode,
          alignment: attributes?.alignment ?? Alignment.center,
          repeat: attributes?.repeat ?? ImageRepeat.noRepeat,
          matchTextDirection: attributes?.matchTextDirection ?? false,
          isAntiAlias: attributes?.isAntiAlias ?? false,
          filterQuality: attributes?.filterQuality ?? FilterQuality.low,
          cacheWidth: attributes?.cacheWidth,
          cacheHeight: attributes?.cacheHeight,
          width: attributes?.width,
          height: attributes?.height,
        ),
      null => const SizedBox.shrink(),
    };
  }
}
