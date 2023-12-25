import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";

class DuitTransform extends StatelessWidget {
  final ViewAttributeWrapper attributes;
  final Widget child;

  const DuitTransform({
    super.key,
    required this.attributes,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;

    if (attrs is ScaleTransform) {
      return Transform.scale(
        scale: attrs.scale,
        scaleX: attrs.scaleX,
        scaleY: attrs.scaleY,
        origin: attrs.origin,
        alignment: attrs.alignment,
        transformHitTests: attrs.transformHitTests,
        filterQuality: attrs.filterQuality,
        child: child,
      );
    }

    if (attrs is RotateTransform) {
      return Transform.rotate(
        angle: attrs.angle ?? 0,
        origin: attrs.origin,
        alignment: attrs.alignment,
        transformHitTests: attrs.transformHitTests,
        filterQuality: attrs.filterQuality,
        child: child,
      );
    }

    if (attrs is TranslateTransform) {
      return Transform.translate(
        offset: attrs.offset ?? Offset.zero,
        transformHitTests: attrs.transformHitTests,
        filterQuality: attrs.filterQuality,
        child: child,
      );
    }

    if (attrs is FlipTransform) {
      return Transform.flip(
        flipX: attrs.flipX ?? false,
        flipY: attrs.flipY ?? false,
        transformHitTests: attrs.transformHitTests,
        filterQuality: attrs.filterQuality,
        origin: attrs.origin,
        child: child,
      );
    }

    return SizedBox.shrink(child: child);
  }
}
